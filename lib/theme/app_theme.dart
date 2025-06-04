import 'package:path_to_water/utilities/app_exports.dart';

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
      titleTextStyle: AppTextTheme.headlineMedium.copyWith(
        color: AppColors.textPrimary,
      ),
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
      titleTextStyle: AppTextTheme.headlineMedium.copyWith(
        color: AppColors.textPrimary,
      ),
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
  static bool get isDarkMode => AppGlobals.isDarkMode.value;

  static Color get primary =>
      isDarkMode ? Color(0xFF589987) : Color(0xFF589987);

  // Secondary Color
  static Color get secondary =>
      isDarkMode ? Color(0xFF03DAC6) : Color(0xFF03DAC6);

  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFDA2326);
  static const Color warning = Color(0xFFFFC107);
  static const Color info = Color(0xFF2196F3);

  // Background Colors
  static Color get scaffoldBackground =>
      isDarkMode ? Color(0xFF101010) : Color(0xFFFFFFFF);

  // Surface Colors
  static Color get surface =>
      isDarkMode ? Color(0xFFFFFFFF) : Color(0xFF1E1E1E);

  // Text Colors
  static Color get textPrimary =>
      isDarkMode ? Color(0xFFFFFFFF) : Color(0xFF0D0F1F);

  static Color get textSecondary => Color(0xFF589981);

  static Color get textFieldFillColor =>
      isDarkMode ? Color(0xFF171717) : Color(0xFFFFFFFF);

  static Color get textFieldBorderColor =>
      isDarkMode ? Color(0xFF252525) : Color(0xFFE9E9E9);

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

  // Text Styles
  static TextStyle get displayLarge => TextStyle(
    fontSize: 57.0,
    fontWeight: light,
    letterSpacing: -0.25,
    color: AppColors.textPrimary,
  );

  static TextStyle get displayMedium => TextStyle(
    fontSize: 45.0,
    fontWeight: light,
    letterSpacing: 0,
    color: AppColors.textPrimary,
  );

  static TextStyle get displaySmall => TextStyle(
    fontSize: 36.0,
    fontWeight: regular,
    letterSpacing: 0,
    color: AppColors.textPrimary,
  );

  static TextStyle get headlineLarge => TextStyle(
    fontSize: 32.0,
    fontWeight: regular,
    letterSpacing: 0,
    color: AppColors.textPrimary,
  );

  static TextStyle get headlineMedium => TextStyle(
    fontSize: 28.0,
    fontWeight: regular,
    letterSpacing: 0.25,
    color: AppColors.textPrimary,
  );

  static TextStyle get headlineSmall => TextStyle(
    fontSize: 24.0,
    fontWeight: medium,
    letterSpacing: 0,
    color: AppColors.textPrimary,
  );

  static TextStyle get titleLarge => TextStyle(
    fontSize: 22.0,
    fontWeight: medium,
    letterSpacing: 0,
    color: AppColors.textPrimary,
  );

  static TextStyle get titleMedium => TextStyle(
    fontSize: 16.0,
    fontWeight: medium,
    letterSpacing: 0.15,
    color: AppColors.textPrimary,
  );

  static TextStyle get titleSmall => TextStyle(
    fontSize: 14.0,
    fontWeight: medium,
    letterSpacing: 0.1,
    color: Colors.white,
  );

  static TextStyle get bodyLarge => TextStyle(
    fontSize: 16.0,
    fontWeight: regular,
    letterSpacing: 0.5,
    color: AppColors.textPrimary,
  );

  static TextStyle get bodyMedium => TextStyle(
    fontSize: 14.0,
    fontWeight: regular,
    letterSpacing: 0.25,
    color: AppColors.textPrimary,
  );

  static TextStyle get bodySmall => TextStyle(
    fontSize: 12.0,
    fontWeight: regular,
    letterSpacing: 0.4,
    color: AppColors.textPrimary,
  );

  static TextStyle get labelLarge => TextStyle(
    fontSize: 14.0,
    fontWeight: medium,
    letterSpacing: 0.1,
    color: AppColors.textPrimary,
  );

  static TextStyle get labelMedium => TextStyle(
    fontSize: 12.0,
    fontWeight: medium,
    letterSpacing: 0.5,
    color: AppColors.textPrimary,
  );

  static TextStyle get labelSmall => TextStyle(
    fontSize: 11.0,
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
