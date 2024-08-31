import 'dart:io';
import 'package:dio/dio.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:v_export/customer/services/utils/base_url_api.dart';

class WalletApiServices extends BaseApiServices {
  Future walletApi(
      ) async {
    dynamic responseJson;
    try {
      var dio = Dio();
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? authtoken = prefs.getString('auth_token');

      var response = await dio.post(walletUrl,
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
            "start_date": "",
            "end_date": "",
            "transaction_type": "all" //all,credit or debit
          });

      print("----------topUp api-------");
      print(response.data);
      responseJson = response;
    } on SocketException {
      print("No internet");
    }
    return responseJson;
  }
}
