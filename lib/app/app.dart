import 'package:flutter/material.dart';
import 'package:transferme/core/util/app_responsive_helper.dart';
import 'package:transferme/core/util/app_theme.dart';
import 'package:transferme/features/splash_screen/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Responsive Design Demo',
      theme: AppTheme.theme,
      home: SplashScreen(),
      builder: (context, child) {
        // Initialize responsive helper with design dimensions
        ResponsiveHelper.init(context, designWidth: 365, designHeight: 812);
        return child!;
      },
    );
  }
}
