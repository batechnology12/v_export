import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:v_export/customer/model/get_cancelled_orders_model.dart';
import 'package:v_export/customer/model/get_completed_orders_model.dart';

import 'package:v_export/customer/model/get_ongoing_orders_model.dart';
import 'package:v_export/customer/services/network/booking_api_service/get_cancelled_order_api_service.dart';
import 'package:v_export/customer/services/network/booking_api_service/get_completed_order_api_service.dart';
import 'package:v_export/customer/services/network/booking_api_service/get_ongoing_orders.api_service.dart';

class MyListController extends GetxController {
  GetOngongOrderApiServices getOngongOrderApiServices =
      GetOngongOrderApiServices();

  List<GetOngoingOrdersModelData> getOngoingOrdersModelData = [];
  RxBool getOngoingOrdersLoading = false.obs;
  getOngoingOrdersUser(String ongoingOrder) async {
    getOngoingOrdersLoading(true);
    dio.Response response =
        await getOngongOrderApiServices.getOngoingOderUser(ongoingOrder);
    getOngoingOrdersLoading(false);
    update();
    if (response.data["status"] == true) {
      GetOngoingOrdersModel getOngoingOrdersModel =
          GetOngoingOrdersModel.fromJson(response.data);
      getOngoingOrdersModelData = getOngoingOrdersModel.data.orders;
      // Get.rawSnackbar(
      //   backgroundColor: Colors.green,
      //   messageText: Text(
      //     response.data['message'],
      //     style: TextStyle(color: Colors.white, fontSize: 15.sp),
      //   ),
      // );
      update();
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

  GetCompletedOrderApiServices getCompletedOrderApiServices =
      GetCompletedOrderApiServices();

  List<GetCompletedOrdersModelData> getCompletedOrdersModelData = [];
  RxBool getCompletedOrdersLoading = false.obs;
  getCompletedOrdersUser(String completedOrder) async {
    getCompletedOrdersLoading(true);
    dio.Response response =
        await getCompletedOrderApiServices.getCompletedUser(completedOrder);
    getCompletedOrdersLoading(false);
    if (response.data["status"] == true) {
      GetCompletedOrdersModel getCompletedOrdersModel =
          GetCompletedOrdersModel.fromJson(response.data);
      getCompletedOrdersModelData = getCompletedOrdersModel.data.orders;
      // Get.rawSnackbar(
      //   backgroundColor: Colors.green,
      //   messageText: Text(
      //     response.data['message'],
      //     style: TextStyle(color: Colors.white, fontSize: 15.sp),
      //   ),
      // );
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

  GetCancelledOrderApiServices getCancelledOrderApiServices =
      GetCancelledOrderApiServices();

  List<GetCancelledOrdersModelData> getCancelledOrdersModelData = [];
  RxBool getCancelledOrdersLoading = false.obs;
  getCancelledOrderUser(String cancelledOrder) async {
    getCancelledOrdersLoading(true);
    dio.Response response =
        await getCancelledOrderApiServices.getCancelledUser(cancelledOrder);
    getCancelledOrdersLoading(false);
    if (response.data["status"] == true) {
      GetCancelledOrdersModel getCancelledOrdersModel =
          GetCancelledOrdersModel.fromJson(response.data);
      getCancelledOrdersModelData = getCancelledOrdersModel.data.orders;
      // Get.rawSnackbar(
      //   backgroundColor: Colors.green,
      //   messageText: Text(
      //     response.data['message'],
      //     style: TextStyle(color: Colors.white, fontSize: 15.sp),
      //   ),
      // );
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
