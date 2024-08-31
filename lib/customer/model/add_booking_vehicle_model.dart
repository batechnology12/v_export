import 'dart:io';

import 'package:v_export/customer/model/additional_service_model.dart';

class AddBookingVehicleModel {
  String pickupunitId;
  String pickupAddress;
  String vehicleType;
  String paymentMode;
  String bookingAmount;
  String gst;
  String additionalTotal;
  String totalAmount;
  String isRoundTrip;
  String pickupDate;
  String paymentDetails;
  String pickupTimeFrom;
  String pickupTimeTo;
  String latitude;
  String longitude;
  String distance;
  String bookingType;
  String bookingTime;
  List<AdditionalServiceData> additionalDetails;
  int totalManpwoerValue;
  int totalStaircaseValue;
  // List<int> additionalDetailsQty;
  String notes;
  List<BookingVehicleAddress> bookingVehicleAddress;
  String parcelPhoto;
  String senderUnitId;
  // String bookingAmount;
  AddBookingVehicleModel({
    required this.paymentDetails,
    required this.totalManpwoerValue,
    required this.totalStaircaseValue,
    //  required this.additionalDetailsQty,
    required this.senderUnitId,
    required this.pickupunitId,
    required this.pickupAddress,
    required this.vehicleType,
    required this.paymentMode,
    required this.bookingAmount,
    required this.bookingTime,
    required this.gst,
    required this.additionalTotal,
    required this.totalAmount,
    required this.isRoundTrip,
    required this.pickupDate,
    required this.pickupTimeFrom,
    required this.pickupTimeTo,
    required this.latitude,
    required this.longitude,
    required this.distance,
    required this.bookingType,
    required this.additionalDetails,
    required this.notes,
    required this.bookingVehicleAddress,
    // required this.productss,
    required this.parcelPhoto,
  });
}

class BookingVehicleAddress {
  String senderName;
  String senderMobile;
  //String unitNoBlockNo;
  String address;
  List<String> postalCode;
  String latitude;
  String longitude;
  String deliveryStatus;
  String reciverName;
  String reciverMobile;
  String vehiclereciverUnitIdBlockId;
  String vehicleUnitId;

  BookingVehicleAddress({
    required this.vehicleUnitId,
    required this.senderName,
    required this.senderMobile,
    //  required this.unitNoBlockNo,
    required this.address,
    required this.postalCode,
    required this.latitude,
    required this.longitude,
    required this.deliveryStatus,
    required this.reciverMobile,
    required this.reciverName,
    required this.vehiclereciverUnitIdBlockId,
  });
}

class Products {
  String parcelItems;
  String length;
  String width;
  String height;
  int qty;
  String kg;
  String pickupTimeFrom;
  String pickupTimeTo;
  String deliveryDate;
  String deliveryTimeFrom;
  String deliveryTimeTo;

  Products({
    required this.parcelItems,
    required this.length,
    required this.width,
    required this.height,
    required this.qty,
    required this.kg,
    required this.pickupTimeFrom,
    required this.pickupTimeTo,
    required this.deliveryDate,
    required this.deliveryTimeFrom,
    required this.deliveryTimeTo,
  });
}
