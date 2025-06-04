class AppConstants {
  // Private Constructor to Prevent Instantiation

  AppConstants._();

  // Static Constant Fields

  static const double padding = 15;

  static const String icons = 'assets/icons';

  static const String images = 'assets/images';

  ///Images

  static const String singInBgLight = '$images/sign_in_bg_light.png';

  static const String singInBgDark = '$images/sign_in_bg_dark.png';
  static const String homeBgImage = '$images/home_bg_image.png';
  static const String homeBgDarImage = '$images/home_bg_dark_image.png';
  static const String homeTileBgImage = '$images/home_tile_bg_image.png';
  static const String homeTileBgDarkImage = '$images/home_tile_bg_dark_image.png';
  static const String welcomeBannerImage = '$images/welcome_banner_image.png';
  static const String customDialogBgImage = '$images/custom_dialog_bg_image.png';
  static const String customDialogBgDarkImage = '$images/custom_dialog_bg_dark_image.png';

  ///Icons

  static const String logo = '$icons/app_logo.png';

  static const String mail = '$icons/mail.svg';

  static const String lock = '$icons/lock.svg';

  static const String eye = '$icons/eye.svg';

  static const String eyeSlash = '$icons/eye-slash.svg';

  static const String clockIcon = '$icons/clock.png';

  static const String calendarIcon = '$icons/calendar.png';

  static const String homeIcon = '$icons/home_icon.png';

  static const String profileIcon = '$icons/profile-circle.png';
  static const String person = '$icons/profile-circle.png';
  static const String menuIcon = '$icons/menu_icon.svg';
  static const String quranIcon = '$icons/quran.png';
  static const String hadithIcon = '$icons/hadith.png';
  static const String historyIcon = '$icons/history.png';
  static const String quizIcon = '$icons/quiz_icon.svg';
  static const String quizDarkIcon = '$icons/quiz_dark_icon.svg';
  static const String journalIcon = '$icons/journal_icon.svg';
  static const String journalDarkIcon = '$icons/journal_dark_icon.svg';
  static const String personIcon = '$icons/person_icon.png';
  static const String quizDrawerIcon = '$icons/quiz_icon.png';
  static const String themeIcon = '$icons/theme_icon.png';
  static const String subscriptionIcon = '$icons/subscription_icon.png';
  static const String journalDrawerIcon = '$icons/journal_icon.png';
  static const String settingIcon = '$icons/setting_icon.png';
  static const String logoutIcon = '$icons/logout_icon.png';
  static const String notificationIcon = '$icons/notification_icon.png';
  static const String favoriteIcon = '$icons/favorite_icon.png';

  // text-fields input whitelisting

  static const Pattern emailFilterPattern = r'[a-zA-Z0-9@._-]';

  static const Pattern passwordFilterPattern = r'[a-zA-Z0-9!#\$%^&*()=+~`<>,/?:;"|\\@._-]';

  static const Pattern nameFilterPattern = r'[a-zA-Z]+|\s';

  static const Pattern numberFilterPattern = r'[0-9]';

  static const String dateFormat = "dd MMM yyyy";
}
