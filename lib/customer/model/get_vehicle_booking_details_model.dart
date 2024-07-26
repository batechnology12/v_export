// To parse this JSON data, do
//
//     final getVehicleBookingDetailsModel = getVehicleBookingDetailsModelFromJson(jsonString);

import 'dart:convert';

GetVehicleBookingDetailsModel getVehicleBookingDetailsModelFromJson(
        String str) =>
    GetVehicleBookingDetailsModel.fromJson(json.decode(str));

String getVehicleBookingDetailsModelToJson(
        GetVehicleBookingDetailsModel data) =>
    json.encode(data.toJson());

class GetVehicleBookingDetailsModel {
  bool status;
  String message;
  GetVehicleBookingDetailsData data;

  GetVehicleBookingDetailsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetVehicleBookingDetailsModel.fromJson(Map<String, dynamic> json) =>
      GetVehicleBookingDetailsModel(
        status: json["status"],
        message: json["message"],
        data: GetVehicleBookingDetailsData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class GetVehicleBookingDetailsData {
  String bookingId;
  int userId;
  dynamic vehicleId;
  DateTime bookingDate;
  String deliveryTypeId;
  String paymentMode;
  String bookingAmount;
  String gst;
  String senderUnitnoBlockno;
  dynamic pickupAddreess;
  String latitude;
  String longitude;
  String distance;
  String bookingTimeFromVehicle;
  String additionalTotal;
  String totalAmount;
  String isRoundTrip;
  String notes;
  int isConfirmed;
  int bookingStatus;
  String bookingType;
  String vehicleType;
  DateTime updatedAt;
  DateTime createdAt;
  int id;
  String additionalServicesId;
  List<dynamic> bookingProducts;
  List<BookingDeliveryAddress> bookingDeliveryAddresses;
  List<AdditionalService> additionalServices;
  String deliveryTypeName;
  dynamic parcelPhoto;

  GetVehicleBookingDetailsData({
    required this.bookingId,
    required this.userId,
    required this.vehicleId,
    required this.bookingDate,
    required this.deliveryTypeId,
    required this.paymentMode,
    required this.bookingAmount,
    required this.gst,
    required this.senderUnitnoBlockno,
    required this.pickupAddreess,
    required this.latitude,
    required this.longitude,
    required this.distance,
    required this.bookingTimeFromVehicle,
    required this.additionalTotal,
    required this.totalAmount,
    required this.isRoundTrip,
    required this.notes,
    required this.isConfirmed,
    required this.bookingStatus,
    required this.bookingType,
    required this.vehicleType,
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

  factory GetVehicleBookingDetailsData.fromJson(Map<String, dynamic> json) =>
      GetVehicleBookingDetailsData(
        bookingId: json["booking_id"] ?? "",
        userId: json["user_id"] ?? 0,
        vehicleId: json["vehicle_id"] ?? "",
        bookingDate: DateTime.parse(json["booking_date"]),
        deliveryTypeId: json["delivery_type_id"] ?? "",
        paymentMode: json["payment_mode"] ?? "",
        bookingAmount: json["booking_amount"] ?? "",
        gst: json["gst"] ?? "",
        senderUnitnoBlockno: json["sender_unitno_blockno"] ?? "",
        pickupAddreess: json["pickup_addreess"] ?? "",
        latitude: json["latitude"] ?? "",
        longitude: json["longitude"] ?? "",
        distance: json["distance"] ?? "",
        bookingTimeFromVehicle: json["booking_time_from_vehicle"] ?? "",
        additionalTotal: json["additional_total"] ?? "",
        totalAmount: json["total_amount"] ?? "",
        isRoundTrip: json["is_round_trip"] ?? "",
        notes: json["notes"] ?? "",
        isConfirmed: json["is_confirmed"] ?? 0,
        bookingStatus: json["booking_status"] ?? 0,
        bookingType: json["booking_type"] ?? "",
        vehicleType: json["vehicle_type"] ?? "",
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"] ?? 0,
        additionalServicesId: json["additional_services_id"] ?? "",
        bookingProducts:
            List<dynamic>.from(json["booking_products"].map((x) => x)),
        bookingDeliveryAddresses: List<BookingDeliveryAddress>.from(
            json["booking_delivery_addresses"]
                .map((x) => BookingDeliveryAddress.fromJson(x))),
        additionalServices: List<AdditionalService>.from(
            json["additional_services"]
                .map((x) => AdditionalService.fromJson(x))),
        deliveryTypeName: json["delivery_type_name"] ?? "",
        parcelPhoto: json["parcel_photo"] ?? "",
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
        "sender_unitno_blockno": senderUnitnoBlockno,
        "pickup_addreess": pickupAddreess,
        "latitude": latitude,
        "longitude": longitude,
        "distance": distance,
        "booking_time_from_vehicle": bookingTimeFromVehicle,
        "additional_total": additionalTotal,
        "total_amount": totalAmount,
        "is_round_trip": isRoundTrip,
        "notes": notes,
        "is_confirmed": isConfirmed,
        "booking_status": bookingStatus,
        "booking_type": bookingType,
        "vehicle_type": vehicleType,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
        "additional_services_id": additionalServicesId,
        "booking_products": List<dynamic>.from(bookingProducts.map((x) => x)),
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
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
        description: json["description"] ?? "",
        type: json["type"] ?? "",
        amount: json["amount"] ?? "",
        status: json["status"] ?? "",
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
  String reciverName;
  String reciverMobile;
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
    required this.reciverName,
    required this.reciverMobile,
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
        id: json["id"] ?? 0,
        bookingId: json["booking_id"] ?? "",
        customerName: json["customer_name"] ?? "",
        customerMobile: json["customer_mobile"] ?? "",
        reciverName: json["reciver_name"] ?? "",
        reciverMobile: json["reciver_mobile"] ?? "",
        unitnoBlockno: json["unitno_blockno"] ?? "",
        address: json["address"] ?? "",
        postalcode: json["postalcode"] ?? "",
        latitude: json["latitude"] ?? "",
        longitude: json["longitude"] ?? "",
        deliveryStatus: json["delivery_status"] ?? "",
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "booking_id": bookingId,
        "customer_name": customerName,
        "customer_mobile": customerMobile,
        "reciver_name": reciverName,
        "reciver_mobile": reciverMobile,
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
