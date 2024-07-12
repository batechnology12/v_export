import 'dart:io';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v_export/customer/services/utils/base_url_api.dart';

class UpdateProfileApiService extends BaseApiServices {
  Future updateProfile({required String name, required String mail, required String phone}) async {
    dynamic responseJson;
    try {
      var dio = Dio();
final prefs = await SharedPreferences.getInstance();
      String? authtoken = prefs.getString("auth_token");
      var response = await dio.post(
        updateProfileUrl,
        options: Options(
            headers: {
              'Authorization':
                  'Bearer $authtoken',
              'Content-Type': 'application/json'
            },
            followRedirects: false,
            validateStatus: (status) {
              return status! <= 500;
            }),
        data: {
          "first_name":  name,
          "last_name": "Doe",
          "phone": phone,
          "email": mail,
          "latitude": "1.234567",
          "longitude": "2.345678",
          "contact_person_name": "Jane Doe",
          "industry_no_of_delivery_in_month": "50",
          "bank_name": "Bank of Example",
          "account_number": "1234567890",
          "ifs_code": "EXAMP1234",
          "emergency_contact_name": "Jane Doe",
          "emergency_contact_number": "0987654321",
          "relationship": "Spouse"
        },
      );
      responseJson = response;
    } on SocketException {
      print("No internet");
    }
    return responseJson;
  }
}
