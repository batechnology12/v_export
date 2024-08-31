import 'dart:io';
import 'package:dio/dio.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:v_export/customer/services/utils/base_url_api.dart';

class CancelBookingApiServices extends BaseApiServices {
  Future cancelBooking(String bookingId, String reason) async {
    dynamic responseJson;
    try {
      var dio = Dio();
      final prefs = await SharedPreferences.getInstance();
      String? authtoken = prefs.getString("auth_token");

      print(authtoken);
      var response = await dio.post(cancelBookingUrl,
          options: Options(
              headers: {
                'Authorization': 'Bearer $authtoken',
                'Content-Type': 'application/json'
              },
              followRedirects: false,
              validateStatus: (status) {
                return status! <= 500;
              }),
          data: {
            "booking_id": bookingId,
            "cancel_reason": reason,
          });
      print("----------Cancel Booking-------");
      print(response.data);

      responseJson = response;
    } on SocketException {
      print("no internet");
    }
    return responseJson;
  }
}
