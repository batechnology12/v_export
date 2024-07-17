// To parse this JSON data, do
//
//     final getBookingdetailsModeldata = getBookingdetailsModeldataFromJson(jsonString);

import 'dart:convert';

GetBookingdetailsModeldata getBookingdetailsModeldataFromJson(String str) =>
    GetBookingdetailsModeldata.fromJson(json.decode(str));

String getBookingdetailsModeldataToJson(GetBookingdetailsModeldata data) =>
    json.encode(data.toJson());

class GetBookingdetailsModeldata {
  bool status;
  String message;
  BookingData data;

  GetBookingdetailsModeldata({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetBookingdetailsModeldata.fromJson(Map<String, dynamic> json) =>
      GetBookingdetailsModeldata(
        status: json["status"],
        message: json["message"],
        data: BookingData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class BookingData {
  String bookingId;
  int userId;
  dynamic vehicleId;
  DateTime bookingDate;
  String deliveryTypeId;
  String paymentMode;
  String bookingAmount;
  String gst;
  dynamic pickupAddreess;
  String latitude;
  String longitude;
  String distance;
  String additionalTotal;
  String totalAmount;
  String isRoundTrip;
  String notes;
  int isConfirmed;
  int bookingStatus;
  String bookingType;
  DateTime updatedAt;
  DateTime createdAt;
  int id;
  String additionalServicesId;
  List<BookingProduct> bookingProducts;
  List<BookingDeliveryAddress> bookingDeliveryAddresses;
  List<AdditionalService> additionalServices;
  String deliveryTypeName;
  dynamic parcelPhoto;

  BookingData({
    required this.bookingId,
    required this.userId,
    required this.vehicleId,
    required this.bookingDate,
    required this.deliveryTypeId,
    required this.paymentMode,
    required this.bookingAmount,
    required this.gst,
    required this.pickupAddreess,
    required this.latitude,
    required this.longitude,
    required this.distance,
    required this.additionalTotal,
    required this.totalAmount,
    required this.isRoundTrip,
    required this.notes,
    required this.isConfirmed,
    required this.bookingStatus,
    required this.bookingType,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
    required this.additionalServicesId,
    required this.bookingProducts,
    required this.bookingDeliveryAddresses,
    required this.additionalServices,
    required this.deliveryTypeName,
    required this.parcelPhoto,
  });

  factory BookingData.fromJson(Map<String, dynamic> json) => BookingData(
        bookingId: json["booking_id"],
        userId: json["user_id"],
        vehicleId: json["vehicle_id"],
        bookingDate: DateTime.parse(json["booking_date"]),
        deliveryTypeId: json["delivery_type_id"],
        paymentMode: json["payment_mode"],
        bookingAmount: json["booking_amount"],
        gst: json["gst"],
        pickupAddreess: json["pickup_addreess"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        distance: json["distance"],
        additionalTotal: json["additional_total"],
        totalAmount: json["total_amount"],
        isRoundTrip: json["is_round_trip"],
        notes: json["notes"],
        isConfirmed: json["is_confirmed"],
        bookingStatus: json["booking_status"],
        bookingType: json["booking_type"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
        additionalServicesId: json["additional_services_id"],
        bookingProducts: List<BookingProduct>.from(
            json["booking_products"].map((x) => BookingProduct.fromJson(x))),
        bookingDeliveryAddresses: List<BookingDeliveryAddress>.from(
            json["booking_delivery_addresses"]
                .map((x) => BookingDeliveryAddress.fromJson(x))),
        additionalServices: List<AdditionalService>.from(
            json["additional_services"]
                .map((x) => AdditionalService.fromJson(x))),
        deliveryTypeName: json["delivery_type_name"],
        parcelPhoto: json["parcel_photo"],
      );

  Map<String, dynamic> toJson() => {
        "booking_id": bookingId,
        "user_id": userId,
        "vehicle_id": vehicleId,
        "booking_date": bookingDate.toIso8601String(),
        "delivery_type_id": deliveryTypeId,
        "payment_mode": paymentMode,
        "booking_amount": bookingAmount,
        "gst": gst,
        "pickup_addreess": pickupAddreess,
        "latitude": latitude,
        "longitude": longitude,
        "distance": distance,
        "additional_total": additionalTotal,
        "total_amount": totalAmount,
        "is_round_trip": isRoundTrip,
        "notes": notes,
        "is_confirmed": isConfirmed,
        "booking_status": bookingStatus,
        "booking_type": bookingType,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
        "additional_services_id": additionalServicesId,
        "booking_products":
            List<dynamic>.from(bookingProducts.map((x) => x.toJson())),
        "booking_delivery_addresses":
            List<dynamic>.from(bookingDeliveryAddresses.map((x) => x.toJson())),
        "additional_services":
            List<dynamic>.from(additionalServices.map((x) => x.toJson())),
        "delivery_type_name": deliveryTypeName,
        "parcel_photo": parcelPhoto,
      };
}

class AdditionalService {
  int id;
  String name;
  String description;
  String type;
  String amount;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  AdditionalService({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.amount,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AdditionalService.fromJson(Map<String, dynamic> json) =>
      AdditionalService(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        type: json["type"],
        amount: json["amount"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "type": type,
        "amount": amount,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class BookingDeliveryAddress {
  int id;
  String bookingId;
  String customerName;
  String customerMobile;
  String unitnoBlockno;
  String address;
  String postalcode;
  String latitude;
  String longitude;
  String deliveryStatus;
  DateTime createdAt;
  DateTime updatedAt;

  BookingDeliveryAddress({
    required this.id,
    required this.bookingId,
    required this.customerName,
    required this.customerMobile,
    required this.unitnoBlockno,
    required this.address,
    required this.postalcode,
    required this.latitude,
    required this.longitude,
    required this.deliveryStatus,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BookingDeliveryAddress.fromJson(Map<String, dynamic> json) =>
      BookingDeliveryAddress(
        id: json["id"],
        bookingId: json["booking_id"],
        customerName: json["customer_name"],
        customerMobile: json["customer_mobile"],
        unitnoBlockno: json["unitno_blockno"],
        address: json["address"],
        postalcode: json["postalcode"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        deliveryStatus: json["delivery_status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "booking_id": bookingId,
        "customer_name": customerName,
        "customer_mobile": customerMobile,
        "unitno_blockno": unitnoBlockno,
        "address": address,
        "postalcode": postalcode,
        "latitude": latitude,
        "longitude": longitude,
        "delivery_status": deliveryStatus,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class BookingProduct {
  int id;
  String bookingId;
  String bookingProductId;
  String parcelItems;
  String parcelSize;
  dynamic productPicture;
  String length;
  String bookingProductWith;
  String height;
  String qty;
  String kg;
  String pickuptimeFrom;
  String pickuptimeTo;
  DateTime deliveryDate;
  String deliverytimeFrom;
  String deliverytimeTo;
  DateTime createdAt;
  DateTime updatedAt;

  BookingProduct({
    required this.id,
    required this.bookingId,
    required this.bookingProductId,
    required this.parcelItems,
    required this.parcelSize,
    required this.productPicture,
    required this.length,
    required this.bookingProductWith,
    required this.height,
    required this.qty,
    required this.kg,
    required this.pickuptimeFrom,
    required this.pickuptimeTo,
    required this.deliveryDate,
    required this.deliverytimeFrom,
    required this.deliverytimeTo,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BookingProduct.fromJson(Map<String, dynamic> json) => BookingProduct(
        id: json["id"],
        bookingId: json["booking_id"],
        bookingProductId: json["booking_product_id"],
        parcelItems: json["parcel_items"],
        parcelSize: json["parcel_size"],
        productPicture: json["product_picture"],
        length: json["length"],
        bookingProductWith: json["with"],
        height: json["height"],
        qty: json["qty"],
        kg: json["kg"],
        pickuptimeFrom: json["pickuptime_from"],
        pickuptimeTo: json["pickuptime_to"],
        deliveryDate: DateTime.parse(json["delivery_date"]),
        deliverytimeFrom: json["deliverytime_from"],
        deliverytimeTo: json["deliverytime_to"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "booking_id": bookingId,
        "booking_product_id": bookingProductId,
        "parcel_items": parcelItems,
        "parcel_size": parcelSize,
        "product_picture": productPicture,
        "length": length,
        "with": bookingProductWith,
        "height": height,
        "qty": qty,
        "kg": kg,
        "pickuptime_from": pickuptimeFrom,
        "pickuptime_to": pickuptimeTo,
        "delivery_date":
            "${deliveryDate.year.toString().padLeft(4, '0')}-${deliveryDate.month.toString().padLeft(2, '0')}-${deliveryDate.day.toString().padLeft(2, '0')}",
        "deliverytime_from": deliverytimeFrom,
        "deliverytime_to": deliverytimeTo,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
