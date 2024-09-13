import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v_export/customer/model/get_cancelled_orders_model.dart';
import 'package:v_export/customer/model/get_completed_orders_model.dart';

import 'package:v_export/customer/model/get_ongoing_orders_model.dart';
import 'package:v_export/customer/services/network/booking_api_service/get_cancelled_order_api_service.dart';
import 'package:v_export/customer/services/network/booking_api_service/get_completed_order_api_service.dart';
import 'package:v_export/customer/services/network/booking_api_service/get_ongoing_orders.api_service.dart';

class MyListController extends GetxController {
  GetOngongOrderApiServices getOngongOrderApiServices =
      GetOngongOrderApiServices();
  RxBool getOngoingOrdersLoading = false.obs;
  var getOngoingOrdersModelData =
      <GetOngoingOrdersModelData>[].obs; // Keep this as an observable list
  RxInt iD = 0.obs;

  getOngoingOrdersUser(String ongoingOrder) async {
    getOngoingOrdersLoading(true); // Start loading

    dio.Response response =
        await getOngongOrderApiServices.getOngoingOderUser(ongoingOrder);

    if (response.data["status"] == true) {
      GetOngoingOrdersModel getOngoingOrdersModel =
          GetOngoingOrdersModel.fromJson(response.data);

      if (getOngoingOrdersModel.data.orders.isNotEmpty) {
        getOngoingOrdersModelData.value = getOngoingOrdersModel.data.orders;
        iD.value = getOngoingOrdersModel.data.orders.first.id;

        final SharedPreferences typeID = await SharedPreferences.getInstance();
        await typeID.setString("typeid", iD.value.toString());

        print("rating for id-------------    ${iD.value}");
      } else {
        getOngoingOrdersModelData.clear();
      }
      getOngoingOrdersLoading(false);
      update();
    } else {
      getOngoingOrdersModelData.clear();
      getOngoingOrdersLoading(false);
      update();
    }
  }

  // GetOngongOrderApiServices getOngongOrderApiServices =
  //     GetOngongOrderApiServices();

  // List<GetOngoingOrdersModelData> getOngoingOrdersModelData =
  //     <GetOngoingOrdersModelData>[].obs;

  // RxBool getOngoingOrdersLoading = false.obs;
  // RxInt iD = 0.obs;
  // getOngoingOrdersUser(String ongoingOrder) async {
  //   getOngoingOrdersLoading(true);

  //   dio.Response response =
  //       await getOngongOrderApiServices.getOngoingOderUser(ongoingOrder);

  //   if (response.data["status"] == true) {
  //     GetOngoingOrdersModel getOngoingOrdersModel =
  //         GetOngoingOrdersModel.fromJson(response.data);
  //     getOngoingOrdersModelData = getOngoingOrdersModel.data.orders;

  //     iD.value = getOngoingOrdersModel.data.orders.first.id;

  //     final SharedPreferences typeID = await SharedPreferences.getInstance();
  //     await typeID.setString("typeid", iD.value.toString());

  //     print("rating for id-------------    ${iD.value}");

  //     // Get.rawSnackbar(
  //     //   backgroundColor: Colors.green,
  //     //   messageText: Text(
  //     //     response.data['message'],
  //     //     style: TextStyle(color: Colors.white, fontSize: 15.sp),
  //     //   ),
  //     // );
  //     // update();

  //     getOngoingOrdersLoading(false);
  //     update();
  //   } else {
  //     // Get.rawSnackbar(
  //     //   backgroundColor: Colors.red,
  //     //   messageText: Text(
  //     //     response.data['message'],
  //     //     style: TextStyle(color: Colors.white, fontSize: 15.sp),
  //     //   ),
  //     // );
  //     getOngoingOrdersLoading(false);
  //     update();
  //   }
  // }

  GetCompletedOrderApiServices getCompletedOrderApiServices =
      GetCompletedOrderApiServices();

  List<GetCompletedOrdersModelData> getCompletedOrdersModelData =
      <GetCompletedOrdersModelData>[].obs;
  RxBool getCompletedOrdersLoading = false.obs;
  getCompletedOrdersUser(String completedOrder) async {
    getCompletedOrdersLoading(true);

    dio.Response response =
        await getCompletedOrderApiServices.getCompletedUser(completedOrder);
    getCompletedOrdersLoading(false);
    update();
    if (response.data["status"] == true) {
      GetCompletedOrdersModel getCompletedOrdersModel =
          GetCompletedOrdersModel.fromJson(response.data);
      getCompletedOrdersModelData = getCompletedOrdersModel.data.orders;

      getCompletedOrdersLoading(false);
      update();
    } else {
      // Get.rawSnackbar(
      //   backgroundColor: Colors.red,
      //   messageText: Text(
      //     response.data['message'],
      //     style: TextStyle(color: Colors.white, fontSize: 15.sp),
      //   ),
      // );
    }
  }

  GetCancelledOrderApiServices getCancelledOrderApiServices =
      GetCancelledOrderApiServices();

  List<GetCancelledOrdersModelData> getCancelledOrdersModelData =
      <GetCancelledOrdersModelData>[].obs;
  RxBool getCancelledOrdersLoading = false.obs;
  getCancelledOrderUser(String cancelledOrder) async {
    getCancelledOrdersLoading(true);

    dio.Response response =
        await getCancelledOrderApiServices.getCancelledUser(cancelledOrder);

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
      getCancelledOrdersLoading(false);
      update();
    } else {
      getCancelledOrdersLoading(false);
      update();
      // Get.rawSnackbar(
      //   backgroundColor: Colors.red,
      //   messageText: Text(
      //     response.data['message'],
      //     style: TextStyle(color: Colors.white, fontSize: 15.sp),
      //   ),
      // );
    }
  }
}
