import 'dart:io';

import 'package:dio/dio.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:v_export/customer/services/utils/base_url_api.dart';

class EditProfilePictureApiService extends BaseApiServices {
  Future editProfilePictureUser({required String profilePicture}) async {
    dynamic responseJson;
    try {
      var dio = Dio();
      final prefs = await SharedPreferences.getInstance();
      String? authtoken = prefs.getString('auth_token');
      FormData formData = FormData.fromMap(
          {"image": await MultipartFile.fromFile(profilePicture)});
      print(authtoken);
      var response = await dio.post(
        editProfileUrl,
        options: Options(
            headers: {'Authorization': 'Bearer $authtoken'},
            followRedirects: false,
            validateStatus: (status) {
              return status! <= 500;
            }),
        data: formData,
      );
      print(
          ':::::::::::Profile Update profile Api Service:::::::::::::<status code>:::::::<updated>:');
      print(response.data);
      responseJson = response;
    } on SocketException {
      print('no internet');
    }
    return responseJson;
  }
}
