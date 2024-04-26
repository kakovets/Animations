import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme/theme_provider.dart';
import 'features/animations/screens/animations_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(
          create: (_) => ThemeProvider()..getSavedTheme(),
        ),
      ],
      child: Builder(
        builder: (context) => MaterialApp(
          theme: Provider.of<ThemeProvider>(context).themeData,
          home: const AnimationsScreen(),
        ),
      ),
    );
  }
}