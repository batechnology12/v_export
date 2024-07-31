import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:v_export/customer/model/add_booking_parcel_model.dart';
import 'package:v_export/customer/model/add_booking_vehicle_model.dart';
import 'package:v_export/customer/model/additional_service_model.dart';
import 'package:v_export/customer/model/booking_review_detalis_model.dart';
import 'package:v_export/customer/model/delivery_type_model.dart';
import 'package:v_export/customer/model/get_accept_booking_details_model.dart';
import 'package:v_export/customer/model/get_vehicle_booking_details_model.dart';
import 'package:v_export/customer/model/parcel_ongoing_order_model.dart';
import 'package:v_export/customer/model/onGoing_order_model.dart';
import 'package:v_export/customer/model/vehicle_type_model.dart';
import 'package:v_export/customer/services/network/booking_api_service/add_booking_parcel_api_service.dart';
import 'package:v_export/customer/services/network/booking_api_service/add_booking_vehicle_api_services.dart';
import 'package:v_export/customer/services/network/booking_api_service/additional_service_api_service.dart';
import 'package:v_export/customer/services/network/booking_api_service/cancel_booking_api_service.dart';
import 'package:v_export/customer/services/network/booking_api_service/get_accepted_booking_details_api_service.dart';
import 'package:v_export/customer/services/network/booking_api_service/get_booking_api_service.dart';
import 'package:v_export/customer/services/network/booking_api_service/get_delivery_type_api_services.dart';
import 'package:v_export/customer/services/network/booking_api_service/get_km_api_service.dart';
import 'package:v_export/customer/services/network/booking_api_service/get_vehicle_type_api_service.dart';
import 'package:v_export/customer/services/network/booking_api_service/ongoing_orders_api_service.dart';
import 'package:dio/dio.dart' as dio;
import 'package:v_export/customer/services/network/booking_api_service/sender_receiver_api_service.dart';
import 'package:v_export/customer/views/bottom_navi_bar/package_send/booking_details.dart';
import 'package:v_export/customer/views/bottom_navi_bar/package_send/driver/vehicle_booking_details.dart';
import 'package:v_export/customer/views/bottom_navi_bar/package_send/driver/driver_details_screen.dart';
import 'package:v_export/customer/views/bottom_navi_bar/package_send/pickup_address_details.dart';
import 'package:v_export/customer/views/bottom_navi_bar/payment_screen.dart/make_payment_screen.dart';

class ParcelController extends GetxController {
  OngongOrderApiServices ongongOrderApiServices = OngongOrderApiServices();
  OngoingOrderData? ongoingOrdersData;

  //ParcelOngoingOrderData? parcelOngoingOrderData;
  RxBool ongoingorderLoading = false.obs;
  // RxBool parcelongoingorderLoading = false.obs;
  getonGoingOrders() async {
    ongoingorderLoading(true);
    //  parcelongoingorderLoading(true);
    dio.Response<dynamic> response =
        await ongongOrderApiServices.getOngoingOder();
    ongoingorderLoading(false);
    //   parcelongoingorderLoading(false);

    if (response.data["status"] == true) {
      OngoingOrdersModel ongoingOrdersModel =
          OngoingOrdersModel.fromJson(response.data);
      ongoingOrdersData = ongoingOrdersModel.data;

      //
      // ParcelOngoingOrdersModel parcelOngoingOrdersModel =
      //     ParcelOngoingOrdersModel.fromJson(response.data);
      // parcelOngoingOrderData = parcelOngoingOrdersModel.data;
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

  GetVehicleTypeApiServices getVehicleTypeApiServices =
      GetVehicleTypeApiServices();

  List<GetVehicleTypeData> vehicleTypesData = [];

  RxBool vehicleTypeLoading = false.obs;
  getVehicleTypes() async {
    vehicleTypeLoading(true);
    dio.Response<dynamic> response =
        await getVehicleTypeApiServices.getVehicleType();
    vehicleTypeLoading(false);
    if (response.data["status"] == true) {
      GetVehicleTypeModel getVehicleTypeModel =
          GetVehicleTypeModel.fromJson(response.data);
      vehicleTypesData = getVehicleTypeModel.data;
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

  GetAdditionalApiServices getAdditionalApiServices =
      GetAdditionalApiServices();

  List additionalServiceData = <AdditionalServiceData>[].obs;
  RxBool additionalServiceLoading = false.obs;
  getAdditionalServices(String serviceType) async {
    additionalServiceLoading(true);
    dio.Response<dynamic> response =
        await getAdditionalApiServices.getAdditionalServices(serviceType);
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
      //  update();
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
  // String driverbookingid = "";
  RxBool addBookingLoading = false.obs;
  BookingData? data;
  addBookingParcel(AddBookingParcelModel addBookingParcelModel) async {
    addBookingLoading(true);
    update();
    dio.Response<dynamic> response = await addBookingParcelsApiService
        .addBookingParcel(addBookingParcelModel);

    print("---------response");
    print(response.data);
    if (response.data["status"] == true) {
      // GetBookingdetailsModeldata getBookingdetailsModeldata =
      //     GetBookingdetailsModeldata.fromJson(response.data);
      // data = getBookingdetailsModeldata.data;
      //  driverbookingid = data!.id.toString();
      Get.to(MakePayment());
      // Get.rawSnackbar(
      //   backgroundColor: Colors.green,
      //   messageText: Text(
      //     response.data['message'],
      //     style: TextStyle(color: Colors.white, fontSize: 15.sp),
      //   ),
      // );
      //  data.add(Bookingdata.fromJson(bookingData));
      // Get.to(BookingDetailsScreen(

      // ));
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

  AddBookingVehicleApiService addBookingVehicleApiService =
      AddBookingVehicleApiService();
  GetVehicleBookingDetailsData? getVehicleBookingDetailsData;

  RxBool addBookingVehicleLoading = false.obs;
  addBookingVehicleApi(AddBookingVehicleModel addBookingVehicleModel) async {
    addBookingVehicleLoading(true);
    dio.Response<dynamic> response = await addBookingVehicleApiService
        .addBookingVehicle(addBookingVehicleModel);
    addBookingVehicleLoading(false);
    print("-------------booking vehicle");
    print(response.data);
    if (response.data["status"] == true) {
      Get.to(MakePayment());
      // GetVehicleBookingDetailsModel getVehicleBookingDetailsModel =
      //     GetVehicleBookingDetailsModel.fromJson(response.data);
      // getVehicleBookingDetailsData = getVehicleBookingDetailsModel.data;
      // Get.to(DriverBookingDetails(
      //     getVehicleBookingDetailsDataList: getVehicleBookingDetailsData!));
      // Get.rawSnackbar(
      //   backgroundColor: Colors.green,
      //   messageText: Text(
      //     response.data['message'],
      //     style: TextStyle(color: Colors.white, fontSize: 15.sp),
      //   ),
      // );
      addBookingVehicleLoading(false);
      update();
    } else {
      addBookingVehicleLoading(false);
      update();
      Get.rawSnackbar(
        backgroundColor: Colors.red,
        messageText: Text(
          response.data['message'],
          style: TextStyle(color: Colors.white, fontSize: 15.sp),
        ),
      );
    }
  }

  CancelBookingApiServices cancelBookingApiServices =
      CancelBookingApiServices();

  RxBool cancelBookingLoading = false.obs;
  cancelBooking(String bookingId) async {
    cancelBookingLoading(true);
    dio.Response<dynamic> response =
        await cancelBookingApiServices.cancelBooking(bookingId);
    cancelBookingLoading(false);
    if (response.data["status"] == true) {
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

  GetAcceptBookingDetailsApiServices getAcceptBookingDetailsApiServices =
      GetAcceptBookingDetailsApiServices();
  GetAcceptBookingdata? getAcceptBookingdata;
  RxBool getacceptBookingLoading = false.obs;
  bool status = false;
  getAcceptBooking(String bookingId) async {
    getacceptBookingLoading(true);
    dio.Response<dynamic> response = await getAcceptBookingDetailsApiServices
        .getAcceptBookingDetails(bookingId);
    if (response.data["status"] == true) {
      status = response.data["status"];
      GetAcceptBookingModeldata getAcceptBookingModeldata =
          GetAcceptBookingModeldata.fromJson(response.data);
      getAcceptBookingdata = getAcceptBookingModeldata.data;
      Get.to(DriverDetailsScreen(
        getAcceptBookingdata: getAcceptBookingdata,
      ));
      // Get.rawSnackbar(
      //   backgroundColor: Colors.green,
      //   messageText: Text(
      //     response.data['message'],
      //     style: TextStyle(color: Colors.white, fontSize: 15.sp),
      //   ),
      // );

      getacceptBookingLoading(false);
    } else {
      update();
      Get.rawSnackbar(
        backgroundColor: Colors.red,
        messageText: Text(
          response.data['message'],
          style: TextStyle(color: Colors.white, fontSize: 15.sp),
        ),
      );
    }
  }

  GetKiloMeterApiServices getKiloMeterApiServices = GetKiloMeterApiServices();
  //   RxBool getKiloMeterLoading = false.obs;
  double distance = 0;
  getKiloMeterApi(
      {required double lat1,
      required double lon1,
      required double lat2,
      required double lon2,
      required String unit}) async {
    dio.Response<dynamic> response = await getKiloMeterApiServices.getKiloMeter(
        lat1: lat1, lon1: lon1, lat2: lat2, lon2: lon2, unit: unit);

    distance = response.data["distance"];
    print("------distance");
    print(distance);
    // if (response.data["status"] == true) {
    //     
    //   Get.rawSnackbar(
    //     backgroundColor: Colors.green,
    //     messageText: Text(
    //       response.data['message'],
    //       style: TextStyle(color: Colors.white, fontSize: 15.sp),
    //     ),
    //   );
    //   update();
    // } else {
    //   update();
    //   Get.rawSnackbar(
    //     backgroundColor: Colors.red,
    //     messageText: Text(
    //       response.data['message'],
    //       style: TextStyle(color: Colors.white, fontSize: 15.sp),
    //     ),
    //   );
    // }
  }

  SenderReceiverApiServices senderReceiverApiServices =
      SenderReceiverApiServices();

  senderReceiverApi(String bookingID, String payable) async {
    dio.Response<dynamic> response =
        await senderReceiverApiServices.senderReceiver(bookingID, payable);
    if (response.data["status"] == true) {
      Get.rawSnackbar(
        backgroundColor: Colors.green,
        messageText: Text(
          response.data['message'],
          style: TextStyle(color: Colors.white, fontSize: 15.sp),
        ),
      );
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
