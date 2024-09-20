// To parse this JSON data, do
//
//     final getLatestUnratedBookingModel = getLatestUnratedBookingModelFromJson(jsonString);

import 'dart:convert';

GetLatestUnratedBookingModel getLatestUnratedBookingModelFromJson(String str) => GetLatestUnratedBookingModel.fromJson(json.decode(str));

String getLatestUnratedBookingModelToJson(GetLatestUnratedBookingModel data) => json.encode(data.toJson());

class GetLatestUnratedBookingModel {
    String status;
    String message;
    GetLatestUnratedBookingData data;

    GetLatestUnratedBookingModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory GetLatestUnratedBookingModel.fromJson(Map<String, dynamic> json) => GetLatestUnratedBookingModel(
        status: json["status"],
        message: json["message"],
        data: GetLatestUnratedBookingData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
    };
}

class GetLatestUnratedBookingData {
    int id;
    String bookingId;
    String invoiceId;
    String userId;
    String driverId;
    dynamic vehicleId;
    DateTime bookingDate;
    dynamic pickupDate;
    String deliveryDate;
    String pickupOtp;
    String deliveryOtp;
    String bookingType;
    String vehicleType;
    String deliveryTypeId;
    String paymentMode;
    String payable;
    String bookingAmount;
    String paymentDetails;
    String isRoundTrip;
    dynamic parcelPhoto;
    String gst;
    String additionalTotal;
    String driverPayable;
    String veeloCharges;
    String totalAmount;
    String notes;
    String isConfirmed;
    String isReachedLocation;
    String isPickuped;
    String bookingStatus;
    String ratingReminder;
    dynamic cancelReason;
    String unitno;
    String senderUnitnoBlockno;
    String pickupAddreess;
    String bookingTimeFromVehicle;
    String pickuptimeFrom;
    String pickuptimeTo;
    dynamic deliverytimeFrom;
    String additionalServicesId;
    dynamic deliverytimeTo;
    String latitude;
    String longitude;
    String distance;
    dynamic pickupedAt;
    dynamic acceptedAt;
    dynamic reachedAt;
    String completedAt;
    dynamic packagePictures;
    dynamic pickupPicture;
    dynamic completedPicture;
    String status;
    DateTime createdAt;
    DateTime updatedAt;

    GetLatestUnratedBookingData({
        required this.id,
        required this.bookingId,
        required this.invoiceId,
        required this.userId,
        required this.driverId,
        required this.vehicleId,
        required this.bookingDate,
        required this.pickupDate,
        required this.deliveryDate,
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
        required this.driverPayable,
        required this.veeloCharges,
        required this.totalAmount,
        required this.notes,
        required this.isConfirmed,
        required this.isReachedLocation,
        required this.isPickuped,
        required this.bookingStatus,
        required this.ratingReminder,
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
    });

    factory GetLatestUnratedBookingData.fromJson(Map<String, dynamic> json) => GetLatestUnratedBookingData(
        id: json["id"],
        bookingId: json["booking_id"],
        invoiceId: json["invoice_id"],
        userId: json["user_id"],
        driverId: json["driver_id"],
        vehicleId: json["vehicle_id"],
        bookingDate: DateTime.parse(json["booking_date"]),
        pickupDate: json["pickup_date"],
        deliveryDate: json["delivery_date"],
        pickupOtp: json["pickup_otp"],
        deliveryOtp: json["delivery_otp"],
        bookingType: json["booking_type"],
        vehicleType: json["vehicle_type"],
        deliveryTypeId: json["delivery_type_id"],
        paymentMode: json["payment_mode"],
        payable: json["payable"],
        bookingAmount: json["booking_amount"],
        paymentDetails: json["payment_details"],
        isRoundTrip: json["is_round_trip"],
        parcelPhoto: json["parcel_photo"],
        gst: json["gst"],
        additionalTotal: json["additional_total"],
        driverPayable: json["driver_payable"],
        veeloCharges: json["veelo_charges"],
        totalAmount: json["total_amount"],
        notes: json["notes"],
        isConfirmed: json["is_confirmed"],
        isReachedLocation: json["is_reached_location"],
        isPickuped: json["is_pickuped"],
        bookingStatus: json["booking_status"],
        ratingReminder: json["rating_reminder"],
        cancelReason: json["cancel_reason"],
        unitno: json["unitno"],
        senderUnitnoBlockno: json["sender_unitno_blockno"],
        pickupAddreess: json["pickup_addreess"],
        bookingTimeFromVehicle: json["booking_time_from_vehicle"],
        pickuptimeFrom: json["pickuptime_from"],
        pickuptimeTo: json["pickuptime_to"],
        deliverytimeFrom: json["deliverytime_from"],
        additionalServicesId: json["additional_services_id"],
        deliverytimeTo: json["deliverytime_to"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        distance: json["distance"],
        pickupedAt: json["pickuped_at"],
        acceptedAt: json["accepted_at"],
        reachedAt: json["reached_at"],
        completedAt: json["completed_at"],
        packagePictures: json["package_pictures"],
        pickupPicture: json["pickup_picture"],
        completedPicture: json["completed_picture"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "booking_id": bookingId,
        "invoice_id": invoiceId,
        "user_id": userId,
        "driver_id": driverId,
        "vehicle_id": vehicleId,
        "booking_date": "${bookingDate.year.toString().padLeft(4, '0')}-${bookingDate.month.toString().padLeft(2, '0')}-${bookingDate.day.toString().padLeft(2, '0')}",
        "pickup_date": pickupDate,
        "delivery_date": deliveryDate,
        "pickup_otp": pickupOtp,
        "delivery_otp": deliveryOtp,
        "booking_type": bookingType,
        "vehicle_type": vehicleType,
        "delivery_type_id": deliveryTypeId,
        "payment_mode": paymentMode,
        "payable": payable,
        "booking_amount": bookingAmount,
        "payment_details": paymentDetails,
        "is_round_trip": isRoundTrip,
        "parcel_photo": parcelPhoto,
        "gst": gst,
        "additional_total": additionalTotal,
        "driver_payable": driverPayable,
        "veelo_charges": veeloCharges,
        "total_amount": totalAmount,
        "notes": notes,
        "is_confirmed": isConfirmed,
        "is_reached_location": isReachedLocation,
        "is_pickuped": isPickuped,
        "booking_status": bookingStatus,
        "rating_reminder": ratingReminder,
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
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
