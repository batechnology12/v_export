

// To parse this JSON data, do
//
//     final getCompletedOrdersModel = getCompletedOrdersModelFromJson(jsonString);

import 'dart:convert';

GetCompletedOrdersModel getCompletedOrdersModelFromJson(String str) =>
    GetCompletedOrdersModel.fromJson(json.decode(str));

String getCompletedOrdersModelToJson(GetCompletedOrdersModel data) =>
    json.encode(data.toJson());

class GetCompletedOrdersModel {
  bool status;
  String message;
  Data data;

  GetCompletedOrdersModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetCompletedOrdersModel.fromJson(Map<String, dynamic> json) =>
      GetCompletedOrdersModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  List<GetCompletedOrdersModelData> orders;

  Data({
    required this.orders,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        orders: List<GetCompletedOrdersModelData>.from(
            json["orders"].map((x) => GetCompletedOrdersModelData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "orders": List<dynamic>.from(orders.map((x) => x.toJson())),
      };
}

class GetCompletedOrdersModelData {
  int id;
  String bookingId;
  String userId;
  String driverId;
  dynamic vehicleId;
  DateTime bookingDate;
  String pickupOtp;
  String deliveryOtp;
  String bookingType;
  String vehicleType;
  String deliveryTypeId;
  String paymentMode;
  dynamic payable;
  String bookingAmount;
  String paymentDetails;
  String isRoundTrip;
  dynamic parcelPhoto;
  String gst;
  String additionalTotal;
  String totalAmount;
  String notes;
  String isConfirmed;
  String isPickuped;
  String bookingStatus;
  String senderUnitnoBlockno;
  String pickupAddreess;
  dynamic bookingTimeFromVehicle;
  String pickuptimeFrom;
  String pickuptimeTo;
  dynamic deliverytimeFrom;
  dynamic additionalServicesId;
  dynamic deliverytimeTo;
  String latitude;
  String longitude;
  String distance;
  dynamic pickupedAt;
  DateTime acceptedAt;
  dynamic completedAt;
  dynamic packagePictures;
  dynamic pickupPicture;
  dynamic completedPicture;
  DateTime createdAt;
  DateTime updatedAt;
  List<BookingProduct> bookingProducts;
  Driver driver;
  List<dynamic> vehicleDetails;
  dynamic additionalService;
  List<dynamic> fromAddress;
  List<BookingDeliveryAddress> bookingDeliveryAddresses;
  DeliveryType deliveryType;

  GetCompletedOrdersModelData({
    required this.id,
    required this.bookingId,
    required this.userId,
    required this.driverId,
    required this.vehicleId,
    required this.bookingDate,
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
    required this.isPickuped,
    required this.bookingStatus,
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
    required this.completedAt,
    required this.packagePictures,
    required this.pickupPicture,
    required this.completedPicture,
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

  factory GetCompletedOrdersModelData.fromJson(Map<String, dynamic> json) =>
      GetCompletedOrdersModelData(
        id: json["id"] ?? 0,
        bookingId: json["booking_id"] ?? "",
        userId: json["user_id"] ?? "",
        driverId: json["driver_id"] ?? "",
        vehicleId: json["vehicle_id"] ?? "",
        bookingDate: DateTime.parse(json["booking_date"]),
        pickupOtp: json["pickup_otp"] ?? "",
        deliveryOtp: json["delivery_otp"] ?? "",
        bookingType: json["booking_type"] ?? "",
        vehicleType: json["vehicle_type"] ?? "",
        deliveryTypeId: json["delivery_type_id"] ?? "",
        paymentMode: json["payment_mode"] ?? "",
        payable: json["payable"] ?? "",
        bookingAmount: json["booking_amount"] ?? "",
        paymentDetails: json["payment_details"] ?? "",
        isRoundTrip: json["is_round_trip"] ?? "",
        parcelPhoto: json["parcel_photo"] ?? "",
        gst: json["gst"] ?? "",
        additionalTotal: json["additional_total"] ?? "",
        totalAmount: json["total_amount"] ?? "",
        notes: json["notes"] ?? "",
        isConfirmed: json["is_confirmed"] ?? "",
        isPickuped: json["is_pickuped"] ?? "",
        bookingStatus: json["booking_status"] ?? "",
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
        acceptedAt: DateTime.parse(json["accepted_at"]),
        completedAt: json["completed_at"] ?? "",
        packagePictures: json["package_pictures"] ?? "",
        pickupPicture: json["pickup_picture"] ?? "",
        completedPicture: json["completed_picture"] ?? "",
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        bookingProducts: List<BookingProduct>.from(
            json["booking_products"].map((x) => BookingProduct.fromJson(x))),
        driver: Driver.fromJson(json["driver"]),
        vehicleDetails:
            List<dynamic>.from(json["vehicle_details"].map((x) => x)),
        additionalService: json["additional_service"] ?? "",
        fromAddress: List<dynamic>.from(json["from_address"].map((x) => x)),
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
        "total_amount": totalAmount,
        "notes": notes,
        "is_confirmed": isConfirmed,
        "is_pickuped": isPickuped,
        "booking_status": bookingStatus,
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
        "accepted_at": acceptedAt.toIso8601String(),
        "completed_at": completedAt,
        "package_pictures": packagePictures,
        "pickup_picture": pickupPicture,
        "completed_picture": completedPicture,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "booking_products":
            List<dynamic>.from(bookingProducts.map((x) => x.toJson())),
        "driver": driver.toJson(),
        "vehicle_details": List<dynamic>.from(vehicleDetails.map((x) => x)),
        "additional_service": additionalService,
        "from_address": List<dynamic>.from(fromAddress.map((x) => x)),
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
        id: json["id"],
        bookingId: json["booking_id"],
        customerName: json["customer_name"],
        customerMobile: json["customer_mobile"],
        reciverName: json["reciver_name"],
        reciverMobile: json["reciver_mobile"],
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
  String deliveryDate;
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
        deliveryDate: json["delivery_date"],
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
        "delivery_date": deliveryDate,
        "deliverytime_from": deliverytimeFrom,
        "deliverytime_to": deliverytimeTo,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class DeliveryType {
  int id;
  String name;
  String basePerkm;
  String description;
  String price05Kg;
  String price510Kg;
  String price1015Kg;
  String price1520Kg;
  String price2025Kg;
  String priceAbove25Kg;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  DeliveryType({
    required this.id,
    required this.name,
    required this.basePerkm,
    required this.description,
    required this.price05Kg,
    required this.price510Kg,
    required this.price1015Kg,
    required this.price1520Kg,
    required this.price2025Kg,
    required this.priceAbove25Kg,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DeliveryType.fromJson(Map<String, dynamic> json) => DeliveryType(
        id: json["id"],
        name: json["name"],
        basePerkm: json["base_perkm"],
        description: json["description"],
        price05Kg: json["price_0_5kg"],
        price510Kg: json["price_5_10kg"],
        price1015Kg: json["price_10_15kg"],
        price1520Kg: json["price_15_20kg"],
        price2025Kg: json["price_20_25kg"],
        priceAbove25Kg: json["price_above_25kg"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "base_perkm": basePerkm,
        "description": description,
        "price_0_5kg": price05Kg,
        "price_5_10kg": price510Kg,
        "price_10_15kg": price1015Kg,
        "price_15_20kg": price1520Kg,
        "price_20_25kg": price2025Kg,
        "price_above_25kg": priceAbove25Kg,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Driver {
  int id;
  String firstName;
  dynamic lastName;
  String email;
  dynamic companyId;
  String phone;
  String latitude;
  String longitude;
  dynamic contactPersonName;
  dynamic industryNoOfDeliveryInMonth;
  dynamic otp;
  dynamic uenNumber;
  dynamic aecraFile;
  String nricPicture;
  String bankName;
  String accountNumber;
  String ifsCode;
  String bankProof;
  String emergencyContactName;
  String emergencyContactNumber;
  String relationship;
  String referralCode;
  dynamic referredBy;
  dynamic securityToken;
  dynamic cssNo;
  dynamic branch;
  dynamic ownerId;
  dynamic ownerType;
  bool isEnable;
  bool isAdmin;
  String isVerifyCode;
  String isProfilePicture;
  String isVehicleDetails;
  String isNricPicture;
  String isAccountDetails;
  String isEmrgencyDetails;
  dynamic image;
  dynamic facebook;
  dynamic linkedin;
  dynamic skype;
  dynamic staffMember;
  dynamic sendWelcomeEmail;
  dynamic defaultLanguage;
  dynamic emailVerifiedAt;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic stripeId;
  dynamic pmType;
  dynamic pmLastFour;
  dynamic trialEndsAt;
  dynamic apiToken;
  String statusOnOff;
  String isKycVerify;
  String fullName;
  String imageUrl;
  List<Media> media;

  Driver({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.companyId,
    required this.phone,
    required this.latitude,
    required this.longitude,
    required this.contactPersonName,
    required this.industryNoOfDeliveryInMonth,
    required this.otp,
    required this.uenNumber,
    required this.aecraFile,
    required this.nricPicture,
    required this.bankName,
    required this.accountNumber,
    required this.ifsCode,
    required this.bankProof,
    required this.emergencyContactName,
    required this.emergencyContactNumber,
    required this.relationship,
    required this.referralCode,
    required this.referredBy,
    required this.securityToken,
    required this.cssNo,
    required this.branch,
    required this.ownerId,
    required this.ownerType,
    required this.isEnable,
    required this.isAdmin,
    required this.isVerifyCode,
    required this.isProfilePicture,
    required this.isVehicleDetails,
    required this.isNricPicture,
    required this.isAccountDetails,
    required this.isEmrgencyDetails,
    required this.image,
    required this.facebook,
    required this.linkedin,
    required this.skype,
    required this.staffMember,
    required this.sendWelcomeEmail,
    required this.defaultLanguage,
    required this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.stripeId,
    required this.pmType,
    required this.pmLastFour,
    required this.trialEndsAt,
    required this.apiToken,
    required this.statusOnOff,
    required this.isKycVerify,
    required this.fullName,
    required this.imageUrl,
    required this.media,
  });

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        companyId: json["company_id"],
        phone: json["phone"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        contactPersonName: json["contact_person_name"],
        industryNoOfDeliveryInMonth: json["industry_no_of_delivery_in_month"],
        otp: json["otp"],
        uenNumber: json["UEN_number"],
        aecraFile: json["aecra_file"],
        nricPicture: json["nric_picture"],
        bankName: json["bank_name"],
        accountNumber: json["account_number"],
        ifsCode: json["ifs_code"],
        bankProof: json["bank_proof"],
        emergencyContactName: json["emergency_contact_name"],
        emergencyContactNumber: json["emergency_contact_number"],
        relationship: json["relationship"],
        referralCode: json["referral_code"],
        referredBy: json["referred_by"],
        securityToken: json["security_token"],
        cssNo: json["css_no"],
        branch: json["branch"],
        ownerId: json["owner_id"],
        ownerType: json["owner_type"],
        isEnable: json["is_enable"],
        isAdmin: json["is_admin"],
        isVerifyCode: json["is_verify_code"],
        isProfilePicture: json["is_profile_picture"],
        isVehicleDetails: json["is_vehicle_details"],
        isNricPicture: json["is_nric_picture"],
        isAccountDetails: json["is_account_details"],
        isEmrgencyDetails: json["is_emrgency_details"],
        image: json["image"],
        facebook: json["facebook"],
        linkedin: json["linkedin"],
        skype: json["skype"],
        staffMember: json["staff_member"],
        sendWelcomeEmail: json["send_welcome_email"],
        defaultLanguage: json["default_language"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        stripeId: json["stripe_id"],
        pmType: json["pm_type"],
        pmLastFour: json["pm_last_four"],
        trialEndsAt: json["trial_ends_at"],
        apiToken: json["api_token"],
        statusOnOff: json["status_on_off"],
        isKycVerify: json["is_kyc_verify"],
        fullName: json["full_name"],
        imageUrl: json["image_url"],
        media: List<Media>.from(json["media"].map((x) => Media.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "company_id": companyId,
        "phone": phone,
        "latitude": latitude,
        "longitude": longitude,
        "contact_person_name": contactPersonName,
        "industry_no_of_delivery_in_month": industryNoOfDeliveryInMonth,
        "otp": otp,
        "UEN_number": uenNumber,
        "aecra_file": aecraFile,
        "nric_picture": nricPicture,
        "bank_name": bankName,
        "account_number": accountNumber,
        "ifs_code": ifsCode,
        "bank_proof": bankProof,
        "emergency_contact_name": emergencyContactName,
        "emergency_contact_number": emergencyContactNumber,
        "relationship": relationship,
        "referral_code": referralCode,
        "referred_by": referredBy,
        "security_token": securityToken,
        "css_no": cssNo,
        "branch": branch,
        "owner_id": ownerId,
        "owner_type": ownerType,
        "is_enable": isEnable,
        "is_admin": isAdmin,
        "is_verify_code": isVerifyCode,
        "is_profile_picture": isProfilePicture,
        "is_vehicle_details": isVehicleDetails,
        "is_nric_picture": isNricPicture,
        "is_account_details": isAccountDetails,
        "is_emrgency_details": isEmrgencyDetails,
        "image": image,
        "facebook": facebook,
        "linkedin": linkedin,
        "skype": skype,
        "staff_member": staffMember,
        "send_welcome_email": sendWelcomeEmail,
        "default_language": defaultLanguage,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "stripe_id": stripeId,
        "pm_type": pmType,
        "pm_last_four": pmLastFour,
        "trial_ends_at": trialEndsAt,
        "api_token": apiToken,
        "status_on_off": statusOnOff,
        "is_kyc_verify": isKycVerify,
        "full_name": fullName,
        "image_url": imageUrl,
        "media": List<dynamic>.from(media.map((x) => x.toJson())),
      };
}

class Media {
  int id;
  String modelType;
  String modelId;
  String collectionName;
  String name;
  String fileName;
  String mimeType;
  String disk;
  String size;
  List<dynamic> manipulations;
  List<dynamic> customProperties;
  List<dynamic> responsiveImages;
  String orderColumn;
  DateTime createdAt;
  DateTime updatedAt;
  String conversionsDisk;
  String uuid;
  List<dynamic> generatedConversions;
  String originalUrl;
  String previewUrl;

  Media({
    required this.id,
    required this.modelType,
    required this.modelId,
    required this.collectionName,
    required this.name,
    required this.fileName,
    required this.mimeType,
    required this.disk,
    required this.size,
    required this.manipulations,
    required this.customProperties,
    required this.responsiveImages,
    required this.orderColumn,
    required this.createdAt,
    required this.updatedAt,
    required this.conversionsDisk,
    required this.uuid,
    required this.generatedConversions,
    required this.originalUrl,
    required this.previewUrl,
  });

  factory Media.fromJson(Map<String, dynamic> json) => Media(
        id: json["id"],
        modelType: json["model_type"],
        modelId: json["model_id"],
        collectionName: json["collection_name"],
        name: json["name"],
        fileName: json["file_name"],
        mimeType: json["mime_type"],
        disk: json["disk"],
        size: json["size"],
        manipulations: List<dynamic>.from(json["manipulations"].map((x) => x)),
        customProperties:
            List<dynamic>.from(json["custom_properties"].map((x) => x)),
        responsiveImages:
            List<dynamic>.from(json["responsive_images"].map((x) => x)),
        orderColumn: json["order_column"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        conversionsDisk: json["conversions_disk"],
        uuid: json["uuid"],
        generatedConversions:
            List<dynamic>.from(json["generated_conversions"].map((x) => x)),
        originalUrl: json["original_url"],
        previewUrl: json["preview_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "model_type": modelType,
        "model_id": modelId,
        "collection_name": collectionName,
        "name": name,
        "file_name": fileName,
        "mime_type": mimeType,
        "disk": disk,
        "size": size,
        "manipulations": List<dynamic>.from(manipulations.map((x) => x)),
        "custom_properties": List<dynamic>.from(customProperties.map((x) => x)),
        "responsive_images": List<dynamic>.from(responsiveImages.map((x) => x)),
        "order_column": orderColumn,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "conversions_disk": conversionsDisk,
        "uuid": uuid,
        "generated_conversions":
            List<dynamic>.from(generatedConversions.map((x) => x)),
        "original_url": originalUrl,
        "preview_url": previewUrl,
      };
}

// // To parse this JSON data, do
// //
// //     final getCompletedOrdersModel = getCompletedOrdersModelFromJson(jsonString);

// import 'dart:convert';

// GetCompletedOrdersModel getCompletedOrdersModelFromJson(String str) => GetCompletedOrdersModel.fromJson(json.decode(str));

// String getCompletedOrdersModelToJson(GetCompletedOrdersModel data) => json.encode(data.toJson());

// class GetCompletedOrdersModel {
//     bool status;
//     String message;
//     Data data;

//     GetCompletedOrdersModel({
//         required this.status,
//         required this.message,
//         required this.data,
//     });

//     factory GetCompletedOrdersModel.fromJson(Map<String, dynamic> json) => GetCompletedOrdersModel(
//         status: json["status"],
//         message: json["message"],
//         data: Data.fromJson(json["data"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "status": status,
//         "message": message,
//         "data": data.toJson(),
//     };
// }

// class Data {
//     List<GetCompletedOrdersModelData> orders;

//     Data({
//         required this.orders,
//     });

//     factory Data.fromJson(Map<String, dynamic> json) => Data(
//         orders: List<GetCompletedOrdersModelData>.from(json["orders"].map((x) => GetCompletedOrdersModelData.fromJson(x))),
//     );

//     Map<String, dynamic> toJson() => {
//         "orders": List<dynamic>.from(orders.map((x) => x.toJson())),
//     };
// }

// class GetCompletedOrdersModelData {
//     int id;
//     String bookingId;
//     String userId;
//     String driverId;
//     dynamic vehicleId;
//     DateTime bookingDate;
//     String pickupOtp;
//     String deliveryOtp;
//     String bookingType;
//     String vehicleType;
//     String deliveryTypeId;
//     String paymentMode;
//     dynamic payable;
//     String bookingAmount;
//     String? paymentDetails;
//     String isRoundTrip;
//     dynamic parcelPhoto;
//     String gst;
//     String additionalTotal;
//     String totalAmount;
//     String notes;
//     String isConfirmed;
//     String isPickuped;
//     String bookingStatus;
//     String senderUnitnoBlockno;
//     String pickupAddreess;
//     String? bookingTimeFromVehicle;
//     String pickuptimeFrom;
//     String pickuptimeTo;
//     dynamic deliverytimeFrom;
//     String? additionalServicesId;
//     dynamic deliverytimeTo;
//     String latitude;
//     String longitude;
//     String distance;
//     DateTime? pickupedAt;
//     dynamic acceptedAt;
//     dynamic completedAt;
//     dynamic packagePictures;
//     String? pickupPicture;
//     dynamic completedPicture;
//     DateTime createdAt;
//     DateTime updatedAt;
//     List<BookingProduct> bookingProducts;
//     Driver driver;
//     VehicleDetails vehicleDetails;
//     dynamic additionalService;
//     List<dynamic> fromAddress;
//     List<BookingDeliveryAddress> bookingDeliveryAddresses;
//     DeliveryType deliveryType;

//     GetCompletedOrdersModelData({
//         required this.id,
//         required this.bookingId,
//         required this.userId,
//         required this.driverId,
//         required this.vehicleId,
//         required this.bookingDate,
//         required this.pickupOtp,
//         required this.deliveryOtp,
//         required this.bookingType,
//         required this.vehicleType,
//         required this.deliveryTypeId,
//         required this.paymentMode,
//         required this.payable,
//         required this.bookingAmount,
//         required this.paymentDetails,
//         required this.isRoundTrip,
//         required this.parcelPhoto,
//         required this.gst,
//         required this.additionalTotal,
//         required this.totalAmount,
//         required this.notes,
//         required this.isConfirmed,
//         required this.isPickuped,
//         required this.bookingStatus,
//         required this.senderUnitnoBlockno,
//         required this.pickupAddreess,
//         required this.bookingTimeFromVehicle,
//         required this.pickuptimeFrom,
//         required this.pickuptimeTo,
//         required this.deliverytimeFrom,
//         required this.additionalServicesId,
//         required this.deliverytimeTo,
//         required this.latitude,
//         required this.longitude,
//         required this.distance,
//         required this.pickupedAt,
//         required this.acceptedAt,
//         required this.completedAt,
//         required this.packagePictures,
//         required this.pickupPicture,
//         required this.completedPicture,
//         required this.createdAt,
//         required this.updatedAt,
//         required this.bookingProducts,
//         required this.driver,
//         required this.vehicleDetails,
//         required this.additionalService,
//         required this.fromAddress,
//         required this.bookingDeliveryAddresses,
//         required this.deliveryType,
//     });

//     factory GetCompletedOrdersModelData.fromJson(Map<String, dynamic> json) => GetCompletedOrdersModelData(
//         id: json["id"],
//         bookingId: json["booking_id"],
//         userId: json["user_id"],
//         driverId: json["driver_id"],
//         vehicleId: json["vehicle_id"],
//         bookingDate: DateTime.parse(json["booking_date"]),
//         pickupOtp: json["pickup_otp"],
//         deliveryOtp: json["delivery_otp"],
//         bookingType: json["booking_type"],
//         vehicleType: json["vehicle_type"],
//         deliveryTypeId: json["delivery_type_id"],
//         paymentMode: json["payment_mode"],
//         payable: json["payable"],
//         bookingAmount: json["booking_amount"],
//         paymentDetails: json["payment_details"],
//         isRoundTrip: json["is_round_trip"],
//         parcelPhoto: json["parcel_photo"],
//         gst: json["gst"],
//         additionalTotal: json["additional_total"],
//         totalAmount: json["total_amount"],
//         notes: json["notes"],
//         isConfirmed: json["is_confirmed"],
//         isPickuped: json["is_pickuped"],
//         bookingStatus: json["booking_status"],
//         senderUnitnoBlockno: json["sender_unitno_blockno"],
//         pickupAddreess: json["pickup_addreess"],
//         bookingTimeFromVehicle: json["booking_time_from_vehicle"],
//         pickuptimeFrom: json["pickuptime_from"],
//         pickuptimeTo: json["pickuptime_to"],
//         deliverytimeFrom: json["deliverytime_from"],
//         additionalServicesId: json["additional_services_id"],
//         deliverytimeTo: json["deliverytime_to"],
//         latitude: json["latitude"],
//         longitude: json["longitude"],
//         distance: json["distance"],
//         pickupedAt: json["pickuped_at"] == null ? null : DateTime.parse(json["pickuped_at"]),
//         acceptedAt: json["accepted_at"],
//         completedAt: json["completed_at"],
//         packagePictures: json["package_pictures"],
//         pickupPicture: json["pickup_picture"],
//         completedPicture: json["completed_picture"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//         bookingProducts: List<BookingProduct>.from(json["booking_products"].map((x) => BookingProduct.fromJson(x))),
//         driver: Driver.fromJson(json["driver"]),
//         vehicleDetails: VehicleDetails.fromJson(json["vehicle_details"]),
//         additionalService: json["additional_service"],
//         fromAddress: List<dynamic>.from(json["from_address"].map((x) => x)),
//         bookingDeliveryAddresses: List<BookingDeliveryAddress>.from(json["booking_delivery_addresses"].map((x) => BookingDeliveryAddress.fromJson(x))),
//         deliveryType: DeliveryType.fromJson(json["delivery_type"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "booking_id": bookingId,
//         "user_id": userId,
//         "driver_id": driverId,
//         "vehicle_id": vehicleId,
//         "booking_date": "${bookingDate.year.toString().padLeft(4, '0')}-${bookingDate.month.toString().padLeft(2, '0')}-${bookingDate.day.toString().padLeft(2, '0')}",
//         "pickup_otp": pickupOtp,
//         "delivery_otp": deliveryOtp,
//         "booking_type": bookingType,
//         "vehicle_type": vehicleType,
//         "delivery_type_id": deliveryTypeId,
//         "payment_mode": paymentMode,
//         "payable": payable,
//         "booking_amount": bookingAmount,
//         "payment_details": paymentDetails,
//         "is_round_trip": isRoundTrip,
//         "parcel_photo": parcelPhoto,
//         "gst": gst,
//         "additional_total": additionalTotal,
//         "total_amount": totalAmount,
//         "notes": notes,
//         "is_confirmed": isConfirmed,
//         "is_pickuped": isPickuped,
//         "booking_status": bookingStatus,
//         "sender_unitno_blockno": senderUnitnoBlockno,
//         "pickup_addreess": pickupAddreess,
//         "booking_time_from_vehicle": bookingTimeFromVehicle,
//         "pickuptime_from": pickuptimeFrom,
//         "pickuptime_to": pickuptimeTo,
//         "deliverytime_from": deliverytimeFrom,
//         "additional_services_id": additionalServicesId,
//         "deliverytime_to": deliverytimeTo,
//         "latitude": latitude,
//         "longitude": longitude,
//         "distance": distance,
//         "pickuped_at": pickupedAt?.toIso8601String(),
//         "accepted_at": acceptedAt,
//         "completed_at": completedAt,
//         "package_pictures": packagePictures,
//         "pickup_picture": pickupPicture,
//         "completed_picture": completedPicture,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//         "booking_products": List<dynamic>.from(bookingProducts.map((x) => x.toJson())),
//         "driver": driver.toJson(),
//         "vehicle_details": vehicleDetails.toJson(),
//         "additional_service": additionalService,
//         "from_address": List<dynamic>.from(fromAddress.map((x) => x)),
//         "booking_delivery_addresses": List<dynamic>.from(bookingDeliveryAddresses.map((x) => x.toJson())),
//         "delivery_type": deliveryType.toJson(),
//     };
// }

// class BookingDeliveryAddress {
//     int id;
//     String bookingId;
//     String customerName;
//     String customerMobile;
//     String reciverName;
//     String reciverMobile;
//     String unitnoBlockno;
//     String address;
//     String postalcode;
//     String latitude;
//     String longitude;
//     String deliveryStatus;
//     DateTime createdAt;
//     DateTime updatedAt;

//     BookingDeliveryAddress({
//         required this.id,
//         required this.bookingId,
//         required this.customerName,
//         required this.customerMobile,
//         required this.reciverName,
//         required this.reciverMobile,
//         required this.unitnoBlockno,
//         required this.address,
//         required this.postalcode,
//         required this.latitude,
//         required this.longitude,
//         required this.deliveryStatus,
//         required this.createdAt,
//         required this.updatedAt,
//     });

//     factory BookingDeliveryAddress.fromJson(Map<String, dynamic> json) => BookingDeliveryAddress(
//         id: json["id"],
//         bookingId: json["booking_id"],
//         customerName: json["customer_name"],
//         customerMobile: json["customer_mobile"],
//         reciverName: json["reciver_name"],
//         reciverMobile: json["reciver_mobile"],
//         unitnoBlockno: json["unitno_blockno"],
//         address: json["address"],
//         postalcode: json["postalcode"],
//         latitude: json["latitude"],
//         longitude: json["longitude"],
//         deliveryStatus: json["delivery_status"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "booking_id": bookingId,
//         "customer_name": customerName,
//         "customer_mobile": customerMobile,
//         "reciver_name": reciverName,
//         "reciver_mobile": reciverMobile,
//         "unitno_blockno": unitnoBlockno,
//         "address": address,
//         "postalcode": postalcode,
//         "latitude": latitude,
//         "longitude": longitude,
//         "delivery_status": deliveryStatus,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//     };
// }

// class BookingProduct {
//     int id;
//     String bookingId;
//     String bookingProductId;
//     String parcelItems;
//     String parcelSize;
//     dynamic productPicture;
//     String length;
//     String bookingProductWith;
//     String height;
//     String qty;
//     String kg;
//     String pickuptimeFrom;
//     String pickuptimeTo;
//     String deliveryDate;
//     String deliverytimeFrom;
//     String deliverytimeTo;
//     DateTime createdAt;
//     DateTime updatedAt;

//     BookingProduct({
//         required this.id,
//         required this.bookingId,
//         required this.bookingProductId,
//         required this.parcelItems,
//         required this.parcelSize,
//         required this.productPicture,
//         required this.length,
//         required this.bookingProductWith,
//         required this.height,
//         required this.qty,
//         required this.kg,
//         required this.pickuptimeFrom,
//         required this.pickuptimeTo,
//         required this.deliveryDate,
//         required this.deliverytimeFrom,
//         required this.deliverytimeTo,
//         required this.createdAt,
//         required this.updatedAt,
//     });

//     factory BookingProduct.fromJson(Map<String, dynamic> json) => BookingProduct(
//         id: json["id"],
//         bookingId: json["booking_id"],
//         bookingProductId: json["booking_product_id"],
//         parcelItems: json["parcel_items"],
//         parcelSize: json["parcel_size"],
//         productPicture: json["product_picture"],
//         length: json["length"],
//         bookingProductWith: json["with"],
//         height: json["height"],
//         qty: json["qty"],
//         kg: json["kg"],
//         pickuptimeFrom: json["pickuptime_from"],
//         pickuptimeTo: json["pickuptime_to"],
//         deliveryDate: json["delivery_date"],
//         deliverytimeFrom: json["deliverytime_from"],
//         deliverytimeTo: json["deliverytime_to"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "booking_id": bookingId,
//         "booking_product_id": bookingProductId,
//         "parcel_items": parcelItems,
//         "parcel_size": parcelSize,
//         "product_picture": productPicture,
//         "length": length,
//         "with": bookingProductWith,
//         "height": height,
//         "qty": qty,
//         "kg": kg,
//         "pickuptime_from": pickuptimeFrom,
//         "pickuptime_to": pickuptimeTo,
//         "delivery_date": deliveryDate,
//         "deliverytime_from": deliverytimeFrom,
//         "deliverytime_to": deliverytimeTo,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//     };
// }

// class DeliveryType {
//     int id;
//     String name;
//     String basePerkm;
//     String description;
//     String price05Kg;
//     String price510Kg;
//     String price1015Kg;
//     String price1520Kg;
//     String price2025Kg;
//     String priceAbove25Kg;
//     String status;
//     DateTime createdAt;
//     DateTime updatedAt;

//     DeliveryType({
//         required this.id,
//         required this.name,
//         required this.basePerkm,
//         required this.description,
//         required this.price05Kg,
//         required this.price510Kg,
//         required this.price1015Kg,
//         required this.price1520Kg,
//         required this.price2025Kg,
//         required this.priceAbove25Kg,
//         required this.status,
//         required this.createdAt,
//         required this.updatedAt,
//     });

//     factory DeliveryType.fromJson(Map<String, dynamic> json) => DeliveryType(
//         id: json["id"],
//         name: json["name"],
//         basePerkm: json["base_perkm"],
//         description: json["description"],
//         price05Kg: json["price_0_5kg"],
//         price510Kg: json["price_5_10kg"],
//         price1015Kg: json["price_10_15kg"],
//         price1520Kg: json["price_15_20kg"],
//         price2025Kg: json["price_20_25kg"],
//         priceAbove25Kg: json["price_above_25kg"],
//         status: json["status"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "base_perkm": basePerkm,
//         "description": description,
//         "price_0_5kg": price05Kg,
//         "price_5_10kg": price510Kg,
//         "price_10_15kg": price1015Kg,
//         "price_15_20kg": price1520Kg,
//         "price_20_25kg": price2025Kg,
//         "price_above_25kg": priceAbove25Kg,
//         "status": status,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//     };
// }

// class Driver {
//     int id;
//     String firstName;
//     dynamic lastName;
//     String email;
//     dynamic companyId;
//     String phone;
//     String latitude;
//     String longitude;
//     dynamic contactPersonName;
//     dynamic industryNoOfDeliveryInMonth;
//     dynamic otp;
//     dynamic uenNumber;
//     dynamic aecraFile;
//     String nricPicture;
//     String bankName;
//     String accountNumber;
//     String ifsCode;
//     String bankProof;
//     String emergencyContactName;
//     String emergencyContactNumber;
//     String relationship;
//     String referralCode;
//     dynamic referredBy;
//     dynamic securityToken;
//     dynamic cssNo;
//     dynamic branch;
//     dynamic ownerId;
//     dynamic ownerType;
//     bool isEnable;
//     bool isAdmin;
//     String isVerifyCode;
//     String isProfilePicture;
//     String isVehicleDetails;
//     String isNricPicture;
//     String isAccountDetails;
//     String isEmrgencyDetails;
//     dynamic image;
//     dynamic facebook;
//     dynamic linkedin;
//     dynamic skype;
//     dynamic staffMember;
//     dynamic sendWelcomeEmail;
//     dynamic defaultLanguage;
//     dynamic emailVerifiedAt;
//     DateTime createdAt;
//     DateTime updatedAt;
//     dynamic stripeId;
//     dynamic pmType;
//     dynamic pmLastFour;
//     dynamic trialEndsAt;
//     dynamic apiToken;
//     String statusOnOff;
//     String isKycVerify;
//     String fullName;
//     String imageUrl;
//     List<Media> media;

//     Driver({
//         required this.id,
//         required this.firstName,
//         required this.lastName,
//         required this.email,
//         required this.companyId,
//         required this.phone,
//         required this.latitude,
//         required this.longitude,
//         required this.contactPersonName,
//         required this.industryNoOfDeliveryInMonth,
//         required this.otp,
//         required this.uenNumber,
//         required this.aecraFile,
//         required this.nricPicture,
//         required this.bankName,
//         required this.accountNumber,
//         required this.ifsCode,
//         required this.bankProof,
//         required this.emergencyContactName,
//         required this.emergencyContactNumber,
//         required this.relationship,
//         required this.referralCode,
//         required this.referredBy,
//         required this.securityToken,
//         required this.cssNo,
//         required this.branch,
//         required this.ownerId,
//         required this.ownerType,
//         required this.isEnable,
//         required this.isAdmin,
//         required this.isVerifyCode,
//         required this.isProfilePicture,
//         required this.isVehicleDetails,
//         required this.isNricPicture,
//         required this.isAccountDetails,
//         required this.isEmrgencyDetails,
//         required this.image,
//         required this.facebook,
//         required this.linkedin,
//         required this.skype,
//         required this.staffMember,
//         required this.sendWelcomeEmail,
//         required this.defaultLanguage,
//         required this.emailVerifiedAt,
//         required this.createdAt,
//         required this.updatedAt,
//         required this.stripeId,
//         required this.pmType,
//         required this.pmLastFour,
//         required this.trialEndsAt,
//         required this.apiToken,
//         required this.statusOnOff,
//         required this.isKycVerify,
//         required this.fullName,
//         required this.imageUrl,
//         required this.media,
//     });

//     factory Driver.fromJson(Map<String, dynamic> json) => Driver(
//         id: json["id"],
//         firstName: json["first_name"],
//         lastName: json["last_name"],
//         email: json["email"],
//         companyId: json["company_id"],
//         phone: json["phone"],
//         latitude: json["latitude"],
//         longitude: json["longitude"],
//         contactPersonName: json["contact_person_name"],
//         industryNoOfDeliveryInMonth: json["industry_no_of_delivery_in_month"],
//         otp: json["otp"],
//         uenNumber: json["UEN_number"],
//         aecraFile: json["aecra_file"],
//         nricPicture: json["nric_picture"],
//         bankName: json["bank_name"],
//         accountNumber: json["account_number"],
//         ifsCode: json["ifs_code"],
//         bankProof: json["bank_proof"],
//         emergencyContactName: json["emergency_contact_name"],
//         emergencyContactNumber: json["emergency_contact_number"],
//         relationship: json["relationship"],
//         referralCode: json["referral_code"],
//         referredBy: json["referred_by"],
//         securityToken: json["security_token"],
//         cssNo: json["css_no"],
//         branch: json["branch"],
//         ownerId: json["owner_id"],
//         ownerType: json["owner_type"],
//         isEnable: json["is_enable"],
//         isAdmin: json["is_admin"],
//         isVerifyCode: json["is_verify_code"],
//         isProfilePicture: json["is_profile_picture"],
//         isVehicleDetails: json["is_vehicle_details"],
//         isNricPicture: json["is_nric_picture"],
//         isAccountDetails: json["is_account_details"],
//         isEmrgencyDetails: json["is_emrgency_details"],
//         image: json["image"],
//         facebook: json["facebook"],
//         linkedin: json["linkedin"],
//         skype: json["skype"],
//         staffMember: json["staff_member"],
//         sendWelcomeEmail: json["send_welcome_email"],
//         defaultLanguage: json["default_language"],
//         emailVerifiedAt: json["email_verified_at"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//         stripeId: json["stripe_id"],
//         pmType: json["pm_type"],
//         pmLastFour: json["pm_last_four"],
//         trialEndsAt: json["trial_ends_at"],
//         apiToken: json["api_token"],
//         statusOnOff: json["status_on_off"],
//         isKycVerify: json["is_kyc_verify"],
//         fullName: json["full_name"],
//         imageUrl: json["image_url"],
//         media: List<Media>.from(json["media"].map((x) => Media.fromJson(x))),
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "first_name": firstName,
//         "last_name": lastName,
//         "email": email,
//         "company_id": companyId,
//         "phone": phone,
//         "latitude": latitude,
//         "longitude": longitude,
//         "contact_person_name": contactPersonName,
//         "industry_no_of_delivery_in_month": industryNoOfDeliveryInMonth,
//         "otp": otp,
//         "UEN_number": uenNumber,
//         "aecra_file": aecraFile,
//         "nric_picture": nricPicture,
//         "bank_name": bankName,
//         "account_number": accountNumber,
//         "ifs_code": ifsCode,
//         "bank_proof": bankProof,
//         "emergency_contact_name": emergencyContactName,
//         "emergency_contact_number": emergencyContactNumber,
//         "relationship": relationship,
//         "referral_code": referralCode,
//         "referred_by": referredBy,
//         "security_token": securityToken,
//         "css_no": cssNo,
//         "branch": branch,
//         "owner_id": ownerId,
//         "owner_type": ownerType,
//         "is_enable": isEnable,
//         "is_admin": isAdmin,
//         "is_verify_code": isVerifyCode,
//         "is_profile_picture": isProfilePicture,
//         "is_vehicle_details": isVehicleDetails,
//         "is_nric_picture": isNricPicture,
//         "is_account_details": isAccountDetails,
//         "is_emrgency_details": isEmrgencyDetails,
//         "image": image,
//         "facebook": facebook,
//         "linkedin": linkedin,
//         "skype": skype,
//         "staff_member": staffMember,
//         "send_welcome_email": sendWelcomeEmail,
//         "default_language": defaultLanguage,
//         "email_verified_at": emailVerifiedAt,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//         "stripe_id": stripeId,
//         "pm_type": pmType,
//         "pm_last_four": pmLastFour,
//         "trial_ends_at": trialEndsAt,
//         "api_token": apiToken,
//         "status_on_off": statusOnOff,
//         "is_kyc_verify": isKycVerify,
//         "full_name": fullName,
//         "image_url": imageUrl,
//         "media": List<dynamic>.from(media.map((x) => x.toJson())),
//     };
// }

// class Media {
//     int id;
//     String modelType;
//     String modelId;
//     String collectionName;
//     String name;
//     String fileName;
//     String mimeType;
//     String disk;
//     String size;
//     List<dynamic> manipulations;
//     List<dynamic> customProperties;
//     List<dynamic> responsiveImages;
//     String orderColumn;
//     DateTime createdAt;
//     DateTime updatedAt;
//     String conversionsDisk;
//     String uuid;
//     List<dynamic> generatedConversions;
//     String originalUrl;
//     String previewUrl;

//     Media({
//         required this.id,
//         required this.modelType,
//         required this.modelId,
//         required this.collectionName,
//         required this.name,
//         required this.fileName,
//         required this.mimeType,
//         required this.disk,
//         required this.size,
//         required this.manipulations,
//         required this.customProperties,
//         required this.responsiveImages,
//         required this.orderColumn,
//         required this.createdAt,
//         required this.updatedAt,
//         required this.conversionsDisk,
//         required this.uuid,
//         required this.generatedConversions,
//         required this.originalUrl,
//         required this.previewUrl,
//     });

//     factory Media.fromJson(Map<String, dynamic> json) => Media(
//         id: json["id"],
//         modelType: json["model_type"],
//         modelId: json["model_id"],
//         collectionName: json["collection_name"],
//         name: json["name"],
//         fileName: json["file_name"],
//         mimeType: json["mime_type"],
//         disk: json["disk"],
//         size: json["size"],
//         manipulations: List<dynamic>.from(json["manipulations"].map((x) => x)),
//         customProperties: List<dynamic>.from(json["custom_properties"].map((x) => x)),
//         responsiveImages: List<dynamic>.from(json["responsive_images"].map((x) => x)),
//         orderColumn: json["order_column"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//         conversionsDisk: json["conversions_disk"],
//         uuid: json["uuid"],
//         generatedConversions: List<dynamic>.from(json["generated_conversions"].map((x) => x)),
//         originalUrl: json["original_url"],
//         previewUrl: json["preview_url"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "model_type": modelType,
//         "model_id": modelId,
//         "collection_name": collectionName,
//         "name": name,
//         "file_name": fileName,
//         "mime_type": mimeType,
//         "disk": disk,
//         "size": size,
//         "manipulations": List<dynamic>.from(manipulations.map((x) => x)),
//         "custom_properties": List<dynamic>.from(customProperties.map((x) => x)),
//         "responsive_images": List<dynamic>.from(responsiveImages.map((x) => x)),
//         "order_column": orderColumn,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//         "conversions_disk": conversionsDisk,
//         "uuid": uuid,
//         "generated_conversions": List<dynamic>.from(generatedConversions.map((x) => x)),
//         "original_url": originalUrl,
//         "preview_url": previewUrl,
//     };
// }

// class VehicleDetails {
//     int id;
//     String userId;
//     String vehicleType;
//     String vehicleModel;
//     String vehicleNumber;
//     String drivingLicenseFront;
//     String drivingLicenseBack;
//     String vehicleFront;
//     String vehicleBack;
//     String status;
//     DateTime createdAt;
//     DateTime updatedAt;
//     String laravelThroughKey;

//     VehicleDetails({
//         required this.id,
//         required this.userId,
//         required this.vehicleType,
//         required this.vehicleModel,
//         required this.vehicleNumber,
//         required this.drivingLicenseFront,
//         required this.drivingLicenseBack,
//         required this.vehicleFront,
//         required this.vehicleBack,
//         required this.status,
//         required this.createdAt,
//         required this.updatedAt,
//         required this.laravelThroughKey,
//     });

//     factory VehicleDetails.fromJson(Map<String, dynamic> json) => VehicleDetails(
//         id: json["id"],
//         userId: json["user_id"],
//         vehicleType: json["vehicle_type"],
//         vehicleModel: json["vehicle_model"],
//         vehicleNumber: json["vehicle_number"],
//         drivingLicenseFront: json["driving_license_front"],
//         drivingLicenseBack: json["driving_license_back"],
//         vehicleFront: json["vehicle_front"],
//         vehicleBack: json["vehicle_back"],
//         status: json["status"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//         laravelThroughKey: json["laravel_through_key"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "user_id": userId,
//         "vehicle_type": vehicleType,
//         "vehicle_model": vehicleModel,
//         "vehicle_number": vehicleNumber,
//         "driving_license_front": drivingLicenseFront,
//         "driving_license_back": drivingLicenseBack,
//         "vehicle_front": vehicleFront,
//         "vehicle_back": vehicleBack,
//         "status": status,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//         "laravel_through_key": laravelThroughKey,
//     };
// }
