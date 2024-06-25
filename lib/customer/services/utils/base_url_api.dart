abstract class BaseApiServices {
  String baseUrl = "https://veelgo.digitaldatatechnologia.in/api/";
  
  String get registerPersonalAccoutUrl => "${baseUrl}register";
  String get registerPersonalOtpUrl => "${baseUrl}verify_otp";
  String get registerBusinessOtpUrl => "${baseUrl}verify_otp";
  String get registerBusinessAccountUrl => "${baseUrl}register";
  String get loginUrl => "${baseUrl}login";
  String get forgetPasswordUrl => "${baseUrl}ForgetPassword";
  String get verificationOtpUrl => "${baseUrl}verify_otp";
  String get newPasswordUrl => "${baseUrl}resetPassword";
  String get getProfileUrl => "${baseUrl}getProfile";
  String get getSliderList => "${baseUrl}get_slider";
  String get updatePasswordUrl => "${baseUrl}updatePassword";

  String get notificationUrl => "${baseUrl}notifications";
}

class AppPath {
  static const String login = "login";
  static const String register = "register";
}
