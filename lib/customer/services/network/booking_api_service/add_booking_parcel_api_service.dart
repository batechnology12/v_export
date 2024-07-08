import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v_export/customer/model/add_booking_parcel_model.dart';
import 'package:v_export/customer/services/utils/base_url_api.dart';

class AddBookingParcelsApiService extends BaseApiServices {
  Future addBookingParcel(AddBookingParcelModel addBookingParcelModel) async {
    dynamic responseJson;
    try {
      var dio = Dio();
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? authtoken = prefs.getString('auth_token');
      FormData formData = FormData.fromMap({
        "delivery_type_id": addBookingParcelModel.deliveryTypeid,
        "payment_mode": addBookingParcelModel.paymentmode,
        "booking_amount": addBookingParcelModel.bookingAmount,
        "gst": addBookingParcelModel.gst,
        "additional_total": addBookingParcelModel.additionalTotal,
        "total_amount": addBookingParcelModel.totalAmount,
        "is_round_trip": addBookingParcelModel.roundTrip,
        "booking_date": addBookingParcelModel.bookingDate,
        "pickuptime_from": addBookingParcelModel.pickupTimeFrom,
        "pickuptime_to": addBookingParcelModel.pickupTimeTo,
        "delivery_date": addBookingParcelModel.deliveryDate,
        "deliverytime_from": addBookingParcelModel.deliveryTimeFrom,
        "deliverytime_to": addBookingParcelModel.deliveryTimeTo,
        "latitude": addBookingParcelModel.latitude,
        "longitude": addBookingParcelModel.longitude,
        "distance": addBookingParcelModel.distance,
        "parcel_photo": await MultipartFile.fromFile(
            addBookingParcelModel.parcelPhoto!.path),
        "additional_services_id[]": addBookingParcelModel.additionalDetails,
        "notes": addBookingParcelModel.notes,
        for (int i = 0; i < addBookingParcelModel.parcelItem!.length; i++)
          "products[$i][parcel_items]": addBookingParcelModel.parcelItem,
        for (int j = 0; j < addBookingParcelModel.length!.length; j++)
          "products[$j][length]": addBookingParcelModel.length,
        for (int k = 0; k < addBookingParcelModel.width!.length; k++)
          "products[$k][width]": addBookingParcelModel.width,
        for (int l = 0; l < addBookingParcelModel.height!.length; l++)
          "products[$l][height]": addBookingParcelModel.height,
        for (int m = 0; m < addBookingParcelModel.qty!.length; m++)
          "products[$m][qty]": addBookingParcelModel.qty,
        for (int n = 0;
            n < addBookingParcelModel.pickupTimeFromList!.length;
            n++)
          "products[$n][pickuptime_from]":
              addBookingParcelModel.pickupTimeFromList,
        for (int o = 0; o < addBookingParcelModel.pickupTimeToList!.length; o++)
          "products[$o][pickuptime_to]": addBookingParcelModel.pickupTimeToList,
        for (int p = 0; p < addBookingParcelModel.deliveryDate!.length; p++)
          "products[$p][delivery_date]": addBookingParcelModel.deliveryDate,
        for (int q = 0;
            q < addBookingParcelModel.deliveryTimeFromList!.length;
            q++)
          "products[$q][deliverytime_from]":
              addBookingParcelModel.deliveryTimeFromList,
        for (int r = 0;
            r < addBookingParcelModel.deliveryTimeToList!.length;
            r++)
          "products[0][deliverytime_to]":
              addBookingParcelModel.deliveryTimeToList,
        for (int s = 0; s < addBookingParcelModel.customerName!.length; s++)
          "booking_address[$s][customer_name]":
              addBookingParcelModel.customerName,
        for (int t = 0; t < addBookingParcelModel.customerMobile!.length; t++)
          "booking_address[$t][customer_phone]":
              addBookingParcelModel.customerMobile,
        for (int u = 0; u < addBookingParcelModel.blockNoUnitNo!.length; u++)
          "booking_address[$u][unitno_blockno]":
              addBookingParcelModel.blockNoUnitNo,
        for (int v = 0; v < addBookingParcelModel.address!.length; v++)
          "booking_address[$v][address]": addBookingParcelModel.address,
        for (int w = 0; w < addBookingParcelModel.postalCode!.length; w++)
          "booking_address[$w][postalcode]": addBookingParcelModel.postalCode,
        for (int x = 0; x < addBookingParcelModel.latitudeList!.length; x++)
          "booking_address[$x][latitude]": addBookingParcelModel.latitudeList,
        for (int y = 0; y < addBookingParcelModel.logitudeList!.length; y++)
          "booking_address[$y][longitude]": addBookingParcelModel.logitudeList,
        for (int z = 0; z < addBookingParcelModel.deliveryStatus!.length; z++)
          "booking_address[$z][delivery_status]":
              addBookingParcelModel.deliveryStatus,
        for (int a = 0;
            a < addBookingParcelModel.addressDeliveryTimeFromList!.length;
            a++)
          "booking_address[$a][deliverytime_from]":
              addBookingParcelModel.addressDeliveryTimeFromList,
        for (int b = 0;
            b < addBookingParcelModel.addressDeliveryTimeToList!.length;
            b++)
          "booking_address[$b][deliverytime_to]":
              addBookingParcelModel.addressDeliveryTimeToList,
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
    } on SocketException {
      print("No internet");
    }
    return responseJson;
  }
}
