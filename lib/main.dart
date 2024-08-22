import 'package:flutter/material.dart';
import 'package:spotifycloneapp/core/configs/theme/app_theme.dart';
import 'package:spotifycloneapp/presentation/pages/splash/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme:AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home:SplashPage()
    );
  }
}
