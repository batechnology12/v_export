import 'dart:io';
import 'package:dio/dio.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:v_export/customer/services/utils/base_url_api.dart';

class RedeemCouponParcelApiServices extends BaseApiServices {
  Future redmeeCouponsParcel(String coupon) async {
    dynamic responseJson;
    try {
      var dio = Dio();
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? authtoken = prefs.getString('auth_token');

      var response = await dio.post(redeemCouponsUrl,
          options: Options(
              headers: {'Authorization': 'Bearer $authtoken'},
              followRedirects: false,
              validateStatus: (status) {
                return status! <= 500;
              }),
          data: {"coupon_code": coupon});

      print("---------parcel-coupon api-------");
      print(response.data);
      responseJson = response;
    } on SocketException {
      print("No internet");
    }
    return responseJson;
  }
  
}
