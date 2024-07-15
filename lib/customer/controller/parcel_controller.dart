import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:v_export/customer/model/add_booking_parcel_model.dart';
import 'package:v_export/customer/model/additional_service_model.dart';
import 'package:v_export/customer/model/booking_review_detalis_model.dart';
import 'package:v_export/customer/model/delivery_type_model.dart';
import 'package:v_export/customer/model/onGoing_order_model.dart';
import 'package:v_export/customer/services/network/booking_api_service/add_booking_parcel_api_service.dart';
import 'package:v_export/customer/services/network/booking_api_service/additional_service_api_service.dart';
import 'package:v_export/customer/services/network/booking_api_service/get_booking_api_service.dart';
import 'package:v_export/customer/services/network/booking_api_service/get_delivery_type_api_services.dart';
import 'package:v_export/customer/services/network/booking_api_service/ongoing_orders_api_service.dart';
import 'package:dio/dio.dart' as dio;
import 'package:v_export/customer/views/bottom_navi_bar/package_send/booking_details.dart';
import 'package:v_export/customer/views/bottom_navi_bar/package_send/pickup_address_details.dart';

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

  GetDeliveryTypesApiServices getDeliveryTypesApiServices =
      GetDeliveryTypesApiServices();
  List<DeliveryTypeData> deliveryTypesData = [];

  getDeliveryTypes() async {
    dio.Response<dynamic> response =
        await getDeliveryTypesApiServices.getDeliveryTypes();
    if (response.data["status"] == true) {
      DeliveyTypesModel deliveyTypesModel =
          DeliveyTypesModel.fromJson(response.data);
      deliveryTypesData = deliveyTypesModel.data;
      update();
      // Get.rawSnackbar(
      //   backgroundColor: Colors.green,
      //   messageText: Text(
      //     response.data['message'],
      //     style: TextStyle(color: Colors.white, fontSize: 15.sp),
      //   ),
      // );
      // update();
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

  GetAdditionalApiServices getAdditionalApiServices =
      GetAdditionalApiServices();

  List additionalServiceData = <AdditionalServiceData>[].obs;
  RxBool additionalServiceLoading = false.obs;
  getAdditionalServices() async {
    additionalServiceLoading(true);
    dio.Response<dynamic> response =
        await getAdditionalApiServices.getAdditionalServices();
    additionalServiceLoading(false);
    if (response.data["status"] == true) {
      AdditionalServicesModel additionalServicesModel =
          AdditionalServicesModel.fromJson(response.data);
      additionalServiceData = additionalServicesModel.data;
      update();
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

  AddBookingParcelsApiService addBookingParcelsApiService =
      AddBookingParcelsApiService();
  RxBool addBookingLoading = false.obs;
  List<Bookingdata> data = [];
  addBookingParcel(AddBookingParcelModel addBookingParcelModel) async {
    addBookingLoading(true);
    update();
    dio.Response<dynamic> response = await addBookingParcelsApiService
        .addBookingParcel(addBookingParcelModel);

    print("---------response");
    print(response.data);
    if (response.data["status"] == true) {
      Map<String, dynamic> bookingData = response.data["data"];

      data.add(Bookingdata.fromJson(bookingData));
      Get.rawSnackbar(
        backgroundColor: Colors.green,
        messageText: Text(
          response.data['message'],
          style: TextStyle(color: Colors.white, fontSize: 15.sp),
        ),
      );

      Get.to(BookingDetailsScreen(
        bookingdatalist: data,
      ));
      addBookingLoading(false);
      update();
    } else {
      addBookingLoading(false);
      update();
      Get.rawSnackbar(
        backgroundColor: Colors.red,
        messageText: Text(
          response.data['message'],
          style: TextStyle(color: Colors.white, fontSize: 15.sp),
        ),
      );
    }
    addBookingLoading(false);
    update();
  }
}
