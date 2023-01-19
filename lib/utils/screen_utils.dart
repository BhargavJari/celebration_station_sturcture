
import 'dart:math';

import 'package:flutter/material.dart';

class ScreenUtil {
  static const Size defaultSize = Size(360, 690);
  static ScreenUtil? _instance;

  Size uiSize = defaultSize;

  bool allowFontScaling = false;

  static late Orientation _orientation;
  static late double _pixelRatio;
  static late double _screenWidth;
  static late double _screenHeight;
  static late double _statusBarHeight;
  static late double _bottomBarHeight;

  ScreenUtil._();

  factory ScreenUtil() {
    assert(
      _instance != null,
      '\nEnsure to initialize ScreenUtil before accessing it.\nPlease execute the init method : ScreenUtil.init()',
    );
    return _instance!;
  }

  static void init(
    BoxConstraints constraints, {
    Orientation orientation = Orientation.portrait,
    Size designSize = defaultSize,
    bool allowFontScaling = false,
  }) {
    _instance ??= ScreenUtil._();
    _instance!
      ..uiSize = designSize
      ..allowFontScaling = allowFontScaling;

    _orientation = orientation;
    _screenWidth = constraints.maxWidth;
    _screenHeight = constraints.maxHeight;

    var mediaQuery = WidgetsBinding.instance.window;
    _pixelRatio = mediaQuery.devicePixelRatio;
    _statusBarHeight = mediaQuery.padding.top;
    _bottomBarHeight = mediaQuery.padding.bottom;
  }

  Orientation? get orientation => _orientation;

  double get textScaleFactor => WidgetsBinding.instance.window.textScaleFactor;

  double get pixelRatio => _pixelRatio;

  double get screenWidth => _screenWidth;

  double get screenHeight => _screenHeight;

  double get statusBarHeight => _statusBarHeight / _pixelRatio;

  double get bottomBarHeight => _bottomBarHeight / _pixelRatio;

  double get scaleWidth => _screenWidth / uiSize.width;

  double get scaleHeight => _screenHeight / uiSize.height;

  double get scaleText => min(scaleWidth, scaleHeight);

  double setWidth(num width) => width * scaleWidth;

  double setHeight(num height) => height * scaleHeight;

  double radius(num r) => r * scaleText;

  double setSp(num fontSize, {bool? allowFontScalingSelf}) =>
      allowFontScalingSelf == null
          ? (allowFontScaling
              ? (fontSize * scaleText * textScaleFactor)
              : fontSize * scaleText)
          : (allowFontScalingSelf
              ? (fontSize * scaleText * textScaleFactor)
              : (fontSize * scaleText));
}
