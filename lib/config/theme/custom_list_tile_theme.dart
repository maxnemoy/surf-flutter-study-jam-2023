import 'package:flutter/material.dart';

class CustomListTileTheme extends ThemeExtension<CustomListTileTheme> {
  final TextStyle? titleTextStyle;
  final TextStyle? subTitleTextStyle;
  final IconThemeData? leadingIconStyle;
  final IconThemeData? trailingIconStyle;

  CustomListTileTheme(
      {this.titleTextStyle,
      this.subTitleTextStyle,
      this.leadingIconStyle,
      this.trailingIconStyle});

  @override
  ThemeExtension<CustomListTileTheme> copyWith() {
    throw UnimplementedError();
  }

  @override
  ThemeExtension<CustomListTileTheme> lerp(
      covariant ThemeExtension<ThemeExtension>? other, double t) {
    if (other is! CustomListTileTheme) {
      return this;
    }
    return CustomListTileTheme(
      titleTextStyle: TextStyle.lerp(titleTextStyle, other.titleTextStyle, t),
      subTitleTextStyle:
          TextStyle.lerp(subTitleTextStyle, other.subTitleTextStyle, t),
      leadingIconStyle:
          IconThemeData.lerp(leadingIconStyle, other.leadingIconStyle, t),
      trailingIconStyle:
          IconThemeData.lerp(trailingIconStyle, other.trailingIconStyle, t),
    );
  }
}
