import 'dart:io';

class AddBookingParcelModel {
  String pickupAddress;
  String deliveryTypeid;
  String paymentMode;
  String bookingAmount;
  String gst;
  String additionalTotal;
  String totalAmount;
  String isRoundTrip;
  String bookingDate;
  String pickupTimeFrom;
  String pickupTimeTo;
  String deliveryDate;
  String deliveryTimeFrom;
  String deliveryTimeTo;
  String latitude;
  String longitude;
  String distance;
  String bookingType;
  List<int> additionalDetails;
  String notes;
  List<Product> products;
  List<BookingAddress> bookingAddress;
  String parcelPhoto;
  String totalAmountCost;

  AddBookingParcelModel({
    required this.totalAmountCost,
    required this.pickupAddress,
    required this.deliveryTypeid,
    required this.paymentMode,
    required this.bookingAmount,
    required this.gst,
    required this.additionalTotal,
    required this.totalAmount,
    required this.isRoundTrip,
    required this.bookingDate,
    required this.pickupTimeFrom,
    required this.pickupTimeTo,
    required this.deliveryDate,
    required this.deliveryTimeFrom,
    required this.deliveryTimeTo,
    required this.latitude,
    required this.longitude,
    required this.distance,
    required this.bookingType,
    required this.additionalDetails,
    required this.notes,
    required this.products,
    required this.bookingAddress,
    required this.parcelPhoto,
  });
}

class Product {
  String parcelItems;
  List<String> length;
  List<String> width;
  List<String> height;
  List<String> qty;
  List<String> kg;
  String pickupTimeFrom;
  String pickupTimeTo;
  String deliveryDate;
  String deliveryTimeFrom;
  String deliveryTimeTo;

  Product({
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

class BookingAddress {
  String customerName;
  String customerMobile;
  List<String> unitNoBlockNo;
  List<String> address;
  List<String> postalCode;
  List<String> latitude;
  List<String> longitude;
  String deliveryStatus;
  String deliveryTimeFrom;
  String deliveryTimeTo;
  List<String> reciverName;
  List<String> reciverMobile;
  String reciverUnitIdBlockId;

  BookingAddress({
    required this.customerName,
    required this.customerMobile,
    required this.unitNoBlockNo,
    required this.address,
    required this.postalCode,
    required this.latitude,
    required this.longitude,
    required this.deliveryStatus,
    required this.deliveryTimeFrom,
    required this.deliveryTimeTo,
    required this.reciverMobile,
    required this.reciverName,
    required this.reciverUnitIdBlockId,
  });
}

// class AddBookingParcelModel {
//   String? deliveryTypeid;
// //  String? paymentmode;
//   // String? bookingAmount;
//   // String? gst;
//   // String? additionalTotal;
//   // String? totalAmount;
//   // bool? roundTrip;
//   String? bookingDate;
//   String? pickupTimeFrom;
//   String? pickupTimeTo;
//   String? deliveryDate;
//   String? deliveryTimeFrom;
//   List<String>? deliveryTimeTo;
//   String? latitude;
//   String? longitude;
//   String? distance;
//   File? parcelPhoto;
//   // String? bookingType;
//   List? additionalDetails;
//   String? notes;
//   List? parcelItem;
//   List? length;
//   List? width;
//   List? height;
//   List? qty;
//   List? kg;
//   List? pickupTimeFromList;
//   List? pickupTimeToList;

//   List? deliveryDateList;

//   List? deliveryTimeFromList;
//   List? deliveryTimeToList;

//   List? customerName;
//   List? customerMobile;
//   List? blockNoUnitNo;
//   List? address;

//   List? postalCode;

//   List? latitudeList;
//   List? logitudeList;
//   List? deliveryStatus;
//   List<String>? addressDeliveryTimeFromList;
//   List<String>? addressDeliveryTimeToList;

//   AddBookingParcelModel({
//     this.deliveryTypeid,
//     // this.paymentmode,
//     // this.bookingAmount,
//     // this.gst,
//     // this.additionalTotal,
//     // this.totalAmount,
//     // this.roundTrip,
//     this.bookingDate,
//     this.pickupTimeFrom,
//     this.pickupTimeTo,
//     this.deliveryDate,
//     this.deliveryTimeFrom,
//     this.deliveryTimeTo,
//     this.latitude,
//     this.longitude,
//     this.distance,
//     this.parcelPhoto,
//     //  this.bookingType,
//     this.additionalDetails,
//     this.notes,
//     this.parcelItem,
//     this.length,
//     this.width,
//     this.height,
//     this.qty,
//     this.kg,
//     this.pickupTimeFromList,
//     this.pickupTimeToList,
//     this.deliveryDateList,
//     this.deliveryTimeFromList,
//     this.deliveryTimeToList,
//     this.customerName,
//     this.customerMobile,
//     this.blockNoUnitNo,
//     this.address,
//     this.postalCode,
//     this.latitudeList,
//     this.logitudeList,
//     this.deliveryStatus,
//     this.addressDeliveryTimeFromList,
//     this.addressDeliveryTimeToList,
//   });
// }
