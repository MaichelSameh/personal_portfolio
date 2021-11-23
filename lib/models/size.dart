import 'package:flutter/material.dart';

enum TextType { h1, h2, h3, btn, p }

enum ScreensType { mobile, tablet, pc }

class Size {
  double? _screenHeight;
  double? _screenWidth;
  static const double modelHeight = 1000;
  static const double modelWidth = 1920;
  final BuildContext _context;
  final BoxConstraints _constrain;
  Size(
    this._context, [
    this._constrain = const BoxConstraints(maxHeight: 1, maxWidth: 1),
  ]);

  double get constrainMaxHeight {
    return _constrain.maxHeight == 1 ? screenHeight() : _constrain.maxHeight;
  }

  double get constrainMaxWidth {
    return _constrain.maxWidth == 1 ? screenWidth() : _constrain.maxWidth;
  }

  ScreensType get screenType {
    return MediaQuery.of(_context).size.width >= 1000
        ? ScreensType.pc
        : MediaQuery.of(_context).size.width >= 700
            ? ScreensType.tablet
            : ScreensType.mobile;
  }

  double screenHeight() {
    _screenHeight ??= MediaQuery.of(_context).size.height -
        MediaQuery.of(_context).padding.top;
    return _screenHeight ?? 1;
  }

  double screenWidth() {
    _screenWidth ??= MediaQuery.of(_context).size.width;
    return _screenWidth ?? 1;
  }

  double height(double number) {
    double result = constrainMaxHeight * (number / modelHeight);
    return result;
  }

  double width(double number) {
    double _screenWidth = constrainMaxWidth;
    return _screenWidth * (number / modelWidth);
  }

  TextStyle textTheme(TextType type) {
    switch (type) {
      case TextType.h1:
        return TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: screenType == ScreensType.pc
              ? 110
              : screenType == ScreensType.tablet
                  ? 80
                  : 30,
          color: Colors.white,
          letterSpacing: -1,
        );

      case TextType.h2:
        return TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: screenType == ScreensType.pc
              ? 40
              : screenType == ScreensType.tablet
                  ? 40
                  : 22,
          color: Colors.white,
        );

      case TextType.h3:
        return TextStyle(
          fontWeight: FontWeight.w300,
          fontSize: screenType == ScreensType.pc
              ? 30
              : screenType == ScreensType.tablet
                  ? 35
                  : 18,
          color: Colors.white,
        );

      case TextType.btn:
        return TextStyle(
          fontWeight: FontWeight.w300,
          fontSize: screenType == ScreensType.pc
              ? 20
              : screenType == ScreensType.tablet
                  ? 22
                  : 15,
          color: Colors.white,
        );

      case TextType.p:
        return TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: screenType == ScreensType.pc
                ? 15
                : screenType == ScreensType.tablet
                    ? 20
                    : 13,
            color: Colors.white,
            letterSpacing: -1);
    }
  }
}
