import 'dart:io';

class AddBookingVehicleModel {
  String pickupAddress;
  String vehicleType;
  String paymentMode;
  String bookingAmount;
  String gst;
  String additionalTotal;
  String totalAmount;
  String isRoundTrip;
  String pickupDate;
  String pickupTimeFrom;
  String pickupTimeTo;
  String latitude;
  String longitude;
  String distance;
  String bookingType;
  String bookingTime;
  List<int> additionalDetails;
  String notes;
  List<BookingVehicleAddress> bookingVehicleAddress;
  // List<Products> productss;
  String parcelPhoto;

  AddBookingVehicleModel({
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
  String unitNoBlockNo;
  List<String> address;

  List<String> postalCode;
  List<String> latitude;
  List<String> longitude;
  String deliveryStatus;
  List<String> reciverName;
  List<String> reciverMobile;
  List<String> vehiclereciverUnitIdBlockId;

  BookingVehicleAddress({
    required this.senderName,
    required this.senderMobile,
    required this.unitNoBlockNo,
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
