// To parse this JSON data, do
//
//     final ongoingOrdersModel = ongoingOrdersModelFromJson(jsonString);

import 'dart:convert';

OngoingOrdersModel ongoingOrdersModelFromJson(String str) =>
    OngoingOrdersModel.fromJson(json.decode(str));

String ongoingOrdersModelToJson(OngoingOrdersModel data) =>
    json.encode(data.toJson());

class OngoingOrdersModel {
  bool status;
  String message;
  List<OngoingOrderData> data;

  OngoingOrdersModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory OngoingOrdersModel.fromJson(Map<String, dynamic> json) =>
      OngoingOrdersModel(
        status: json["status"],
        message: json["message"],
        data: List<OngoingOrderData>.from(
            json["data"].map((x) => OngoingOrderData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class OngoingOrderData {
  int id;
  String bookingId;
  String userId;
  String driverId;
  String vehicleId;
  DateTime bookingDate;
  String deliveryTypeId;
  String paymentMode;
  String bookingAmount;
  String gst;
  String additionalTotal;
  String totalAmount;
  dynamic additionalServicesId;
  String notes;
  String isConfirmed;
  String bookingStatus;
  DateTime createdAt;
  DateTime updatedAt;
  List<BookingProduct> bookingProducts;
  dynamic driver;
  List<VehicleDetail> vehicleDetails;
  dynamic additionalService;
  List<FromAddress> fromAddress;
  List<BookingDeliveryAddress> bookingDeliveryAddresses;
  DeliveryType deliveryType;

  OngoingOrderData({
    required this.id,
    required this.bookingId,
    required this.userId,
    required this.driverId,
    required this.vehicleId,
    required this.bookingDate,
    required this.deliveryTypeId,
    required this.paymentMode,
    required this.bookingAmount,
    required this.gst,
    required this.additionalTotal,
    required this.totalAmount,
    required this.additionalServicesId,
    required this.notes,
    required this.isConfirmed,
    required this.bookingStatus,
    required this.createdAt,
    required this.updatedAt,
    required this.bookingProducts,
    required this.driver,
    required this.vehicleDetails,
    required this.additionalService,
    required this.fromAddress,
    required this.bookingDeliveryAddresses,
    required this.deliveryType,
  });

  factory OngoingOrderData.fromJson(Map<String, dynamic> json) =>
      OngoingOrderData(
        id: json["id"],
        bookingId: json["booking_id"] ?? "",
        userId: json["user_id"] ?? "",
        driverId: json["driver_id"] ?? "",
        vehicleId: json["vehicle_id"] ?? "",
        bookingDate: DateTime.parse(json["booking_date"]),
        deliveryTypeId: json["delivery_type_id"] ?? "",
        paymentMode: json["payment_mode"] ?? "",
        bookingAmount: json["booking_amount"] ?? "",
        gst: json["gst"] ?? "",
        additionalTotal: json["additional_total"] ?? "",
        totalAmount: json["total_amount"] ?? "",
        additionalServicesId: json["additional_services_id"] ?? "",
        notes: json["notes"] ?? "",
        isConfirmed: json["is_confirmed"] ?? "",
        bookingStatus: json["booking_status"] ?? "",
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        bookingProducts: List<BookingProduct>.from(
            json["booking_products"].map((x) => BookingProduct.fromJson(x))),
        driver: json["driver"],
        vehicleDetails: List<VehicleDetail>.from(
            json["vehicle_details"].map((x) => VehicleDetail.fromJson(x))),
        additionalService: json["additional_service"],
        fromAddress: List<FromAddress>.from(
            json["from_address"].map((x) => FromAddress.fromJson(x))),
        bookingDeliveryAddresses: List<BookingDeliveryAddress>.from(
            json["booking_delivery_addresses"]
                .map((x) => BookingDeliveryAddress.fromJson(x))),
        deliveryType: DeliveryType.fromJson(json["delivery_type"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "booking_id": bookingId,
        "user_id": userId,
        "driver_id": driverId,
        "vehicle_id": vehicleId,
        "booking_date":
            "${bookingDate.year.toString().padLeft(4, '0')}-${bookingDate.month.toString().padLeft(2, '0')}-${bookingDate.day.toString().padLeft(2, '0')}",
        "delivery_type_id": deliveryTypeId,
        "payment_mode": paymentMode,
        "booking_amount": bookingAmount,
        "gst": gst,
        "additional_total": additionalTotal,
        "total_amount": totalAmount,
        "additional_services_id": additionalServicesId,
        "notes": notes,
        "is_confirmed": isConfirmed,
        "booking_status": bookingStatus,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "booking_products":
            List<dynamic>.from(bookingProducts.map((x) => x.toJson())),
        "driver": driver,
        "vehicle_details":
            List<dynamic>.from(vehicleDetails.map((x) => x.toJson())),
        "additional_service": additionalService,
        "from_address": List<dynamic>.from(fromAddress.map((x) => x.toJson())),
        "booking_delivery_addresses":
            List<dynamic>.from(bookingDeliveryAddresses.map((x) => x.toJson())),
        "delivery_type": deliveryType.toJson(),
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
        bookingId: json["booking_id"] ?? "",
        customerName: json["customer_name"] ?? "",
        customerMobile: json["customer_mobile"] ?? "",
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
  String parcelSize;
  String productPicture;
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
    required this.parcelSize,
    required this.productPicture,
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
        bookingId: json["booking_id"] ?? "",
        parcelSize: json["parcel_size"] ?? "",
        productPicture: json["product_picture"] ?? "",
        qty: json["qty"] ?? "",
        kg: json["kg"] ?? "",
        pickuptimeFrom: json["pickuptime_from"] ?? "",
        pickuptimeTo: json["pickuptime_to"] ?? "",
        deliveryDate: DateTime.parse(json["delivery_date"]),
        deliverytimeFrom: json["deliverytime_from"] ?? "",
        deliverytimeTo: json["deliverytime_to"] ?? "",
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "booking_id": bookingId,
        "parcel_size": parcelSize,
        "product_picture": productPicture,
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

class DeliveryType {
  int id;
  String name;
  String description;
  String price05Km;
  String price510Km;
  String price1015Km;
  String price1520Km;
  String price2025Km;
  String priceAbove25Km;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  DeliveryType({
    required this.id,
    required this.name,
    required this.description,
    required this.price05Km,
    required this.price510Km,
    required this.price1015Km,
    required this.price1520Km,
    required this.price2025Km,
    required this.priceAbove25Km,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DeliveryType.fromJson(Map<String, dynamic> json) => DeliveryType(
        id: json["id"],
        name: json["name"] ?? "",
        description: json["description"] ?? "",
        price05Km: json["price_0_5km"] ?? "",
        price510Km: json["price_5_10km"] ?? "",
        price1015Km: json["price_10_15km"] ?? "",
        price1520Km: json["price_15_20km"] ?? "",
        price2025Km: json["price_20_25km"] ?? "",
        priceAbove25Km: json["price_above_25km"] ?? "",
        status: json["status"] ?? "",
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "price_0_5km": price05Km,
        "price_5_10km": price510Km,
        "price_10_15km": price1015Km,
        "price_15_20km": price1520Km,
        "price_20_25km": price2025Km,
        "price_above_25km": priceAbove25Km,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class FromAddress {
  int id;
  String userId;
  String street;
  String city;
  String state;
  String zip;
  String country;
  String type;
  String unitNo;
  String blockNo;
  String address;
  String landmark;
  String pincode;
  String contactPerson;
  String contactNumber;
  String latitude;
  String longitude;
  DateTime createdAt;
  DateTime updatedAt;

  FromAddress({
    required this.id,
    required this.userId,
    required this.street,
    required this.city,
    required this.state,
    required this.zip,
    required this.country,
    required this.type,
    required this.unitNo,
    required this.blockNo,
    required this.address,
    required this.landmark,
    required this.pincode,
    required this.contactPerson,
    required this.contactNumber,
    required this.latitude,
    required this.longitude,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FromAddress.fromJson(Map<String, dynamic> json) => FromAddress(
        id: json["id"],
        userId: json["user_id"] ?? "",
        street: json["street"] ?? "",
        city: json["city"] ?? "",
        state: json["state"] ?? "",
        zip: json["zip"] ?? "",
        country: json["country"] ?? "",
        type: json["type"] ?? "",
        unitNo: json["unit_no"] ?? "",
        blockNo: json["block_no"] ?? "",
        address: json["address"] ?? "",
        landmark: json["landmark"] ?? "",
        pincode: json["pincode"] ?? "",
        contactPerson: json["contact_person"] ?? "",
        contactNumber: json["contact_number"] ?? "",
        latitude: json["latitude"] ?? "",
        longitude: json["longitude"] ?? "",
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "street": street,
        "city": city,
        "state": state,
        "zip": zip,
        "country": country,
        "type": type,
        "unit_no": unitNo,
        "block_no": blockNo,
        "address": address,
        "landmark": landmark,
        "pincode": pincode,
        "contact_person": contactPerson,
        "contact_number": contactNumber,
        "latitude": latitude,
        "longitude": longitude,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class VehicleDetail {
  int id;
  String userId;
  String vehicleType;
  String vehicleModel;
  String vehicleNumber;
  String drivingLicenseFront;
  String drivingLicenseBack;
  String vehicleFront;
  String vehicleBack;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  VehicleDetail({
    required this.id,
    required this.userId,
    required this.vehicleType,
    required this.vehicleModel,
    required this.vehicleNumber,
    required this.drivingLicenseFront,
    required this.drivingLicenseBack,
    required this.vehicleFront,
    required this.vehicleBack,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory VehicleDetail.fromJson(Map<String, dynamic> json) => VehicleDetail(
        id: json["id"],
        userId: json["user_id"] ?? "",
        vehicleType: json["vehicle_type"] ?? "",
        vehicleModel: json["vehicle_model"] ?? "",
        vehicleNumber: json["vehicle_number"] ?? "",
        drivingLicenseFront: json["driving_license_front"] ?? "",
        drivingLicenseBack: json["driving_license_back"] ?? "",
        vehicleFront: json["vehicle_front"] ?? "",
        vehicleBack: json["vehicle_back"] ?? "",
        status: json["status"] ?? "",
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "vehicle_type": vehicleType,
        "vehicle_model": vehicleModel,
        "vehicle_number": vehicleNumber,
        "driving_license_front": drivingLicenseFront,
        "driving_license_back": drivingLicenseBack,
        "vehicle_front": vehicleFront,
        "vehicle_back": vehicleBack,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
