# Implementation Plan

- [x] 1. Set up Flutter project structure and dependencies






  - Create Flutter project with proper folder structure (lib/screens, lib/services, lib/widgets, lib/data, assets)
  - Configure pubspec.yaml with required dependencies: image, sqflite, path_provider, file_picker, image_picker, pdf, provider/riverpod
  - Set up Material Design 3 theme with Balinese-inspired color palette
  - Configure Android and iOS permissions for camera and storage
  - _Requirements: 17.1, 17.2, 17.3, 17.4, 17.5_

- [x] 2. Create JSON mapping and dictionary data files





  - [x] 2.1 Create bali_mapping.json with complete Aksara Bali character mappings

    - Define base characters, consonants, pasangan, sandangan, and numerals
    - Include bidirectional mappings (Bali to Latin and Latin to Bali)
    - Add character categories and alternatives
    - _Requirements: 18.1, 5.1, 5.2, 5.3, 6.1, 6.2, 6.3_

  - [x] 2.2 Create kawi_mapping.json with Aksara Kawi character mappings


    - Define Kawi character set with Latin equivalents
    - Include Kawi-specific variants and bidirectional mappings
    - _Requirements: 18.2, 7.1, 7.2, 7.5_
  - [x] 2.3 Create dictionary_bali_id.json with Balinese-Indonesian translations


    - Add 100+ common Balinese words with Indonesian translations
    - Include part of speech, definitions, examples, and frequency data
    - Structure entries for efficient lookup
    - _Requirements: 18.3, 8.1, 8.2, 8.4, 9.1, 9.2, 9.5_

  - [x] 2.4 Create dictionary_kawi_id.json with Kawi-Indonesian translations

    - Add 80+ common Kawi words with Indonesian translations
    - Include archaic meanings and Sanskrit loanword information
    - _Requirements: 18.4, 10.1, 10.2, 10.3_

- [x] 3. Implement Storage Service for data persistence



  - [x] 3.1 Create SavedResult and related data models


    - Define SavedResult class with id, timestamp, type, texts, and metadata
    - Create ResultType and ScriptType enums
    - _Requirements: 11.1, 11.2, 11.3, 11.4_
  - [x] 3.2 Implement SQLite database schema and initialization


    - Create results table with proper indexes
    - Implement database initialization and migration logic
    - _Requirements: 11.1, 11.2, 11.3, 11.4, 16.5_
  - [x] 3.3 Implement CRUD operations for saved results


    - Write saveResult, getResult, getAllResults, deleteResult, deleteMultiple methods
    - Implement pagination for getAllResults
    - Add error handling for database operations
    - _Requirements: 11.1, 11.2, 11.3, 11.4, 11.5, 16.4, 16.5_
  - [x] 3.4 Implement search functionality for results


    - Create searchResults method with text content filtering
    - Add date-based filtering support
    - _Requirements: 16.2_
  - [x] 3.5 Implement image file management


    - Create methods to save images to app documents directory
    - Organize images by date in folder structure
    - Generate thumbnails for list views
    - _Requirements: 1.2, 11.1_
  - [x] 3.6 Implement export functionality to TXT and PDF



    - Create exportToTxt method generating plain text with metadata
    - Create exportToPdf method generating formatted PDF documents
    - Include original image in PDF exports when available
    - _Requirements: 12.1, 12.2, 12.3_

- [x] 4. Implement Transliteration Service





  - [x] 4.1 Create transliteration data models and enums


    - Define TransliterationMode enum with all conversion modes
    - Create MappingEntry and TransliterationOption classes
    - _Requirements: 5.1, 6.1, 7.1_
  - [x] 4.2 Implement JSON mapping file loader


    - Create loadMappings method to read bali_mapping.json and kawi_mapping.json
    - Parse JSON into in-memory data structures for fast lookup
    - Implement error handling for missing or malformed files
    - _Requirements: 18.1, 18.2, 18.5_
  - [x] 4.3 Implement Bali to Latin transliteration algorithm


    - Tokenize Aksara Bali input into character sequences
    - Handle pasangan (consonant conjuncts) recognition
    - Apply sandangan (diacritical marks) to base characters
    - Map characters to Latin equivalents using loaded mappings
    - _Requirements: 5.1, 5.2, 5.3, 5.4, 5.5_
  - [x] 4.4 Implement Latin to Bali transliteration algorithm


    - Tokenize Latin input into syllables
    - Map consonants and vowels to Aksara Bali characters
    - Generate pasangan for consonant clusters
    - Apply sandangan for vowel modifications
    - _Requirements: 6.1, 6.2, 6.3, 6.4, 6.5_
  - [x] 4.5 Implement Kawi to Latin and Latin to Kawi transliteration


    - Create Kawi-specific transliteration logic using kawi_mapping.json
    - Handle Kawi character variants and punctuation preservation
    - Implement bidirectional conversion
    - _Requirements: 7.1, 7.2, 7.4, 7.5_
  - [x] 4.6 Implement getAlternatives method for ambiguous transliterations


    - Identify ambiguous character sequences
    - Return multiple transliteration options with explanations
    - _Requirements: 6.4_

- [x] 5. Implement Dictionary Service for translations



  - [x] 5.1 Create translation data models


    - Define Translation and DictionaryEntry classes
    - Include fields for word, translation, part of speech, definitions, examples
    - _Requirements: 8.2, 9.2, 10.2_
  - [x] 5.2 Implement dictionary file loader


    - Create loadDictionaries method to read dictionary JSON files
    - Build in-memory index by first letter for fast lookup
    - Cache frequently accessed entries
    - _Requirements: 18.3, 18.4_
  - [x] 5.3 Implement word lookup with fuzzy matching


    - Create translate method for single word lookup
    - Implement stemming for affixed words
    - Add fuzzy matching using Levenshtein distance for near-matches
    - Return translations with confidence scores
    - _Requirements: 8.1, 8.2, 8.3, 9.1, 9.2, 10.1, 10.4_
  - [x] 5.4 Implement phrase translation


    - Create translatePhrase method for multi-word input
    - Check for multi-word expressions in dictionary
    - Fall back to word-by-word translation
    - _Requirements: 8.4_
  - [x] 5.5 Implement getSuggestions for autocomplete


    - Create method to return word suggestions based on partial input
    - Use dictionary index for efficient prefix matching
    - _Requirements: 9.2_
  - [x] 5.6 Handle multiple translations and context


    - Return all translation options when multiple exist
    - Use frequency data to rank translations
    - Provide part of speech for disambiguation
    - _Requirements: 9.2, 9.4, 9.5, 10.2, 10.3_

- [ ] 6. Implement OCR Service with image preprocessing
  - [ ] 6.1 Create OCR data models
    - Define OCRResult class with recognized text, confidence, character boxes
    - Create CharacterBox class with bounding box and character info
    - Define ScriptType enum for different script variants
    - _Requirements: 3.1, 3.2, 3.3, 4.1, 4.2_
  - [ ] 6.2 Implement image preprocessing pipeline
    - Create preprocessImage method with grayscale conversion
    - Implement adaptive thresholding for text separation
    - Add noise reduction filtering
    - Implement rotation detection and correction
    - _Requirements: 2.1, 2.2, 2.3, 2.4, 2.5_
  - [ ] 6.3 Implement script type detection
    - Create detectScriptType method to identify Bali vs Kawi scripts
    - Use character shape analysis and pattern matching
    - Return detected script type with confidence
    - _Requirements: 4.2, 4.3, 4.4_
  - [ ] 6.4 Implement character segmentation
    - Detect connected components in preprocessed image
    - Filter components by size to remove noise
    - Sort character regions left-to-right, top-to-bottom
    - Extract bounding boxes for each character
    - _Requirements: 3.4, 3.5_
  - [ ] 6.5 Implement mock character recognition with pattern matching
    - Create simplified template matching for demo purposes
    - Compare segmented characters against basic templates
    - Return recognized characters with confidence scores
    - Handle pasangan and sandangan recognition
    - _Requirements: 3.1, 3.2, 3.3, 3.4, 3.5, 4.1, 4.4_
  - [ ] 6.6 Implement processImage main method
    - Orchestrate preprocessing, segmentation, and recognition
    - Combine character results into full text
    - Return OCRResult with all metadata
    - _Requirements: 3.1, 3.2, 3.3, 4.1_

- [ ] 7. Create reusable UI widgets
  - [ ] 7.1 Create TextCard widget for displaying results
    - Design card with title, content, and action buttons
    - Support selectable text and copy functionality
    - Add confidence indicator display
    - _Requirements: 15.1, 15.2, 15.4_
  - [ ] 7.2 Create ScanButton widget for image capture
    - Design button with camera and gallery options
    - Add visual feedback on press
    - _Requirements: 1.1, 1.3, 15.4_
  - [ ] 7.3 Create ResultViewer widget for OCR results
    - Display original and processed images side-by-side
    - Show recognized text with character alignment
    - Include zoom functionality for images
    - _Requirements: 2.5, 5.5, 15.1_

- [ ] 8. Implement Home Screen
  - Create home_screen.dart with welcome message and app description
  - Add four main action cards: Scan & OCR, Transliterate, Translate, View History
  - Display quick stats showing total scans and saved results
  - Implement navigation to other screens
  - Add settings icon in app bar
  - _Requirements: 15.1, 15.2, 15.3, 15.4_

- [ ] 9. Implement OCR Screen
  - [ ] 9.1 Create OCR screen UI layout
    - Add camera and gallery selection buttons
    - Create image preview area with zoom support
    - Add process button and loading indicator
    - Design results display area
    - _Requirements: 1.1, 1.3, 1.4, 15.1, 15.3, 15.4_
  - [ ] 9.2 Implement image capture and selection
    - Integrate image_picker for camera and gallery access
    - Handle image selection and display preview
    - Validate image format and size
    - _Requirements: 1.1, 1.2, 1.3, 1.4, 1.5_
  - [ ] 9.3 Integrate OCR Service and display results
    - Call OCR Service processImage method
    - Display recognized text with confidence scores
    - Show original and processed images
    - Handle OCR errors gracefully
    - _Requirements: 3.1, 3.2, 3.3, 4.1, 4.4_
  - [ ] 9.4 Implement result actions
    - Add Save button to store result using Storage Service
    - Add Transliterate button to navigate to transliteration with OCR text
    - Add Translate button to navigate to translation with OCR text
    - Add Share button using system share sheet
    - Add Export button for TXT/PDF export
    - _Requirements: 11.1, 12.1, 12.2, 12.4, 13.1, 13.2_

- [ ] 10. Implement Transliteration Screen
  - [ ] 10.1 Create transliteration screen UI
    - Add input method selector (Type/Paste/From OCR)
    - Create source and target script selectors
    - Add input text area with proper font support
    - Add transliterate button
    - Design results display with alternatives section
    - _Requirements: 15.1, 15.3_
  - [ ] 10.2 Integrate Transliteration Service
    - Call transliterate method based on selected mode
    - Display transliteration results
    - Show alternative transliterations when available
    - Handle errors and unknown characters
    - _Requirements: 5.1, 5.2, 5.3, 5.4, 5.5, 6.1, 6.2, 6.3, 6.4, 6.5, 7.1, 7.2, 7.4, 7.5_
  - [ ] 10.3 Implement result actions
    - Add Save button to store transliteration result
    - Add Translate button to pass result to translation screen
    - Add Share and Copy buttons
    - _Requirements: 11.2, 13.1, 13.4_

- [ ] 11. Implement Translation Screen
  - [ ] 11.1 Create translation screen UI
    - Add input method selector
    - Create language pair selector (Bali-ID, ID-Bali, Kawi-ID)
    - Add input text area
    - Add translate button
    - Design results display with word-by-word breakdown
    - _Requirements: 15.1, 15.3_
  - [ ] 11.2 Integrate Dictionary Service
    - Call translate or translatePhrase based on input
    - Display translations with definitions and examples
    - Show multiple translation options when available
    - Highlight untranslated words
    - _Requirements: 8.1, 8.2, 8.3, 8.4, 8.5, 9.1, 9.2, 9.4, 9.5, 10.1, 10.2, 10.3, 10.4, 10.5_
  - [ ] 11.3 Implement result actions
    - Add Save button to store translation result
    - Add Share and Copy buttons
    - _Requirements: 11.3, 13.1_

- [ ] 12. Implement History Screen
  - [ ] 12.1 Create history screen UI with list view
    - Design result cards with thumbnails and preview text
    - Add filter chips for result type (OCR/Transliteration/Translation)
    - Create search bar for text content search
    - Add sort options (date, type)
    - _Requirements: 11.5, 15.1, 15.3, 16.1, 16.2_
  - [ ] 12.2 Integrate Storage Service for result listing
    - Load results using getAllResults with pagination
    - Implement pull-to-refresh functionality
    - Display results in reverse chronological order
    - _Requirements: 11.5, 16.1_
  - [ ] 12.3 Implement search and filter functionality
    - Connect search bar to Storage Service searchResults method
    - Implement filter by result type
    - Update list view based on search/filter criteria
    - _Requirements: 16.2_
  - [ ] 12.4 Implement result detail view and actions
    - Create detail screen showing full result on tap
    - Add re-export option for saved results
    - Implement swipe-to-delete gesture
    - Add batch selection mode for multi-delete
    - _Requirements: 16.3, 16.4, 16.5_

- [ ] 13. Implement navigation and app structure
  - Create main.dart with app initialization
  - Set up bottom tab navigation for OCR, Transliterate, Translate, History
  - Configure routing between screens
  - Initialize services using dependency injection (Provider/Riverpod)
  - Load JSON data files on app startup
  - _Requirements: 14.1, 14.2, 14.3, 14.4, 14.5, 15.3, 17.1, 17.2, 17.3, 17.4, 17.5, 18.5_

- [ ] 14. Implement theme and styling
  - Configure Material Design 3 theme with Balinese color palette
  - Set up custom text styles for different script types
  - Add Noto Sans Balinese font for Aksara Bali display
  - Implement light and dark theme support
  - Add animations for page transitions and button interactions
  - _Requirements: 15.1, 15.2, 15.4, 15.5_

- [ ] 15. Implement error handling and user feedback
  - Create AppError class and error handling utilities
  - Add error dialogs with user-friendly messages and recovery actions
  - Implement loading indicators for long operations
  - Add success snackbars for completed actions
  - Handle offline mode gracefully
  - _Requirements: 14.1, 14.2, 14.3, 14.4, 14.5, 15.4_

- [ ] 16. Add sample assets and documentation
  - Add sample lontar images to assets/sample_images
  - Create app icons for different platforms
  - Write comprehensive README.md with installation instructions
  - Document build process for Android and iOS
  - Add usage guide with screenshots
  - Document JSON data file formats
  - _Requirements: 1.5, 15.1_

- [ ] 17. Configure platform-specific settings
  - Configure Android permissions in AndroidManifest.xml (CAMERA, STORAGE)
  - Configure iOS permissions in Info.plist (Camera, Photo Library)
  - Set minimum SDK versions (Android 21, iOS 12.0)
  - Configure app icons and splash screens
  - Set up build configurations for release
  - _Requirements: 14.1, 14.2, 14.3, 14.4, 14.5_

- [ ] 18. Performance optimization and testing
  - [ ] 18.1 Optimize image processing performance
    - Implement image resizing before processing
    - Use isolates for CPU-intensive operations
    - Add caching for preprocessed images
    - _Requirements: 2.1, 2.2, 2.3, 2.4_
  - [ ] 18.2 Optimize data loading and memory usage
    - Implement lazy loading for dictionary entries
    - Add pagination for history results
    - Optimize thumbnail generation
    - _Requirements: 16.1, 16.2_
  - [ ] 18.3 Write unit tests for services
    - Test OCR Service preprocessing and recognition
    - Test Transliteration Service mapping algorithms
    - Test Dictionary Service lookup and fuzzy matching
    - Test Storage Service CRUD operations
    - _Requirements: 3.1, 3.2, 3.3, 5.1, 5.2, 5.3, 6.1, 6.2, 6.3, 8.1, 8.2, 9.1, 9.2, 10.1, 10.2_
  - [ ] 18.4 Write widget tests for screens
    - Test navigation between screens
    - Test user input handling
    - Test result display and actions
    - _Requirements: 15.3, 15.4_
  - [ ] 18.5 Perform integration testing
    - Test end-to-end OCR workflow
    - Test complete translation pipeline
    - Test save and retrieve workflow
    - Test export functionality
    - _Requirements: 11.1, 11.2, 11.3, 12.1, 12.2, 14.1, 14.2, 14.3_
