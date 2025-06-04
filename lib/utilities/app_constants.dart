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
  static const String singUpBgLight = '$images/sign_up_bg_light.png';
  static const String singUpBgDark = '$images/sign_up_bg_dark.png';
  static const String forgetPassBgLight = '$images/forget_pass_bg_light.png';
  static const String forgetPassBgDark = '$images/forget_pass_bg_dark.png';
  static const String otpCodeBgLight = '$images/otp_code_bg_light.png';
  static const String otpCodeBgDark = '$images/otp_code_bg_dark.png';
  static const String passResetSuccessBgLight = '$images/pass_reset_bg_light.png';
  static const String passResetSuccessBgDark = '$images/pass_reset_bg_dark.png';
  static const String resetPassBgLight = '$images/reset_pass_bg_light.png';
  static const String resetPassBgDark = '$images/reset_pass_bg_dark.png';

  ///Icons
  static const String profile = '$icons/profile-circle.svg';
  static const String mail = '$icons/mail.svg';
  static const String lock = '$icons/lock.svg';
  static const String apple = '$icons/apple.svg';
  static const String google = '$icons/google.svg';
  static const String eye = '$icons/eye.svg';
  static const String eyeSlash = '$icons/eye-slash.svg';
  static const String leftLine = '$icons/left-line.svg';
  static const String rightLine = '$icons/right-line.svg';

  // text-fields input whitelisting
  static const Pattern emailFilterPattern = r'[a-zA-Z0-9@._-]';
  static const Pattern passwordFilterPattern =
      r'[a-zA-Z0-9!#\$%^&*()=+~`<>,/?:;"|\\@._-]';
  static const Pattern nameFilterPattern = r'[a-zA-Z]+|\s';
  static const Pattern numberFilterPattern = r'[0-9]';
}
