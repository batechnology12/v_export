import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:v_export/customer/model/add_booking_parcel_model.dart';
import 'package:v_export/customer/model/onGoing_order_model.dart';
import 'package:v_export/customer/services/network/booking_api_service/add_booking_parcel_api_service.dart';
import 'package:v_export/customer/services/network/booking_api_service/get_booking_api_service.dart';
import 'package:v_export/customer/services/network/booking_api_service/ongoing_orders_api_service.dart';
import 'package:dio/dio.dart' as dio;
import 'package:v_export/customer/views/bottom_navi_bar/package_send/booking_details.dart';

class ParcelController extends GetxController {
  OngongOrderApiServices ongongOrderApiServices = OngongOrderApiServices();
  List<OngoingOrderData> ongoingOrdersData = [];
  RxBool ongoingorder = false.obs;
  getonGoingOrders() async {
    ongoingorder(true);
    dio.Response<dynamic> response =
        await ongongOrderApiServices.getOngoingOder();
    ongoingorder(false);

    if (response.data["status"] == true) {
      OngoingOrdersModel ongoingOrdersModel =
          OngoingOrdersModel.fromJson(response.data);
      ongoingOrdersData = ongoingOrdersModel.data;
    } else {
      Get.rawSnackbar(
        backgroundColor: Colors.red,
        messageText: Text(
          response.data['message'],
          style: TextStyle(color: Colors.white, fontSize: 15.sp),
        ),
      );
    }
  }

  AddBookingParcelsApiService addBookingParcelsApiService =
      AddBookingParcelsApiService();

  addBookingParcel(AddBookingParcelModel addBookingParcelModel) async {
    dio.Response<dynamic> response = await addBookingParcelsApiService
        .addBookingParcel(addBookingParcelModel);
    if (response.data["status"] == true) {
      Get.rawSnackbar(
        backgroundColor: Colors.green,
        messageText: Text(
          response.data['message'],
          style: TextStyle(color: Colors.white, fontSize: 15.sp),
        ),
      );
      Get.to(BookingDetailsScreen());
    } else {
      Get.rawSnackbar(
        backgroundColor: Colors.red,
        messageText: Text(
          response.data['message'],
          style: TextStyle(color: Colors.white, fontSize: 15.sp),
        ),
      );
    }
  }
}
