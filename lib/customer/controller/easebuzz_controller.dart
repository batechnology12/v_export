import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:v_export/constant/app_colors.dart';
import 'package:v_export/customer/controller/parcel_controller.dart';
import 'package:v_export/customer/services/network/easebuzz_api_service.dart';
import 'package:v_export/customer/views/bottom_navi_bar/package_send/booking_sucessfully_screen.dart';

class EasebuszzController extends GetxController {
  RxBool isLoading = false.obs;

  static MethodChannel _channel = MethodChannel('easebuzz');
  EaseBuzzTokenApiService easeBuzzApi = EaseBuzzTokenApiService();
  ParcelController parcelController = Get.put(ParcelController());

  tablepayUseingEaseBuzzSubs(
      {required String bookingid, required String payment_mode1}) async {
    var response = await easeBuzzApi.getPaymentToken(
      amount: '1.00',
      email: 'venkat@gmail.com',
      phone: '9789450041',
      customerName: 'venkat',
    );

    print('::::::transaction easebusz id:::::::::');
    print(response['data']);

    String access_key = response['data'];
    String pay_mode = "test";

    print("access_key >>$access_key");
    Object parameters = {"access_key": access_key, "pay_mode": pay_mode};
    // isPayLoading(false);
    isLoading(false);
    final payment_response =
        await _channel.invokeMethod("payWithEasebuzz", parameters);
    print(payment_response);
    isLoading(false);
    if (payment_response["result"] == "payment_successfull") {
      String transactionId = "";
      parcelController.updateBookingSatusApi(bookingid, payment_mode1);
      Get.to(const BookingSucessfullyScreen());
    } else {
      // Get.to(TabelPaymentFailScreen());
      Get.snackbar(
          "The last transaction has been cancelled!", "Please try again!",
          colorText: AppColors.kwhite,
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
