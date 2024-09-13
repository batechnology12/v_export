import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v_export/customer/model/Payment_detalis_data_model.dart';
import 'package:v_export/customer/model/add_booking_parcel_model.dart';
import 'package:v_export/customer/model/add_booking_vehicle_model.dart';
import 'package:v_export/customer/model/additional_service_model.dart';
import 'package:v_export/customer/model/booking_review_detalis_model.dart';
import 'package:v_export/customer/model/delivery_type_model.dart';
import 'package:v_export/customer/model/get_accept_booking_details_model.dart';
import 'package:v_export/customer/model/get_vehicle_calculation_model.dart';
import 'package:v_export/customer/model/get_booking_details_model.dart';
import 'package:v_export/customer/model/get_vehicle_booking_details_model.dart';
import 'package:v_export/customer/model/parcel_ongoing_order_model.dart';
import 'package:v_export/customer/model/onGoing_order_model.dart';
import 'package:v_export/customer/model/redmee_coupons_model.dart';
import 'package:v_export/customer/model/vehicle_type_model.dart';
import 'package:v_export/customer/services/network/booking_api_service/add_booking_parcel_api_service.dart';
import 'package:v_export/customer/services/network/booking_api_service/add_booking_vehicle_api_services.dart';
import 'package:v_export/customer/services/network/booking_api_service/additional_service_api_service.dart';
import 'package:v_export/customer/services/network/booking_api_service/cancel_booking_api_service.dart';
import 'package:v_export/customer/services/network/booking_api_service/get_accepted_booking_details_api_service.dart';
import 'package:v_export/customer/services/network/booking_api_service/get_booking_api_service.dart';
import 'package:v_export/customer/services/network/booking_api_service/get_booking_calculations_api_service.dart';
import 'package:v_export/customer/services/network/booking_api_service/get_booking_details_api_services.dart';
import 'package:v_export/customer/services/network/booking_api_service/get_coupons_parcel_api_service.dart';
import 'package:v_export/customer/services/network/booking_api_service/get_coupons_vehicle_api_service.dart';
import 'package:v_export/customer/services/network/booking_api_service/get_delivery_type_api_services.dart';
import 'package:v_export/customer/services/network/booking_api_service/get_km_api_service.dart';
import 'package:v_export/customer/services/network/booking_api_service/get_vehicle_calculations_api_service.dart';
import 'package:v_export/customer/services/network/booking_api_service/get_vehicle_type_api_service.dart';
import 'package:v_export/customer/services/network/booking_api_service/ongoing_orders_api_service.dart';
import 'package:dio/dio.dart' as dio;
import 'package:v_export/customer/services/network/booking_api_service/rate_driver_api_service.dart';
import 'package:v_export/customer/services/network/booking_api_service/sender_receiver_api_service.dart';
import 'package:v_export/customer/services/network/booking_api_service/update_booking_status_api_service.dart';
import 'package:v_export/customer/views/bottom_navi_bar/bottomn_navi_bar.dart';
import 'package:v_export/customer/views/bottom_navi_bar/package_send/booking_details.dart';
import 'package:v_export/customer/views/bottom_navi_bar/package_send/booking_sucessfully_screen.dart';
import 'package:v_export/customer/views/bottom_navi_bar/package_send/driver/driver_details_screen.dart';
import 'package:v_export/customer/views/bottom_navi_bar/package_send/driver/driver_rating.dart';
import 'package:v_export/customer/views/bottom_navi_bar/package_send/pickup_address_details.dart';
import 'package:v_export/customer/views/bottom_navi_bar/payment_screen.dart/make_payment_screen.dart';
import 'package:v_export/customer/views/bottom_navi_bar/payment_screen.dart/make_payment_screen2.dart';
import 'package:v_export/customer/views/bottom_navi_bar/payment_screen.dart/placed_order.dart';

class ParcelController extends GetxController {
  OngongOrderApiServices ongongOrderApiServices = OngongOrderApiServices();
  List<OngoingOrderData> ongoingOrdersData = [];
  RxBool ongoingorderLoading = false.obs;

  Future<void> getonGoingOrders() async {
    print('getonGoingOrders');
    ongoingorderLoading(true);
    dio.Response<dynamic> response =
        await ongongOrderApiServices.getOngoingOder();
    ongoingorderLoading(false);
    update();
    if (response.data["status"] == true) {
      OngoingOrdersModel ongoingOrdersModel =
          OngoingOrdersModel.fromJson(response.data);

      ongoingOrdersData.clear();
      ongoingOrdersData = ongoingOrdersModel.data;

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
  List<DeliveryTypeData> deliveryTypesData = <DeliveryTypeData>[].obs;
  var istypesLoading = false.obs;
  getDeliveryTypes() async {
    dio.Response<dynamic> response =
        await getDeliveryTypesApiServices.getDeliveryTypes();
    update();
    if (response.data["status"] == true) {
      DeliveyTypesModel deliveyTypesModel =
          DeliveyTypesModel.fromJson(response.data);
      // deliveryTypesData = deliveyTypesModel.data;
      deliveryTypesData.assignAll(deliveyTypesModel.data);
      istypesLoading.value = false;
    } else {
      istypesLoading.value = false;
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

  List<GetVehicleTypeData> vehicleTypesData = <GetVehicleTypeData>[].obs;

  var vehicleTypeLoading = false.obs;
  getVehicleTypes() async {
    //  vehicleTypeLoading(true);
    dio.Response<dynamic> response =
        await getVehicleTypeApiServices.getVehicleType();

    if (response.data["status"] == true) {
      GetVehicleTypeModel getVehicleTypeModel =
          GetVehicleTypeModel.fromJson(response.data);
      // vehicleTypesData = getVehicleTypeModel.data;
      vehicleTypesData.assignAll(getVehicleTypeModel.data);
      vehicleTypeLoading.value = false;
    } else {
      vehicleTypeLoading.value = false;
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

  RxBool addBookingLoading = false.obs;
  RxBool addBookingLoading1 = false.obs;
  BookingData? data;
  int? parcelBookingId;
  String bookingTotalAmount = "";
  addBookingParcel(AddBookingParcelModel addBookingParcelModel,
      String parcelTotalAmount) async {
    addBookingLoading(true);
    addBookingLoading1(false);
    update();
    dio.Response<dynamic> response = await addBookingParcelsApiService
        .addBookingParcel(addBookingParcelModel);

    print("---------response");
    print(response.data);
    if (response.data["status"] == true) {
      parcelBookingId = response.data["data"]["id"];
      bookingTotalAmount = response.data["data"]["total_amount"];

      Get.to(MakePayment(
        bookingid: parcelBookingId.toString(),
        totalAmount: parcelTotalAmount,
      ));
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
      addBookingLoading1(true);
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
  int? vehicleBookingId;
  String vehicleTotalAmount = "";
  RxBool addBookingVehicleLoading = false.obs;
  addBookingVehicleApi(AddBookingVehicleModel addBookingVehicleModel,
      String amountofVehicle) async {
    addBookingVehicleLoading(true);
    dio.Response<dynamic> response = await addBookingVehicleApiService
        .addBookingVehicle(addBookingVehicleModel);
    addBookingVehicleLoading(false);
    print("-------------booking vehicle");
    print(response.data);
    if (response.data["status"] == true) {
      vehicleBookingId = response.data["data"]["id"];
      vehicleTotalAmount = response.data["data"]["total_amount"];
      print("vehicle booking id------");
      print(vehicleBookingId);
      print("vehicle booking amount------");
      print(amountofVehicle);

      Get.to(MakePayment2(
        vehiclebookingid: vehicleBookingId.toString(),
        totalAmountVehicle: amountofVehicle,
      ));
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
      // Get.to(DriverDetailsScreen(
      //   //getAcceptBookingdata: getAcceptBookingdata,
      // ));
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

  double distance = 0.0;

  Future<void> getKiloMeterApi({
    required double lat1,
    required double lon1,
    required double lat2,
    required double lon2,
    required String unit,
  }) async {
    try {
      GetKiloMeterApiServices getKiloMeterApiServices =
          GetKiloMeterApiServices();
      dio.Response<dynamic> response =
          await getKiloMeterApiServices.getKiloMeter(
        lat1: lat1,
        lon1: lon1,
        lat2: lat2,
        lon2: lon2,
        unit: unit,
      );

      distance = response.data["distance"];
      update(); // Notify the UI about the state change
    } catch (e) {
      // Handle error
      print("Error: $e");
    }
  }

  SenderReceiverApiServices senderReceiverApiServices =
      SenderReceiverApiServices();

  senderReceiverApi(String bookingID, String payable) async {
    dio.Response<dynamic> response =
        await senderReceiverApiServices.senderReceiver(bookingID, payable);
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

  UpdateBookinStatusApiServices updateBookinStatusApiServices =
      UpdateBookinStatusApiServices();
  RxBool updateBookingStatusLoading = false.obs;
  updateBookingSatusApi(String iD, String paymentMode) async {
    updateBookingStatusLoading(true);
    dio.Response<dynamic> response = await updateBookinStatusApiServices
        .updateBookingApi(iD: iD, paymentMode: paymentMode);
    updateBookingStatusLoading(false);
    print("response------------------");
    print(response.data);
    if (response.data["status"] == true) {
      Get.to(PlacedOrder());

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

  final MainMenuServices paymentShowService = MainMenuServices();
  List<PaymentData> paymentdata = [];
  var paymentLoad = false.obs;

  Future<void> paymentshow(String bookId) async {
    print('----------');

    paymentLoad.value = true;
    try {
      dio.Response<dynamic> response =
          await paymentShowService.paymentShowing(bookId);
      if (response.data['status'] == true) {
        print('payment show successfully----->>>: ${response.data}');
        PaymentShowModel paymentData = PaymentShowModel.fromJson(response.data);
        paymentdata.clear();
        paymentdata.add(paymentData.data);
        // for (var i = 0; i < paymentdata.length; i++) {
        //   paymentdata.add(paymentData.data[i]);
        // }
        print("payment data--------[]");
        print(paymentdata);
        paymentLoad.value = false;
        update();
      } else {
        print('Not retrived payment data data');
      }
    } catch (e) {
      print(e);
    }
    paymentLoad.value = false;
    update();
  }

  GetBookingCalculationApiServices getBookingCalculationApiServices =
      GetBookingCalculationApiServices();
  List<PaymentDetailsData> paymentdatalist = <PaymentDetailsData>[].obs;

  getBookingCalculationApi(
      String deliveryType,
      String distance,
      String roundTrip,
      List<String> locationKg,
      List<String> locationQty,
      List<String> additionServiceId,
      List<String> additionalServiceQty,
      String postalcode) async {
    dio.Response<dynamic> response =
        await getBookingCalculationApiServices.getBookingCalculation(
            deliveryType,
            distance,
            roundTrip,
            locationKg,
            locationQty,
            additionServiceId,
            additionalServiceQty,
            postalcode);
    if (response.data["status"] == "success") {
      PaymentDetalis paymentDatas = PaymentDetalis.fromJson(response.data);
      paymentdatalist.clear();
      paymentdatalist.add(paymentDatas.paymentDetails);
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

  GetVehicleCalculationApiServices getVehicleCalculationApiServices =
      GetVehicleCalculationApiServices();
  List<VehiclePaymentDetails> getvehicleCalculationDatas =
      <VehiclePaymentDetails>[].obs;
  getVehicleCalculationApi(
      String vehicleType,
      String distance,
      String roundTrip,
      String additionStopCount,
      String driverHelp,
      String helperQty,
      String weekend,
      List<String> additionServiceId,
      List<String> additionalServiceQty,
      String postalcode) async {
    try {
      dio.Response<dynamic> response =
          await getVehicleCalculationApiServices.getVehicleCalculation(
              vehicleType,
              distance,
              roundTrip,
              additionStopCount,
              driverHelp,
              helperQty,
              weekend,
              additionServiceId,
              additionalServiceQty,
              postalcode);
      if (response.data["status"] == "success") {
        GetVehicleCalculation getVehicleCalculationDataList =
            GetVehicleCalculation.fromJson(response.data);
        getvehicleCalculationDatas.clear();
        getvehicleCalculationDatas
            .add(getVehicleCalculationDataList.paymentDetails);
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
    } catch (e) {
      print(e);
    }
  }

  CancelBookingApiServices cancelBookingApiServices =
      CancelBookingApiServices();

  RxBool cancelBookingLoading = false.obs;
  cancelBooking(String bookingId, String reason) async {
    cancelBookingLoading(true);
    dio.Response<dynamic> response =
        await cancelBookingApiServices.cancelBooking(bookingId, reason);
    cancelBookingLoading(false);
    if (response.data["status"] == true) {
      //  Get.to(BottomNavigationScreen(indexes: 0));
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

  RateDriverApiService rateDriverApiService = RateDriverApiService();
  int? bookingIdDriver;

  rateDriverApi(String ratingBookingId, String rating, String review) async {
    dio.Response<dynamic> response = await rateDriverApiService.rateDriverApi(
        ratingBookingId, rating, review);
    print(" driver rate response=---------");
    print(response.data);
    if (response.data["status"] == true) {
      print("booking id for driver rate");

      update();

      Get.rawSnackbar(
        backgroundColor: Colors.green,
        messageText: Text(
          response.data['message'],
          style: TextStyle(color: Colors.white, fontSize: 15.sp),
        ),
      );
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

  RedeemCouponApiServices redeemCouponApiServices = RedeemCouponApiServices();
  List<RedeemeCouponData> redmeeCouponsData = <RedeemeCouponData>[].obs;
  redeemeCouponsApi(String coupon) async {
    try {
      dio.Response<dynamic> response =
          await redeemCouponApiServices.redmeeCoupons(coupon);
      if (response.data["success"] == true) {
        GetRedeemeModel getRedeemeModel =
            GetRedeemeModel.fromJson(response.data);

        redmeeCouponsData.add(getRedeemeModel.data);
        Get.rawSnackbar(
          backgroundColor: Colors.green,
          messageText: Text(
            response.data['message'],
            style: TextStyle(color: Colors.white, fontSize: 15.sp),
          ),
        );
      } else {
        Get.rawSnackbar(
          backgroundColor: Colors.red,
          messageText: Text(
            "Coupon code is Invalid",
            //  response.data['message'],
            style: TextStyle(color: Colors.white, fontSize: 15.sp),
          ),
        );
      }
    } catch (e) {
      print("---------catch---  $e");
    }
  }

  RedeemCouponParcelApiServices redeemCouponParcelApiServices =
      RedeemCouponParcelApiServices();

  List<RedeemeCouponData> redmeeCouponsParcelData = <RedeemeCouponData>[].obs;

  redmeeCouponParcelApi(String coupon) async {
    try {
      dio.Response<dynamic> response =
          await redeemCouponParcelApiServices.redmeeCouponsParcel(coupon);
      if (response.data["success"] == true) {
        GetRedeemeModel getRedeemeModel =
            GetRedeemeModel.fromJson(response.data);
        redmeeCouponsParcelData.add(getRedeemeModel.data);
        Get.rawSnackbar(
          backgroundColor: Colors.green,
          messageText: Text(
            response.data['message'],
            style: TextStyle(color: Colors.white, fontSize: 15.sp),
          ),
        );
      } else {
        Get.rawSnackbar(
          backgroundColor: Colors.red,
          messageText: Text(
            "Coupon code is Invalid",
            //  response.data['message'],
            style: TextStyle(color: Colors.white, fontSize: 15.sp),
          ),
        );
      }
    } catch (e) {
      print(" $e");
    }
  }
}
