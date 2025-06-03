import 'package:flutter/material.dart';

class AppTheme {
  // Private constructor to prevent instantiation
  AppTheme._();

  // Light Theme
  static final ThemeData lightTheme = ThemeData(
    primarySwatch: AppColors.primaryMaterialColor,
    scaffoldBackgroundColor: AppColors.scaffoldBackground,
    brightness: Brightness.light,
    fontFamily: AppFonts.primary,
    textTheme: AppTextTheme.textTheme,
    appBarTheme: AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: AppColors.scaffoldBackground,
      titleTextStyle: AppTextTheme.headlineMedium.copyWith(color: AppColors.textPrimary),
      iconTheme: IconThemeData(color: AppColors.textPrimary),
    ),
    colorScheme: ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: AppColors.surface,
    ),
    // Add other theme properties as needed
  );

  // Dark Theme
  static final ThemeData darkTheme = ThemeData(
    primarySwatch: AppColors.primaryMaterialColor,
    scaffoldBackgroundColor: AppColors.scaffoldBackground,
    brightness: Brightness.dark,
    fontFamily: AppFonts.primary,
    textTheme: AppTextTheme.textTheme,
    appBarTheme: AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: AppColors.scaffoldBackground,
      titleTextStyle: AppTextTheme.headlineMedium.copyWith(color: AppColors.textPrimary),
      iconTheme: IconThemeData(color: AppColors.textPrimary),
    ),
    colorScheme: ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: AppColors.surface,
    ),
    // Add other theme properties as needed
  );
}

class AppColors {
  // Primary Color
  static bool isDark = false;
  static Color get primary => isDark ? Color(0xFF589987) : Color(0xFF589987);

  // Secondary Color
  static Color get secondary => isDark ? Color(0xFF03DAC6) : Color(0xFF03DAC6);

  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFDA2326);
  static const Color warning = Color(0xFFFFC107);
  static const Color info = Color(0xFF2196F3);

  // Background Colors
  static Color get scaffoldBackground => isDark ? Color(0xFFFFFFFF) : Color(0xFF101010);

  // Surface Colors
  static Color get surface => isDark ? Color(0xFFFFFFFF) : Color(0xFF1E1E1E);

  // Text Colors
  static Color get textPrimary => isDark ? Color(0xFF000000) : Color(0xFFFFFFFF);

  // Border Colors
  static const Color borderLight = Color(0xFFE0E0E0);
  static const Color borderDark = Color(0xFF424242);

  // Disabled Colors
  static const Color disabledLight = Color(0xFFBDBDBD);
  static const Color disabledDark = Color(0xFF616161);

  // Other Colors
  static const Color dividerLight = Color(0xFFEEEEEE);
  static const Color dividerDark = Color(0xFF303030);

  // Material Color from primary color
  static MaterialColor get primaryMaterialColor {
    return MaterialColor(primary.toARGB32(), {
      50: primary.withValues(alpha: 0.1),
      100: primary.withValues(alpha: 0.2),
      200: primary.withValues(alpha: 0.3),
      300: primary.withValues(alpha: 0.4),
      400: primary.withValues(alpha: 0.5),
      500: primary.withValues(alpha: 0.6),
      600: primary.withValues(alpha: 0.7),
      700: primary.withValues(alpha: 0.8),
      800: primary.withValues(alpha: 0.9),
      900: primary.withValues(alpha: 1.0),
    });
  }
}

class AppFonts {
  static const String primary = 'Poppins';
  // Add other font families as needed
}

class AppTextTheme {
  // Font Weights
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;

  // Font Sizes
  static const double displayLargeSize = 57.0;
  static const double displayMediumSize = 45.0;
  static const double displaySmallSize = 36.0;
  static const double headlineLargeSize = 32.0;
  static const double headlineMediumSize = 28.0;
  static const double headlineSmallSize = 24.0;
  static const double titleLargeSize = 22.0;
  static const double titleMediumSize = 16.0;
  static const double titleSmallSize = 14.0;
  static const double bodyLargeSize = 16.0;
  static const double bodyMediumSize = 14.0;
  static const double bodySmallSize = 12.0;
  static const double labelLargeSize = 14.0;
  static const double labelMediumSize = 12.0;
  static const double labelSmallSize = 11.0;

  // Text Styles
  static TextStyle displayLarge = TextStyle(
    fontSize: displayLargeSize,
    fontWeight: light,
    letterSpacing: -0.25,
    color: AppColors.textPrimary,
  );

  static TextStyle displayMedium = TextStyle(
    fontSize: displayMediumSize,
    fontWeight: light,
    letterSpacing: 0,
    color: AppColors.textPrimary,
  );

  static TextStyle displaySmall = TextStyle(
    fontSize: displaySmallSize,
    fontWeight: regular,
    letterSpacing: 0,
    color: AppColors.textPrimary,
  );

  static TextStyle headlineLarge = TextStyle(
    fontSize: headlineLargeSize,
    fontWeight: regular,
    letterSpacing: 0,
    color: AppColors.textPrimary,
  );

  static TextStyle headlineMedium = TextStyle(
    fontSize: headlineMediumSize,
    fontWeight: regular,
    letterSpacing: 0.25,
    color: AppColors.textPrimary,
  );

  static TextStyle headlineSmall = TextStyle(
    fontSize: headlineSmallSize,
    fontWeight: medium,
    letterSpacing: 0,
    color: AppColors.textPrimary,
  );

  static TextStyle titleLarge = TextStyle(
    fontSize: titleLargeSize,
    fontWeight: medium,
    letterSpacing: 0,
    color: AppColors.textPrimary,
  );

  static TextStyle titleMedium = TextStyle(
    fontSize: titleMediumSize,
    fontWeight: medium,
    letterSpacing: 0.15,
    color: AppColors.textPrimary,
  );

  static TextStyle titleSmall = TextStyle(
    fontSize: titleSmallSize,
    fontWeight: medium,
    letterSpacing: 0.1,
    color: AppColors.textPrimary,
  );

  static TextStyle bodyLarge = TextStyle(
    fontSize: bodyLargeSize,
    fontWeight: regular,
    letterSpacing: 0.5,
    color: AppColors.textPrimary,
  );

  static TextStyle bodyMedium = TextStyle(
    fontSize: bodyMediumSize,
    fontWeight: regular,
    letterSpacing: 0.25,
    color: AppColors.textPrimary,
  );

  static TextStyle bodySmall = TextStyle(
    fontSize: bodySmallSize,
    fontWeight: regular,
    letterSpacing: 0.4,
    color: AppColors.textPrimary,
  );

  static TextStyle labelLarge = TextStyle(
    fontSize: labelLargeSize,
    fontWeight: medium,
    letterSpacing: 0.1,
    color: AppColors.textPrimary,
  );

  static TextStyle labelMedium = TextStyle(
    fontSize: labelMediumSize,
    fontWeight: medium,
    letterSpacing: 0.5,
    color: AppColors.textPrimary,
  );

  static TextStyle labelSmall = TextStyle(
    fontSize: labelSmallSize,
    fontWeight: medium,
    letterSpacing: 0.5,
    color: AppColors.textPrimary,
  );

  // Text Theme
  static TextTheme get textTheme {
    return TextTheme(
      displayLarge: displayLarge,
      displayMedium: displayMedium,
      displaySmall: displaySmall,
      headlineLarge: headlineLarge,
      headlineMedium: headlineMedium,
      headlineSmall: headlineSmall,
      titleLarge: titleLarge,
      titleMedium: titleMedium,
      titleSmall: titleSmall,
      bodyLarge: bodyLarge,
      bodyMedium: bodyMedium,
      bodySmall: bodySmall,
      labelLarge: labelLarge,
      labelMedium: labelMedium,
      labelSmall: labelSmall,
    );
  }
}
