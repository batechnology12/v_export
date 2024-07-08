import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v_export/customer/services/utils/base_url_api.dart';

class AddAdressApiService extends BaseApiServices {
  Future addAdress() async {
    dynamic responseJosn;

    try {
      var dio = Dio();
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? authtoken = prefs.getString('auth_token');
      var response = await dio.post(addAddressUrl,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': '$authtoken'
            },
            followRedirects: false,
            validateStatus: (status) {
              return status! <= 500;
            },
          ),
          data: {
            "street": "123 Main St",
            "city": "Anytown",
            "state": "Anystate",
            "zip": "12345",
            "country": "Country",
            "type": "Home",
            "unit_no": "1A",
            "block_no": "B1",
            "address": "123 Main St, Apt 1A, Block B1",
            "landmark": "Near Central Park",
            "pincode": "12345",
            "contact_person": "John Doe",
            "contact_number": "1234567890",
            "latitude": 40.712776,
            "longitude": -74.005974
          });
    } on SocketException {
      print("No internet");
    }
  }
}
