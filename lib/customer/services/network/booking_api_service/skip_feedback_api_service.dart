import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v_export/customer/services/utils/base_url_api.dart';

class SkipFeedBackApiServices extends BaseApiServices {
  Future skipFeedBackApi(String skipFeedbackID) async {
    dynamic responsenJson;
    try {
      var dio = Dio();
      final prefs = await SharedPreferences.getInstance();
      String? authToken = prefs.getString("auth_token");
      var response = await dio.post(skipFeedbackUrl,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $authToken'
            },
            followRedirects: false,
            validateStatus: (status) {
              return status! <= 500;
            },
          ),
          data: {
            "booking_id": skipFeedbackID,
          });
      responsenJson = response;
    } catch (e) {
      print("No Internet");
    }
    return responsenJson;
  }
}
