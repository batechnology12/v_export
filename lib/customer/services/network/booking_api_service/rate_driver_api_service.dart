import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v_export/customer/services/utils/base_url_api.dart';

class RateDriverApiService extends BaseApiServices {
  Future rateDriverApi(
      String ratingBookingId, String rating, String review) async {
    dynamic responsenJson;
    try {
      var dio = Dio();
      final prefs = await SharedPreferences.getInstance();
      String? authToken = prefs.getString("auth_token");
      var response = dio.post(ratedriverUrl,
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
            "booking_id": ratingBookingId,
            "rating": rating,
            "review": review,
          });
          responsenJson = response;

    } catch (e) {
      print("No Internet");
    }
  }
}
