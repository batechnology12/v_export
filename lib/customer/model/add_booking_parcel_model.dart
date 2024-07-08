import 'dart:io';

class AddBookingParcelModel {
  String? deliveryTypeid;
  String? paymentmode;
  String? bookingAmount;
  String? gst;
  String? additionalTotal;
  String? totalAmount;
  bool? roundTrip;
  String? bookingDate;
  String? pickupTimeFrom;
  String? pickupTimeTo;
  String? deliveryDate;
  String? deliveryTimeFrom;
  String? deliveryTimeTo;
  String? latitude;
  String? longitude;
  String? distance;
  File? parcelPhoto;
  String? bookingType;
  List? additionalDetails;
  String? notes;
  List? parcelItem;
  List? length;
  List? width;
  List? height;
  List? qty;
  List? kg;
  List? pickupTimeFromList;
  List? pickupTimeToList;
  List? deliveryDateList;
  List? deliveryTimeFromList;
  List? deliveryTimeToList;
  List? customerName;
  List? customerMobile;
  List? blockNoUnitNo;
  List? address;
  List? postalCode;
  List? latitudeList;
  List? logitudeList;
  List? deliveryStatus;
  List? addressDeliveryTimeFromList;
  List? addressDeliveryTimeToList;

  AddBookingParcelModel({
    this.deliveryTypeid,
    this.paymentmode,
    this.bookingAmount,
    this.gst,
    this.additionalTotal,
    this.totalAmount,
    this.roundTrip,
    this.bookingDate,
    this.pickupTimeFrom,
    this.pickupTimeTo,
    this.deliveryDate,
    this.deliveryTimeFrom,
    this.deliveryTimeTo,
    this.latitude,
    this.longitude,
    this.distance,
    this.parcelPhoto,
    this.bookingType,
    this.additionalDetails,
    this.notes,
    this.parcelItem,
    this.length,
    this.width,
    this.height,
    this.qty,
    this.kg,
    this.pickupTimeFromList,
    this.pickupTimeToList,
    this.deliveryDateList,
    this.deliveryTimeFromList,
    this.deliveryTimeToList,
    this.customerName,
    this.customerMobile,
    this.blockNoUnitNo,
    this.address,
    this.postalCode,
    this.latitudeList,
    this.logitudeList,
    this.deliveryStatus,
    this.addressDeliveryTimeFromList,
    this.addressDeliveryTimeToList,
  });
}
