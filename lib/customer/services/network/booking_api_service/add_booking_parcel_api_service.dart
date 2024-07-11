import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v_export/customer/model/add_booking_parcel_model.dart';
import 'package:v_export/customer/services/utils/base_url_api.dart';

class AddBookingParcelsApiService extends BaseApiServices {
  Future addBookingParcel(AddBookingParcelModel addBookingParcelModel) async {
    dynamic responseJson;
    List<MultipartFile> multipartImageFiles = [];
    // File? ;
    // for (File imageFile in addBookingParcelModel.parcelPhoto!) {
    //   String fileName = imageFile.path.split('/').last;
    //   MultipartFile multipartFile =
    //       await MultipartFile.fromFile(imageFile.path, filename: fileName);
    //   multipartImageFiles.add(multipartFile);
    // }
    try {
      var dio = Dio();
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? authtoken = prefs.getString('auth_token');
      FormData formData = FormData.fromMap({
        "delivery_type_id": addBookingParcelModel.deliveryTypeid,
        "payment_mode": "UPI",
        "booking_amount": "50",
        "gst": "100",
        "additional_total": "200",
        "total_amount": "500",
        "is_round_trip": "1",
        "booking_type": "parcel",
        "booking_date": addBookingParcelModel.bookingDate,
        "pickuptime_from": addBookingParcelModel.pickupTimeFrom,
        "pickuptime_to": addBookingParcelModel.pickupTimeTo,
        "delivery_date": [addBookingParcelModel.deliveryDate],
        "deliverytime_from": addBookingParcelModel.deliveryTimeFrom,
        "deliverytime_to": addBookingParcelModel.deliveryTimeTo,
        "latitude": addBookingParcelModel.latitude,
        "longitude": addBookingParcelModel.longitude,
        "distance": addBookingParcelModel.distance,
        "parcel_photo": await MultipartFile.fromFile(
            addBookingParcelModel.parcelPhoto!.path,
            filename: addBookingParcelModel.parcelPhoto!.path.split('/').last),
        "notes": addBookingParcelModel.notes,
        // for (int e = 0;
        //     e < addBookingParcelModel.additionalDetails!.length;
        //     e++)
        "additional_services_id[]": addBookingParcelModel.additionalDetails,
        // for (int i = 0; i < addBookingParcelModel.parcelItem!.length; i++)
        "products[0][parcel_items]": addBookingParcelModel.parcelItem,
        // for (int j = 0; j < addBookingParcelModel.length!.length; j++)
        "products[0][length]": [0],
        // for (int k = 0; k < addBookingParcelModel.width!.length; k++)
        "products[0][width]": [0],
        //  for (int l = 0; l < addBookingParcelModel.height!.length; l++)
        "products[0][height]": [0],
        //     for (int m = 0; m < addBookingParcelModel.qty!.length; m++)
        "products[0][qty]": [0],
        "products[0][kg]": [0],
        // for (int n = 0;
        //     n < addBookingParcelModel.pickupTimeFromList!.length;
        //     n++)
        "products[0][pickuptime_from]":
            addBookingParcelModel.pickupTimeFromList,
        // for (int o = 0; o < addBookingParcelModel.pickupTimeToList!.length; o++)
        "products[0][pickuptime_to]": addBookingParcelModel.pickupTimeToList,
        // for (int p = 0; p < addBookingParcelModel.deliveryDate!.length; p++)
        "products[0][delivery_date]": addBookingParcelModel.deliveryDate,
        // for (int q = 0;
        //     q < addBookingParcelModel.deliveryTimeFromList!.length;
        //     q++)
        "products[0][deliverytime_from]":
            addBookingParcelModel.deliveryTimeFromList,
        // for (int r = 0;
        //     r < addBookingParcelModel.deliveryTimeToList!.length;
        //     r++)
        "products[0][deliverytime_to]":
            addBookingParcelModel.deliveryTimeToList,
        // for (int s = 0; s < addBookingParcelModel.customerName!.length; s++)
        "booking_address[0][customer_name]": addBookingParcelModel.customerName,
        // for (int t = 0; t < addBookingParcelModel.customerMobile!.length; t++)
        "booking_address[0][customer_mobile]": ["5546547476"],
        // for (int u = 0; u < addBookingParcelModel.blockNoUnitNo!.length; u++)
        "booking_address[0][unitno_blockno]":
            addBookingParcelModel.blockNoUnitNo,

        // for (int v = 0; v < addBookingParcelModel.address!.length; v++)
        "booking_address[0][address]": addBookingParcelModel.address,
        // for (int w = 0; w < addBookingParcelModel.postalCode!.length; w++)
        "booking_address[0][postalcode]": addBookingParcelModel.postalCode,
        // for (int x = 0; x < addBookingParcelModel.latitudeList!.length; x++)
        "booking_address[0][latitude]": addBookingParcelModel.latitudeList,
        // for (int y = 0; y < addBookingParcelModel.logitudeList!.length; y++)
        "booking_address[0][longitude]": addBookingParcelModel.logitudeList,
        // for (int z = 0; z < addBookingParcelModel.deliveryStatus!.length; z++)
        "booking_address[0][delivery_status]": [0],
        // for (int a = 0;
        //     a < addBookingParcelModel.addressDeliveryTimeFromList!.length;
        //     a++)
        "booking_address[0][deliverytime_from]":
            addBookingParcelModel.addressDeliveryTimeFromList,
        // for (int b = 0;
        //     b < addBookingParcelModel.addressDeliveryTimeToList!.length;
        //     b++)
        "booking_address[0][deliverytime_to]":
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
      print("----add booking");
      print(responseJson);
    } on SocketException {
      print("No internet");
    }
    return responseJson;
  }
}
