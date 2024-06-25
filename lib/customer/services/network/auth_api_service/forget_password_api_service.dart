import 'dart:io';

import 'package:dio/dio.dart';
import 'package:v_export/customer/services/utils/base_url_api.dart';

class ForgetPasswordApiService extends BaseApiServices {
  Future forgetPassword(String emailOrPhoneNumber) async {
    dynamic responseJson;
    try {
      var dio = Dio();
      var response = await dio.post(forgetPasswordUrl,
          options: Options(
              headers: {
                'Content-Type': 'application/json',
              },
              followRedirects: false,
              validateStatus: (status) {
                return status! <= 500;
              }),
          data: {"email_or_phone": emailOrPhoneNumber});
      responseJson = response;
    } on SocketException {
      print("No Internet");
    }
    return responseJson;
  }
}
