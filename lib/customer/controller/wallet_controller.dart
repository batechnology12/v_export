import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:v_export/customer/controller/easebuzz_controller.dart';
import 'package:v_export/customer/controller/home_controller.dart';
import 'package:v_export/customer/controller/parcel_controller.dart';
import 'package:v_export/customer/model/wallet_model.dart';
import 'package:v_export/customer/services/network/booking_api_service/topup_api_service.dart';
import 'package:dio/dio.dart' as dio;
import 'package:v_export/customer/services/network/booking_api_service/wallet_api_service.dart';
import 'package:v_export/customer/services/network/wallet_api_service/wallet_api_service.dart';

class WalletController extends GetxController {
  EasebuszzController easebuszzController = Get.put(EasebuszzController());
  ParcelController parcelController = Get.put(ParcelController());
  TopUpApiServices topUpApiServices = TopUpApiServices();
  topupApi(String amount) async {
    dio.Response<dynamic> response = await topUpApiServices.topUpApi(amount);

    if (response.data["status"] == true) {
      easebuszzController.tablepayUseingEaseBuzzSubs(
          bookingid: "", payment_mode1: "ONLINE");
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

  WalletApiServices walletApiServices = WalletApiServices();
  List<WalletData> walletDataList = [];
  
  walletAPi() async {
    dio.Response<dynamic> response = await walletApiServices.walletApi();
    if (response.data["status"] == true) {
      WalletShowModel walletShowModel = WalletShowModel.fromJson(response.data);
      walletDataList.add(walletShowModel.data);
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
}
