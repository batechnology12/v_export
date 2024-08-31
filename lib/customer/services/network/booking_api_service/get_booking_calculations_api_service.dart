import 'dart:io';
import 'package:dio/dio.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:v_export/customer/model/get_vehicle_calculation_model.dart';

import 'package:v_export/customer/services/utils/base_url_api.dart';

class GetBookingCalculationApiServices extends BaseApiServices {
  Future getBookingCalculation(
      String deliveryType,
      String distance,
      String roundTrip,
      List<String> locationKg,
      List<String> locationQty,
      List<String> additionServiceId,
      List<String> additionalServiceQty,
      String postalcode) async {
    dynamic responseJson;
    try {
      var dio = Dio();
      // final SharedPreferences prefs = await SharedPreferences.getInstance();
      // final String? authtoken = prefs.getString('auth_token');

      var response = await dio.post(getBookingCalculationUrl,
          options: Options(
              headers: {
  'Content-Type': 'application/json'
},
              followRedirects: false,
              validateStatus: (status) {
                return status! <= 500;
              }),
          data: {
            "delivery_type": deliveryType,
            "distance": distance,
            "is_round_trip": roundTrip,
            "location_kg": locationKg,
            "location_qty": locationQty,
            "additional_service_id": additionServiceId,
            "additional_service_qty": additionalServiceQty,
            "postal_code": postalcode,
          });

      print("----------get Calculation api-------");
      print(response.data);
      responseJson = response;
    } on SocketException {
      print("No internet");
    }
    return responseJson;
  }
}
