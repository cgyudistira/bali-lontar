import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as img;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../data/database_helper.dart';
import '../models/saved_result.dart';
import '../models/result_type.dart';

/// Service for managing persistent storage of OCR results, translations, and user data
class StorageService {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  /// Save a result to the database
  /// Returns the ID of the saved result
  Future<String> saveResult(SavedResult result) async {
    try {
      final db = await _dbHelper.database;
      await db.insert(
        'results',
        result.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return result.id;
    } catch (e) {
      throw StorageException('Failed to save result: $e');
    }
  }

  /// Get a specific result by ID
  /// Returns null if not found
  Future<SavedResult?> getResult(String id) async {
    try {
      final db = await _dbHelper.database;
      final maps = await db.query(
        'results',
        where: 'id = ?',
        whereArgs: [id],
        limit: 1,
      );

      if (maps.isEmpty) {
        return null;
      }

      return SavedResult.fromMap(maps.first);
    } catch (e) {
      throw StorageException('Failed to get result: $e');
    }
  }

  /// Get all results with optional pagination
  /// Returns results in reverse chronological order (newest first)
  Future<List<SavedResult>> getAllResults({
    int? limit,
    int? offset,
    ResultType? filterByType,
  }) async {
    try {
      final db = await _dbHelper.database;
      
      String? where;
      List<dynamic>? whereArgs;
      
      if (filterByType != null) {
        where = 'type = ?';
        whereArgs = [filterByType.toJson()];
      }

      final maps = await db.query(
        'results',
        where: where,
        whereArgs: whereArgs,
        orderBy: 'timestamp DESC',
        limit: limit,
        offset: offset,
      );

      return maps.map((map) => SavedResult.fromMap(map)).toList();
    } catch (e) {
      throw StorageException('Failed to get all results: $e');
    }
  }

  /// Get the total count of results
  Future<int> getResultCount({ResultType? filterByType}) async {
    try {
      final db = await _dbHelper.database;
      
      String? where;
      List<dynamic>? whereArgs;
      
      if (filterByType != null) {
        where = 'type = ?';
        whereArgs = [filterByType.toJson()];
      }

      final result = await db.query(
        'results',
        columns: ['COUNT(*) as count'],
        where: where,
        whereArgs: whereArgs,
      );

      return Sqflite.firstIntValue(result) ?? 0;
    } catch (e) {
      throw StorageException('Failed to get result count: $e');
    }
  }

  /// Delete a specific result by ID
  Future<void> deleteResult(String id) async {
    try {
      final db = await _dbHelper.database;
      
      // Get the result first to check if it has an associated image
      final result = await getResult(id);
      
      // Delete from database
      final deletedCount = await db.delete(
        'results',
        where: 'id = ?',
        whereArgs: [id],
      );

      if (deletedCount == 0) {
        throw StorageException('Result not found: $id');
      }

      // Delete associated image file if it exists
      if (result?.imagePath != null) {
        try {
          final imageFile = File(result!.imagePath!);
          if (await imageFile.exists()) {
            await imageFile.delete();
          }
        } catch (e) {
          // Log but don't throw - database deletion succeeded
          print('Warning: Failed to delete image file: $e');
        }
      }
    } catch (e) {
      if (e is StorageException) rethrow;
      throw StorageException('Failed to delete result: $e');
    }
  }

  /// Delete multiple results by their IDs
  Future<void> deleteMultiple(List<String> ids) async {
    if (ids.isEmpty) return;

    try {
      final db = await _dbHelper.database;
      
      // Get all results first to check for associated images
      final results = await Future.wait(
        ids.map((id) => getResult(id)),
      );

      // Delete from database using batch operation
      final batch = db.batch();
      for (final id in ids) {
        batch.delete(
          'results',
          where: 'id = ?',
          whereArgs: [id],
        );
      }
      await batch.commit(noResult: true);

      // Delete associated image files
      for (final result in results) {
        if (result?.imagePath != null) {
          try {
            final imageFile = File(result!.imagePath!);
            if (await imageFile.exists()) {
              await imageFile.delete();
            }
          } catch (e) {
            // Log but don't throw - database deletion succeeded
            print('Warning: Failed to delete image file: $e');
          }
        }
      }
    } catch (e) {
      throw StorageException('Failed to delete multiple results: $e');
    }
  }

  /// Delete all results
  Future<void> deleteAll() async {
    try {
      final db = await _dbHelper.database;
      
      // Get all results to delete associated images
      final results = await getAllResults();
      
      // Delete all from database
      await db.delete('results');

      // Delete all associated image files
      for (final result in results) {
        if (result.imagePath != null) {
          try {
            final imageFile = File(result.imagePath!);
            if (await imageFile.exists()) {
              await imageFile.delete();
            }
          } catch (e) {
            print('Warning: Failed to delete image file: $e');
          }
        }
      }
    } catch (e) {
      throw StorageException('Failed to delete all results: $e');
    }
  }

  /// Search results by text content with optional date filtering
  /// Searches in both source_text and result_text fields
  Future<List<SavedResult>> searchResults(
    String query, {
    DateTime? startDate,
    DateTime? endDate,
    ResultType? filterByType,
    int? limit,
    int? offset,
  }) async {
    try {
      final db = await _dbHelper.database;
      
      // Build WHERE clause
      final whereConditions = <String>[];
      final whereArgs = <dynamic>[];

      // Text search condition
      if (query.isNotEmpty) {
        whereConditions.add('(source_text LIKE ? OR result_text LIKE ?)');
        final searchPattern = '%$query%';
        whereArgs.add(searchPattern);
        whereArgs.add(searchPattern);
      }

      // Date range filtering
      if (startDate != null) {
        whereConditions.add('timestamp >= ?');
        whereArgs.add(startDate.millisecondsSinceEpoch);
      }

      if (endDate != null) {
        whereConditions.add('timestamp <= ?');
        whereArgs.add(endDate.millisecondsSinceEpoch);
      }

      // Type filtering
      if (filterByType != null) {
        whereConditions.add('type = ?');
        whereArgs.add(filterByType.toJson());
      }

      final where = whereConditions.isNotEmpty 
          ? whereConditions.join(' AND ') 
          : null;

      final maps = await db.query(
        'results',
        where: where,
        whereArgs: whereArgs.isNotEmpty ? whereArgs : null,
        orderBy: 'timestamp DESC',
        limit: limit,
        offset: offset,
      );

      return maps.map((map) => SavedResult.fromMap(map)).toList();
    } catch (e) {
      throw StorageException('Failed to search results: $e');
    }
  }

  /// Get results within a specific date range
  Future<List<SavedResult>> getResultsByDateRange(
    DateTime startDate,
    DateTime endDate, {
    ResultType? filterByType,
    int? limit,
    int? offset,
  }) async {
    return searchResults(
      '',
      startDate: startDate,
      endDate: endDate,
      filterByType: filterByType,
      limit: limit,
      offset: offset,
    );
  }

  /// Save an image file to the app documents directory
  /// Organizes images by date in folder structure (YYYY/MM/DD)
  /// Returns the path to the saved image
  Future<String> saveImage(File imageFile, String resultId) async {
    try {
      final appDir = await getApplicationDocumentsDirectory();
      final now = DateTime.now();
      
      // Create date-based folder structure
      final dateFolder = path.join(
        appDir.path,
        'images',
        now.year.toString(),
        now.month.toString().padLeft(2, '0'),
        now.day.toString().padLeft(2, '0'),
      );

      // Create directory if it doesn't exist
      final directory = Directory(dateFolder);
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }

      // Generate filename with result ID and timestamp
      final extension = path.extension(imageFile.path);
      final filename = '${resultId}_${now.millisecondsSinceEpoch}$extension';
      final targetPath = path.join(dateFolder, filename);

      // Copy the image file
      final savedFile = await imageFile.copy(targetPath);
      
      return savedFile.path;
    } catch (e) {
      throw StorageException('Failed to save image: $e');
    }
  }

  /// Generate a thumbnail for an image
  /// Returns the path to the thumbnail file
  Future<String> generateThumbnail(
    String imagePath,
    String resultId, {
    int size = 200,
  }) async {
    try {
      final imageFile = File(imagePath);
      if (!await imageFile.exists()) {
        throw StorageException('Image file not found: $imagePath');
      }

      // Read and decode the image
      final bytes = await imageFile.readAsBytes();
      final image = img.decodeImage(bytes);
      
      if (image == null) {
        throw StorageException('Failed to decode image');
      }

      // Create thumbnail
      final thumbnail = img.copyResize(
        image,
        width: size,
        height: size,
        maintainAspect: true,
      );

      // Save thumbnail in the same directory as the original
      final directory = path.dirname(imagePath);
      final extension = path.extension(imagePath);
      final thumbnailFilename = '${resultId}_thumb$extension';
      final thumbnailPath = path.join(directory, thumbnailFilename);

      // Encode and save
      final thumbnailFile = File(thumbnailPath);
      if (extension.toLowerCase() == '.png') {
        await thumbnailFile.writeAsBytes(img.encodePng(thumbnail));
      } else {
        await thumbnailFile.writeAsBytes(img.encodeJpg(thumbnail, quality: 85));
      }

      return thumbnailPath;
    } catch (e) {
      if (e is StorageException) rethrow;
      throw StorageException('Failed to generate thumbnail: $e');
    }
  }

  /// Get the thumbnail path for a result
  /// Returns null if thumbnail doesn't exist
  Future<String?> getThumbnailPath(String imagePath) async {
    try {
      final directory = path.dirname(imagePath);
      final filename = path.basenameWithoutExtension(imagePath);
      final extension = path.extension(imagePath);
      
      // Extract result ID from filename (format: resultId_timestamp)
      final parts = filename.split('_');
      if (parts.isEmpty) return null;
      
      final resultId = parts[0];
      final thumbnailFilename = '${resultId}_thumb$extension';
      final thumbnailPath = path.join(directory, thumbnailFilename);

      final thumbnailFile = File(thumbnailPath);
      if (await thumbnailFile.exists()) {
        return thumbnailPath;
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  /// Delete an image file and its thumbnail
  Future<void> deleteImage(String imagePath) async {
    try {
      // Delete main image
      final imageFile = File(imagePath);
      if (await imageFile.exists()) {
        await imageFile.delete();
      }

      // Delete thumbnail if it exists
      final thumbnailPath = await getThumbnailPath(imagePath);
      if (thumbnailPath != null) {
        final thumbnailFile = File(thumbnailPath);
        if (await thumbnailFile.exists()) {
          await thumbnailFile.delete();
        }
      }
    } catch (e) {
      throw StorageException('Failed to delete image: $e');
    }
  }

  /// Get the total size of all stored images in bytes
  Future<int> getStorageSize() async {
    try {
      final appDir = await getApplicationDocumentsDirectory();
      final imagesDir = Directory(path.join(appDir.path, 'images'));

      if (!await imagesDir.exists()) {
        return 0;
      }

      int totalSize = 0;
      await for (final entity in imagesDir.list(recursive: true)) {
        if (entity is File) {
          totalSize += await entity.length();
        }
      }

      return totalSize;
    } catch (e) {
      throw StorageException('Failed to calculate storage size: $e');
    }
  }

  /// Close the database connection
  Future<void> close() async {
    await _dbHelper.close();
  }
}

/// Custom exception for storage-related errors
class StorageException implements Exception {
  final String message;

  StorageException(this.message);

  @override
  String toString() => 'StorageException: $message';
}
