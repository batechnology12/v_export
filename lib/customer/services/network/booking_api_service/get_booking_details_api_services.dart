import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v_export/customer/services/utils/base_url_api.dart';

class MainMenuServices extends BaseApiServices {
  Future<Response> paymentShowing(String bookId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');
    final Dio dio = Dio();
    dynamic responcedata;
    if (token == null) {
      throw Exception('Token not found');
    }
    try {
      print(token);

      final response = await dio.post(getBookingDetailsUrl,
          options: Options(
              headers: {'Authorization': 'Bearer $token'},
              followRedirects: false,
              validateStatus: (status) {
                return status! <= 500;
              }),
          data: {
            'booking_id': bookId,
          });
      responcedata = response;
      print(response);
      return responcedata;
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }
}
