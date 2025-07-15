import 'package:flutter/material.dart';
import 'package:transferme/core/util/app_responsive_helper.dart';

TextStyle headlineText(double fontSize, Color color, double? letterSpacing) {
  return TextStyle(
    fontSize: ResponsiveHelper.sp(fontSize),
    fontFamily: 'SanFrancisco',
    fontWeight: FontWeight.w500,
    color: color,
    letterSpacing: letterSpacing,
  );
}

TextStyle smallText(double fontSize, Color color, double? letterSpacing) {
  return TextStyle(
    fontSize: ResponsiveHelper.sp(fontSize),
    fontFamily: 'SanFrancisco',
    fontWeight: FontWeight.w300,
    color: color,
    letterSpacing: letterSpacing,
  );
}

TextStyle mediumText(double fontSize, Color color, double? letterSpacing) {
  return TextStyle(
    fontSize: ResponsiveHelper.sp(fontSize),
    fontFamily: 'SanFrancisco',
    fontWeight: FontWeight.w400,
    color: color,
    letterSpacing: letterSpacing,
  );
}

TextStyle regularText(double fontSize, Color color, double? letterSpacing) {
  return TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: ResponsiveHelper.sp(fontSize),
    fontFamily: 'SanFrancisco',
    color: color,
    letterSpacing: letterSpacing,
  );
}

TextStyle extraBoldText(double fontSize, Color color, double? letterSpacing) {
  return TextStyle(
    fontSize: ResponsiveHelper.sp(fontSize),
    fontFamily: 'SanFrancisco',
    fontWeight: FontWeight.w700,
    color: color,
    letterSpacing: letterSpacing,
  );
}
