import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme.dart';
import 'services/storage_service.dart';
import 'services/transliteration_service.dart';
import 'services/dictionary_service.dart';
import 'services/ocr_service.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => StorageService()),
        Provider(create: (_) => TransliterationService()),
        Provider(create: (_) => DictionaryService()),
        Provider(create: (_) => OCRService()),
      ],
      child: const BaliLontarApp(),
    ),
  );
}

class BaliLontarApp extends StatelessWidget {
  const BaliLontarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bali Lontar',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const HomeScreen(),
    );
  }
}
