import "package:flutter/material.dart";

import "../constants/colors/application_colors.dart";

ThemeData lightTheme = ThemeData(
  pageTransitionsTheme: null,

  // FOR BACK NAVIGATION ANIMATION UNCOMMENT THIS LINE AND REPLACE IT TO THE NULL VALUE ABOVE
  // const PageTransitionsTheme(
  //   builders: {
  //     TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
  //   },
  // ),
  colorScheme: const ColorScheme.light(
    surface: kWhiteColor,
    inverseSurface: kBlackColor,
    primary: kLightGrayColor,
    inversePrimary: kDarkGrayColor,
    secondary: kLighterGrayColor,
    onSecondary: kGrayColor,
    tertiary: kAccentColor,
    surfaceContainer: kSmokeColor,
    errorContainer: kErrorBackgroundColor,
    error: kErrorForegroundColor,
    tertiaryFixed: kSuccessBackgroundColor,
    onTertiaryFixed: kSuccessForegroundColor,
  ),
);
