import 'dart:io';

import 'package:v_export/customer/model/register_person_business_account_model.dart';
import 'package:v_export/customer/services/utils/base_url_api.dart';
import 'package:dio/dio.dart';

class RegisterPersonalApiService extends BaseApiServices {
  Future registerPersonal(
      RegisterPersonalAccount registerPersonalAccount) async {
    dynamic responsJson;
    try {
      var dio = Dio();
      var response =await  dio.post(registerPersonalAccoutUrl,
          options: Options(
              headers: {'Content-Type': 'application/json'},
              followRedirects: false,
              validateStatus: (status) {
                return status! <= 500;
              }),
          data: {
            "type": "personal",
            "name": registerPersonalAccount.name,
            "email": registerPersonalAccount.email,
            "mobile": registerPersonalAccount.phone,
            "password": registerPersonalAccount.password,
            "password_confirmation": registerPersonalAccount.confirmPassword
          });
      responsJson = response;
    } on SocketException {
      print("No Internet");
    }
    return responsJson;
  }
}
