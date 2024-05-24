import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:v_export/constant/app_colors.dart';
import 'package:v_export/customer/services/network/easebuzz_api_service.dart';
import 'package:v_export/customer/views/home/package_send/booking_sucessfully_screen.dart';

class EasebuszzController extends GetxController{

RxBool isLoading=false.obs;
  
    static MethodChannel _channel = MethodChannel('easebuzz');
  EaseBuzzTokenApiService easeBuzzApi = EaseBuzzTokenApiService();

  tablepayUseingEaseBuzzSubs(
      //{
      // required String mobilenumber,
      // required String email,
      // required String amount,
      // required String name,
      // required String seatId,
      // required String bookingdate,
      // required String planId,
      // required TabelData? tabeldata,
      // required String hour,
      // required bool locker,
      // required Slot selectedSlot,
      //}
      )
       async {

     //double totalAmount = double.parse(amount);


    // if(locker){
    //   double loackerAmount = double.parse(tabeldata!.lockerAmount);

    //   totalAmount = totalAmount + loackerAmount;
    // }

    var response = await easeBuzzApi.getPaymentToken(
        amount: '1.00',
        email: 'sharmilaatoffice@gmail.com',
        phone: '9043131548',
        customerName: 'sharmila',);


    print('::::::transaction easebusz id:::::::::');
    print(response['data']);

    // String access_key = response["data"];
    // String pay_mode = "test";
      String access_key =response['data'];
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
      //need to give id
      String transactionId = "";
        //  tabelBooking(
        //   seatId: tabeldata!.id.toString(),
        //   bookingdate: bookingdate, 
        //   planId: planId, 
        //   hour:hour, 
        //   selectedSlot: selectedSlot,
        //   locker: locker);
          
        Get.to(BookingSucessfullyScreen());
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