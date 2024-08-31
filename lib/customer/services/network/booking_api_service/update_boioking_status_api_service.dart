import 'dart:io';
import 'package:dio/dio.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:v_export/customer/services/utils/base_url_api.dart';

class UpdateBookinStatusApiServices extends BaseApiServices {
  Future updateBookingApi(
      {required String iD,
      required String paymentMode,
  }) async {
    dynamic responseJson;
    try {
      var dio = Dio();
   final prefs = await SharedPreferences.getInstance();
      String? authtoken = prefs.getString("auth_token");
      var response = await dio.post(updateBookingStatusUrl,
          options: Options(
              headers: {
  'Content-Type': 'application/json',
  'Authorization': 'Bearer $authtoken'
},
              followRedirects: false,
              validateStatus: (status) {
                return status! <= 500;
              }),
          data: {
    "booking_id":iD,
    "payment_mode": paymentMode  
});
      print("update booking status---------");
      print(response.data);
      responseJson = response;
    } on SocketException {
      print("no internet");
    }
    return responseJson;
  }
}
