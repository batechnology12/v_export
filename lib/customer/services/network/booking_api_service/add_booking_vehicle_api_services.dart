import 'dart:io';

import 'package:date_format/date_format.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v_export/customer/model/add_booking_parcel_model.dart';
import 'package:v_export/customer/model/add_booking_vehicle_model.dart';
import 'package:v_export/customer/services/utils/base_url_api.dart';

class AddBookingVehicleApiService extends BaseApiServices {
  Future addBookingVehicle(
      AddBookingVehicleModel addBookingVehicleModel) async {
    dynamic responseJson;
    List productss = [];

    try {
      var dio = Dio();
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? authtoken = prefs.getString('auth_token');

      print("additional list................");
      print(addBookingVehicleModel.additionalDetails);
      List<Map<String, dynamic>> data = [];

      for (int i = 0;
          i < addBookingVehicleModel.additionalDetails.length;
          i++) {
        var detail = addBookingVehicleModel.additionalDetails[i];
        int manpower = addBookingVehicleModel.totalManpwoerValue;
        int stcase = addBookingVehicleModel.totalStaircaseValue;
        data.add({
          "additional_services_id[$i][id]": detail.id,
          "additional_services_id[$i][qty]": detail.name == "Manpower (helper)"
              ? manpower
              : detail.name == "Staircase (per floor)"
                  ? stcase
                  : 0,
        });
      }
      print("object--------------");
      print(data);
      FormData formData = FormData.fromMap({
        "delivery_type_id": "1",
        "delivery_date": "25-06-2024",
        "deliverytime_from": "2:30pm",
        "deliverytime_to": "2:30pm",
        "vehicle_type": addBookingVehicleModel.vehicleType,
        "pickup_addreess": addBookingVehicleModel.pickupAddress,
        "payment_mode": "",
        "booking_amount": addBookingVehicleModel.bookingAmount,
        "payment_details": addBookingVehicleModel.paymentDetails,
        "gst": "500",
        "additional_total": addBookingVehicleModel.additionalTotal,
        "total_amount": addBookingVehicleModel.totalAmount,
        "unitno": addBookingVehicleModel.pickupunitId,
        "is_round_trip": addBookingVehicleModel.isRoundTrip,
        "booking_date": addBookingVehicleModel.pickupDate,
        "pickuptime_from": addBookingVehicleModel.pickupTimeFrom,
        "pickuptime_to": addBookingVehicleModel.pickupTimeTo,
        "latitude": addBookingVehicleModel.latitude,
        "longitude": addBookingVehicleModel.longitude,
        "distance": addBookingVehicleModel.distance,
        "booking_time_from_vehicle": addBookingVehicleModel.bookingTime,
        "sender_unitno_blockno": addBookingVehicleModel.senderUnitId,
        "booking_type": "vehicle",
        for (int i = 0;
            i < addBookingVehicleModel.additionalServiceDetails.length;
            i++)
          "additional_services_id[$i][id]":
              addBookingVehicleModel.additionalServiceDetails[i],
        for (int i = 0;
            i < addBookingVehicleModel.additionalServiceDetails.length;
            i++)
          "additional_services_id[$i][qty]": "0",
        "notes": addBookingVehicleModel.notes,
        "products": productss
            .map((product) => {
                  "parcel_items": "product.parcelItems",
                  "length": "product.length",
                  "width": "product.width",
                  "height": "product.height",
                  "qty": "product.qty",
                  "kg": "product.kg",
                  "pickuptime_from": "product.pickupTimeFrom",
                  "pickuptime_to": "product.pickupTimeTo",
                  "delivery_date": "product.deliveryDate",
                  "deliverytime_from": "product.deliveryTimeFrom",
                  "deliverytime_to": "product.deliveryTimeTo",
                })
            .toList(),
        "booking_address": addBookingVehicleModel.bookingVehicleAddress
            .map((address) => {
                  "customer_name": address.senderName,
                  "customer_mobile": address.senderMobile,
                  "unitno_blockno": address.vehiclereciverUnitIdBlockId,
                  "unitno": address.vehicleUnitId,
                  "address": address.address,
                  "postalcode": "78677",
                  "latitude": address.latitude,
                  "longitude": address.longitude,
                  "deliverytime_from": "02:30pm",
                  "deliverytime_to": "03:30pm",
                  "delivery_status": address.deliveryStatus,
                  "reciver_name": address.reciverName,
                  "reciver_mobile": address.reciverMobile,
                  "km": address.kiloMeter,
                })
            .toList(),
        "parcel_photo": addBookingVehicleModel.parcelPhoto.trim().isEmpty
            ? null
            : await MultipartFile.fromFile(addBookingVehicleModel.parcelPhoto),
      });

      var response = await dio.post(
        addBookingParcelUrl,
        options: Options(
          headers: {'Authorization': 'Bearer $authtoken'},
          followRedirects: false,
          validateStatus: (status) {
            return status! <= 500;
          },
        ),
        data: formData,
      );
      responseJson = response;
      print("----add vehicle");
      print(responseJson);
    } on SocketException {
      print("No internet");
    }
    return responseJson;
  }
}
