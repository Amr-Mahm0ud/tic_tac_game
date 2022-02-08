import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';

import 'home.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

final lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue),
    cardColor: Colors.grey[400]);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isPlatformDark =
        WidgetsBinding.instance!.window.platformBrightness == Brightness.dark;
    final initTheme = isPlatformDark ? ThemeData.dark() : lightTheme;
    return ThemeProvider(
      duration: const Duration(milliseconds: 400),
      initTheme: initTheme,
      builder: (_, theme) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme,
        home: const MyHomePage(),
      ),
    );
  }
}
