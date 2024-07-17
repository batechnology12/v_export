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
  String get ongoingOrderUrl => "${baseUrl}ongoing_booking";
  String get getDeliveryTypeUrl => "${baseUrl}delivery_types";
  String get getAdditionlServicesUrl => "${baseUrl}additional_servicess";
  String get addBookingParcelUrl => "${baseUrl}store_booking";
  String get cancelBookingUrl => "${baseUrl}cancelBooking";
  String get updateProfileUrl => "${baseUrl}updateProfile";
  String get  getOngoing_completed_cancelledUrl => "${baseUrl}getCustomerOngoingOrders"; 
  String get editProfileUrl => "${baseUrl}update_profile_picture";
  String get getBookingUrl => "${baseUrl}get_booking";
  String get addAddressUrl => "${baseUrl}add_address";
  String get getAcceptBookingDetailsUrl => "${baseUrl}getAcceptedBookingDetails";

}

class AppPath {
  static const String login = "login";
  static const String register = "register";
}
