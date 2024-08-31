import 'dart:io';
import 'package:dio/dio.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:v_export/customer/model/get_vehicle_calculation_model.dart';

import 'package:v_export/customer/services/utils/base_url_api.dart';

class GetVehicleCalculationApiServices extends BaseApiServices {
  Future getVehicleCalculation(
      String vehicleType,
      String distance,
      String roundTrip,
      String additionStopCount,
      String driverHelp,
      String helperQty,
      String weekend,
      List<String> additionServiceId,
      List<String> additionalServiceQty,
      String postalcode) async {
    dynamic responseJson;
    try {
      var dio = Dio();
      // final SharedPreferences prefs = await SharedPreferences.getInstance();
      // final String? authtoken = prefs.getString('auth_token');

      var response = await dio.post(getVehicleCalculationUrl,
          options: Options(
              headers: {'Content-Type': 'application/json'},
              followRedirects: false,
              validateStatus: (status) {
                return status! <= 500;
              }),
          data: {
            "vehicle_type": vehicleType,
            "distance": distance,
            "is_round_trip": roundTrip,
            "addtional_stop_count": additionStopCount,
            "driver_help": driverHelp,
            "helper_qty": helperQty,
            "is_weekend": weekend,
            "additional_service_id": additionServiceId,
            "additional_service_qty": additionalServiceQty,
            "postal_code": postalcode
          });

      print("----------get vehicle Calculation api-------");
      print(response.data);
      responseJson = response;
    } on SocketException {
      print("No internet");
    }
    return responseJson;
  }
}
