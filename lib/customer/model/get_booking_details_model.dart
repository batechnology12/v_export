// To parse this JSON data, do
//
//     final paymentShowModel = paymentShowModelFromJson(jsonString);

import 'dart:convert';

PaymentShowModel paymentShowModelFromJson(String str) =>
    PaymentShowModel.fromJson(json.decode(str));

String paymentShowModelToJson(PaymentShowModel data) =>
    json.encode(data.toJson());

class PaymentShowModel {
  bool status;
  String message;
  PaymentData data;

  PaymentShowModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory PaymentShowModel.fromJson(Map<String, dynamic> json) =>
      PaymentShowModel(
        status: json["status"],
        message: json["message"],
        data: PaymentData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class PaymentData {
  int id;
  String bookingId;
  String userId;
  String driverId;
  String vehicleId;
  DateTime bookingDate;
  String pickupDate;
  String pickupOtp;
  String deliveryOtp;
  String bookingType;
  String vehicleType;
  String deliveryTypeId;
  String paymentMode;
  String payable;
  String bookingAmount;
  PaymentDetails paymentDetails;
  String isRoundTrip;
  String parcelPhoto;
  String gst;
  String additionalTotal;
  String totalAmount;
  String notes;
  String isConfirmed;
  String isReachedLocation;
  String isPickuped;
  String bookingStatus;
  dynamic cancelReason;
  String unitno;
  String senderUnitnoBlockno;
  String pickupAddreess;
  String bookingTimeFromVehicle;
  String pickuptimeFrom;
  String pickuptimeTo;
  String deliverytimeFrom;
  String additionalServicesId;
  String deliverytimeTo;
  String latitude;
  String longitude;
  String distance;
  String pickupedAt;
  String acceptedAt;
  String reachedAt;
  String completedAt;
  String packagePictures;
  String pickupPicture;
  String completedPicture;
  String status;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<dynamic> additionalServices;

  List<PaymentBookingProduct> bookingProducts;
  List<payementookingDeliveryAddress> bookingDeliveryAddresses;

  PaymentData({
    required this.id,
    required this.bookingId,
    required this.userId,
    required this.driverId,
    required this.vehicleId,
    required this.bookingDate,
    required this.pickupDate,
    required this.pickupOtp,
    required this.deliveryOtp,
    required this.bookingType,
    required this.vehicleType,
    required this.deliveryTypeId,
    required this.paymentMode,
    required this.payable,
    required this.bookingAmount,
    required this.paymentDetails,
    required this.isRoundTrip,
    required this.parcelPhoto,
    required this.gst,
    required this.additionalTotal,
    required this.totalAmount,
    required this.notes,
    required this.isConfirmed,
    required this.isReachedLocation,
    required this.isPickuped,
    required this.bookingStatus,
    required this.cancelReason,
    required this.unitno,
    required this.senderUnitnoBlockno,
    required this.pickupAddreess,
    required this.bookingTimeFromVehicle,
    required this.pickuptimeFrom,
    required this.pickuptimeTo,
    required this.deliverytimeFrom,
    required this.additionalServicesId,
    required this.deliverytimeTo,
    required this.latitude,
    required this.longitude,
    required this.distance,
    required this.pickupedAt,
    required this.acceptedAt,
    required this.reachedAt,
    required this.completedAt,
    required this.packagePictures,
    required this.pickupPicture,
    required this.completedPicture,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.additionalServices,
    required this.bookingProducts,
    required this.bookingDeliveryAddresses,
  });

  factory PaymentData.fromJson(Map<String, dynamic> json) => PaymentData(
        id: json["id"] ?? 0,
        bookingId: json["booking_id"] ?? "",
        userId: json["user_id"] ?? "",
        driverId: json["driver_id"] ?? "",
        vehicleId: json["vehicle_id"] ?? "",
        bookingDate: DateTime.parse(json["booking_date"]),
        pickupDate: json["pickup_date"] ?? "",
        pickupOtp: json["pickup_otp"] ?? "",
        deliveryOtp: json["delivery_otp"] ?? "",
        bookingType: json["booking_type"] ?? "",
        vehicleType: json["vehicle_type"] ?? "",
        deliveryTypeId: json["delivery_type_id"] ?? "",
        paymentMode: json["payment_mode"] ?? "",
        payable: json["payable"] ?? "",
        bookingAmount: json["booking_amount"] ?? "",
        paymentDetails: PaymentDetails.fromJson(json["payment_details"]),
        isRoundTrip: json["is_round_trip"] ?? "",
        parcelPhoto: json["parcel_photo"] ?? "",
        gst: json["gst"] ?? "",
        additionalTotal: json["additional_total"] ?? "",
        totalAmount: json["total_amount"] ?? "",
        notes: json["notes"] ?? "",
        isConfirmed: json["is_confirmed"] ?? "",
        isReachedLocation: json["is_reached_location"] ?? "",
        isPickuped: json["is_pickuped"] ?? "",
        bookingStatus: json["booking_status"] ?? "",
        cancelReason: json["cancel_reason"] ?? "",
        unitno: json["unitno"] ?? "",
        senderUnitnoBlockno: json["sender_unitno_blockno"] ?? "",
        pickupAddreess: json["pickup_addreess"] ?? "",
        bookingTimeFromVehicle: json["booking_time_from_vehicle"] ?? "",
        pickuptimeFrom: json["pickuptime_from"] ?? "",
        pickuptimeTo: json["pickuptime_to"] ?? "",
        deliverytimeFrom: json["deliverytime_from"] ?? "",
        additionalServicesId: json["additional_services_id"] ?? "",
        deliverytimeTo: json["deliverytime_to"] ?? "",
        latitude: json["latitude"] ?? "",
        longitude: json["longitude"] ?? "",
        distance: json["distance"] ?? "",
        pickupedAt: json["pickuped_at"] ?? "",
        acceptedAt: json["accepted_at"] ?? "",
        reachedAt: json["reached_at"] ?? "",
        completedAt: json["completed_at"] ?? "",
        packagePictures: json["package_pictures"] ?? "",
        pickupPicture: json["pickup_picture"] ?? "",
        completedPicture: json["completed_picture"] ?? "",
        status: json["status"] ?? "",
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        additionalServices:
            List<dynamic>.from(json["additional_services"].map((x) => x)),
        bookingProducts: List<PaymentBookingProduct>.from(
            json["booking_products"]
                .map((x) => PaymentBookingProduct.fromJson(x))),
        bookingDeliveryAddresses: List<payementookingDeliveryAddress>.from(
            json["booking_delivery_addresses"]
                .map((x) => payementookingDeliveryAddress.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "booking_id": bookingId,
        "user_id": userId,
        "driver_id": driverId,
        "vehicle_id": vehicleId,
        "booking_date":
            "${bookingDate.year.toString().padLeft(4, '0')}-${bookingDate.month.toString().padLeft(2, '0')}-${bookingDate.day.toString().padLeft(2, '0')}",
        "pickup_date": pickupDate,
        "pickup_otp": pickupOtp,
        "delivery_otp": deliveryOtp,
        "booking_type": bookingType,
        "vehicle_type": vehicleType,
        "delivery_type_id": deliveryTypeId,
        "payment_mode": paymentMode,
        "payable": payable,
        "booking_amount": bookingAmount,
        "payment_details": paymentDetails.toJson(),
        "is_round_trip": isRoundTrip,
        "parcel_photo": parcelPhoto,
        "gst": gst,
        "additional_total": additionalTotal,
        "total_amount": totalAmount,
        "notes": notes,
        "is_confirmed": isConfirmed,
        "is_reached_location": isReachedLocation,
        "is_pickuped": isPickuped,
        "booking_status": bookingStatus,
        "cancel_reason": cancelReason,
        "unitno": unitno,
        "sender_unitno_blockno": senderUnitnoBlockno,
        "pickup_addreess": pickupAddreess,
        "booking_time_from_vehicle": bookingTimeFromVehicle,
        "pickuptime_from": pickuptimeFrom,
        "pickuptime_to": pickuptimeTo,
        "deliverytime_from": deliverytimeFrom,
        "additional_services_id": additionalServicesId,
        "deliverytime_to": deliverytimeTo,
        "latitude": latitude,
        "longitude": longitude,
        "distance": distance,
        "pickuped_at": pickupedAt,
        "accepted_at": acceptedAt,
        "reached_at": reachedAt,
        "completed_at": completedAt,
        "package_pictures": packagePictures,
        "pickup_picture": pickupPicture,
        "completed_picture": completedPicture,
        "status": status,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "additional_services":
            List<dynamic>.from(additionalServices.map((x) => x)),
        "booking_products":
            List<dynamic>.from(bookingProducts.map((x) => x.toJson())),
        "booking_delivery_addresses":
            List<dynamic>.from(bookingDeliveryAddresses.map((x) => x.toJson())),
      };
}

class payementookingDeliveryAddress {
  int id;
  String bookingId;
  dynamic bookingProductId;
  String customerName;
  String customerMobile;
  dynamic reciverName;
  dynamic reciverMobile;
  dynamic unitno;
  String unitnoBlockno;
  String address;
  String postalcode;
  String latitude;
  String longitude;

  List<String>? deliveryImage;
  String deliveryStatus;
  dynamic deliveryAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  payementookingDeliveryAddress({
    required this.id,
    required this.bookingId,
    required this.bookingProductId,
    required this.customerName,
    required this.customerMobile,
    required this.reciverName,
    required this.reciverMobile,
    required this.unitno,
    required this.unitnoBlockno,
    required this.address,
    required this.postalcode,
    required this.latitude,
    required this.longitude,
    required this.deliveryImage,
    required this.deliveryStatus,
    required this.deliveryAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory payementookingDeliveryAddress.fromJson(Map<String, dynamic> json) =>
      payementookingDeliveryAddress(
        id: json["id"] ?? 0,
        bookingId: json["booking_id"] ?? "",
        bookingProductId: json["booking_product_id"] ?? "",
        customerName: json["customer_name"] ?? "",
        customerMobile: json["customer_mobile"] ?? "",
        reciverName: json["reciver_name"] ?? "",
        reciverMobile: json["reciver_mobile"] ?? "",
        unitno: json["unitno"] ?? "",
        unitnoBlockno: json["unitno_blockno"] ?? "",
        address: json["address"] ?? "",
        postalcode: json["postalcode"] ?? "",
        latitude: json["latitude"] ?? "",
        longitude: json["longitude"] ?? "",
        deliveryImage: json["delivery_image"] == null
            ? []
            : List<String>.from(json["delivery_image"].map((x) => x)),
        // deliveryImage: json["delivery_image"],
        deliveryStatus: json["delivery_status"] ?? "",
        deliveryAt: json["delivery_at"] ?? "",
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "booking_id": bookingId,
        "booking_product_id": bookingProductId,
        "customer_name": customerName,
        "customer_mobile": customerMobile,
        "reciver_name": reciverName,
        "reciver_mobile": reciverMobile,
        "unitno": unitno,
        "unitno_blockno": unitnoBlockno,
        "address": address,
        "postalcode": postalcode,
        "latitude": latitude,
        "longitude": longitude,
        "delivery_image": List<dynamic>.from(deliveryImage!.map((x) => x)),
        // "delivery_image": deliveryImage,
        "delivery_status": deliveryStatus,
        "delivery_at": deliveryAt,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}

class PaymentBookingProduct {
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
  String deliveryDate;
  String deliverytimeFrom;
  String deliverytimeTo;
  String isPickuped;
  dynamic pickupedAt;
  dynamic cancelReason;
  DateTime? createdAt;
  DateTime? updatedAt;

  PaymentBookingProduct({
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
    required this.isPickuped,
    required this.pickupedAt,
    required this.cancelReason,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PaymentBookingProduct.fromJson(Map<String, dynamic> json) =>
      PaymentBookingProduct(
          id: json["id"] ?? 0 ?? "",
          bookingId: json["booking_id"] ?? "",
          bookingProductId: json["booking_product_id"] ?? "",
          parcelItems: json["parcel_items"] ?? "",
          parcelSize: json["parcel_size"] ?? "",
          productPicture: json["product_picture"] ?? "",
          length: json["length"] ?? "",
          bookingProductWith: json["with"] ?? "",
          height: json["height"] ?? "",
          qty: json["qty"] ?? "",
          kg: json["kg"] ?? "",
          pickuptimeFrom: json["pickuptime_from"] ?? "",
          pickuptimeTo: json["pickuptime_to"] ?? "",
          deliveryDate: json["delivery_date"] ?? "",
          deliverytimeFrom: json["deliverytime_from"] ?? "",
          deliverytimeTo: json["deliverytime_to"] ?? "",
          isPickuped: json["is_pickuped"] ?? "",
          pickupedAt: json["pickuped_at"] ?? "",
          cancelReason: json["cancel_reason"] ?? "",
          createdAt: json["created_at"] == null
              ? null
              : DateTime.parse(json["created_at"]),
          updatedAt: json["updated_at"] == null
              ? null
              : DateTime.parse(json["updated_at"]));

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
        "delivery_date": deliveryDate,
        "deliverytime_from": deliverytimeFrom,
        "deliverytime_to": deliverytimeTo,
        "is_pickuped": isPickuped,
        "pickuped_at": pickupedAt,
        "cancel_reason": cancelReason,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}

class PaymentDetails {
  String deliveryfees;
  String roundtripCost;
  String additionalStopCount;
  String driverHelpCost;
  String helperCost;
  String weekend;
  List<PaymentDetailsAdditionalService> additionalServices;
  String total;
  String staircasePerFloor;
  String discount;

  PaymentDetails({
    required this.deliveryfees,
    required this.roundtripCost,
    required this.additionalStopCount,
    required this.driverHelpCost,
    required this.helperCost,
    required this.weekend,
    required this.additionalServices,
    required this.total,
    required this.staircasePerFloor,
    required this.discount,
  });

  factory PaymentDetails.fromJson(Map<String, dynamic> json) => PaymentDetails(
        deliveryfees: json["deliveryfees"] ?? "",
        roundtripCost: json["roundtripCost"] ?? "",
        additionalStopCount: json["additionalStopCount"] ?? "",
        driverHelpCost: json["driverHelpCost"] ?? "",
        helperCost: json["helperCost"] ?? "",
        weekend: json["weekend"] ?? "",
        additionalServices: List<PaymentDetailsAdditionalService>.from(
            json["additional_services"]
                .map((x) => PaymentDetailsAdditionalService.fromJson(x))),
        total: json["total"] ?? "",
        staircasePerFloor: json["staircase (per floor)"] ?? "",
        discount: json["discount"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "deliveryfees": deliveryfees,
        "roundtripCost": roundtripCost,
        "additionalStopCount": additionalStopCount,
        "driverHelpCost": driverHelpCost,
        "helperCost": helperCost,
        "weekend": weekend,
        "additional_services":
            List<dynamic>.from(additionalServices.map((x) => x.toJson())),
        "total": total,
        "staircase (per floor)": staircasePerFloor,
        "discount": discount,
      };
}

class PaymentDetailsAdditionalService {
  String name;
  String value;

  PaymentDetailsAdditionalService({
    required this.name,
    required this.value,
  });

  factory PaymentDetailsAdditionalService.fromJson(Map<String, dynamic> json) =>
      PaymentDetailsAdditionalService(
        name: json["name"] ?? "",
        value: json["value"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "value": value,
      };
}
