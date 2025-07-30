import 'package:flutter/material.dart';

extension ContextExt on BuildContext {
  ThemeData get theme => Theme.of(this);

  MediaQueryData get mediaQuery => MediaQuery.of(this);

  Size get size => MediaQuery.sizeOf(this);

  double get height => size.height;
  double get width => size.width;

  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  TextTheme get textTheme => Theme.of(this).textTheme;

  Color get primaryColor => colorScheme.primary;
  Color get backgroundColor => colorScheme.surface;
  Color get textColor => colorScheme.onSurface;
  Color get subtitleColor => colorScheme.onSurfaceVariant;
  Color get errorColor => colorScheme.error;
  Color get cardBackGroundColor => colorScheme.surfaceContainer;
  Color get highlightColor => colorScheme.inversePrimary;
  Color get circlebgColor => colorScheme.surfaceContainerHighest;

  bool get isDark => colorScheme.brightness == Brightness.dark;
  bool get isLight => !isDark;

  Color adaptiveColor({required Color lightColor, required Color darkColor}) {
    return isDark ? darkColor : lightColor;
  }
}
