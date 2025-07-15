// responsive_helper.dart
import 'package:flutter/material.dart';

class ResponsiveHelper {
  static late MediaQueryData _mediaQueryData;
  static late double _screenWidth;
  static late double _screenHeight;
  static late double _designWidth;
  static late double _designHeight;
  static late double _pixelRatio;
  
  // Initialize the responsive helper
  static void init(BuildContext context, {
    double designWidth = 365,
    double designHeight = 812,
  }) {
    _mediaQueryData = MediaQuery.of(context);
    _screenWidth = _mediaQueryData.size.width;
    _screenHeight = _mediaQueryData.size.height;
    _designWidth = designWidth;
    _designHeight = designHeight;
    _pixelRatio = _mediaQueryData.devicePixelRatio;
  }
  
  // Get responsive width
  static double width(double width) {
    return (_screenWidth / _designWidth) * width;
  }
  
  // Get responsive height
  static double height(double height) {
    return (_screenHeight / _designHeight) * height;
  }
  
  // Get responsive font size
  static double sp(double fontSize) {
    return (_screenWidth / _designWidth) * fontSize;
  }
  
  // Get minimum responsive size (useful for square elements)
  static double size(double size) {
    final scaleWidth = _screenWidth / _designWidth;
    final scaleHeight = _screenHeight / _designHeight;
    final scale = scaleWidth < scaleHeight ? scaleWidth : scaleHeight;
    return scale * size;
  }
  
  // Get screen width
  static double get screenWidth => _screenWidth;
  
  // Get screen height
  static double get screenHeight => _screenHeight;
  
  // Get design width
  static double get designWidth => _designWidth;
  
  // Get design height
  static double get designHeight => _designHeight;
  
  // Check if device is tablet
  static bool get isTablet => _screenWidth >= 768;
  
  // Check if device is mobile
  static bool get isMobile => _screenWidth < 768;
  
  // Get orientation
  static Orientation get orientation => _mediaQueryData.orientation;
  
  // Get pixel ratio
  static double get pixelRatio => _pixelRatio;
}