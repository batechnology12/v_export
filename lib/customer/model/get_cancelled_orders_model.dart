// To parse this JSON data, do
//
//     final getCancelledOrdersModel = getCancelledOrdersModelFromJson(jsonString);

import 'dart:convert';

GetCancelledOrdersModel getCancelledOrdersModelFromJson(String str) =>
    GetCancelledOrdersModel.fromJson(json.decode(str));

String getCancelledOrdersModelToJson(GetCancelledOrdersModel data) =>
    json.encode(data.toJson());

class GetCancelledOrdersModel {
  bool status;
  String message;
  Data data;

  GetCancelledOrdersModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetCancelledOrdersModel.fromJson(Map<String, dynamic> json) =>
      GetCancelledOrdersModel(
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
  List<GetCancelledOrdersModelData> orders;

  Data({
    required this.orders,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        orders: List<GetCancelledOrdersModelData>.from(
            json["orders"].map((x) => GetCancelledOrdersModelData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "orders": List<dynamic>.from(orders.map((x) => x.toJson())),
      };
}

class GetCancelledOrdersModelData {
  int id;
  String bookingId;
  String userId;
  String driverId;
  dynamic vehicleId;
  DateTime bookingDate;
  String pickupOtp;
  String deliveryOtp;
  BookingType? bookingType;
  String deliveryTypeId;
  PaymentMode paymentMode;
  String bookingAmount;
  String isRoundTrip;
  String? parcelPhoto;
  String gst;
  String additionalTotal;
  String totalAmount;
  String? additionalServicesId;
  String notes;
  String isConfirmed;
  String isPickuped;
  String bookingStatus;
  String latitude;
  String longitude;
  String distance;
  dynamic pickupedAt;
  DateTime? acceptedAt;
  dynamic completedAt;
  dynamic packagePictures;
  DateTime createdAt;
  DateTime updatedAt;
  List<BookingProduct> bookingProducts;
  Driver? driver;
  List<dynamic> vehicleDetails;
  dynamic additionalService;
  List<FromAddress> fromAddress;
  List<BookingDeliveryAddress> bookingDeliveryAddresses;
  DeliveryType deliveryType;

  GetCancelledOrdersModelData({
    required this.id,
    required this.bookingId,
    required this.userId,
    required this.driverId,
    required this.vehicleId,
    required this.bookingDate,
    required this.pickupOtp,
    required this.deliveryOtp,
    required this.bookingType,
    required this.deliveryTypeId,
    required this.paymentMode,
    required this.bookingAmount,
    required this.isRoundTrip,
    required this.parcelPhoto,
    required this.gst,
    required this.additionalTotal,
    required this.totalAmount,
    required this.additionalServicesId,
    required this.notes,
    required this.isConfirmed,
    required this.isPickuped,
    required this.bookingStatus,
    required this.latitude,
    required this.longitude,
    required this.distance,
    required this.pickupedAt,
    required this.acceptedAt,
    required this.completedAt,
    required this.packagePictures,
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

  factory GetCancelledOrdersModelData.fromJson(Map<String, dynamic> json) =>
      GetCancelledOrdersModelData(
        id: json["id"],
        bookingId: json["booking_id"],
        userId: json["user_id"],
        driverId: json["driver_id"],
        vehicleId: json["vehicle_id"],
        bookingDate: DateTime.parse(json["booking_date"]),
        pickupOtp: json["pickup_otp"],
        deliveryOtp: json["delivery_otp"],
        bookingType: bookingTypeValues.map[json["booking_type"]]!,
        deliveryTypeId: json["delivery_type_id"],
        paymentMode: paymentModeValues.map[json["payment_mode"]]!,
        bookingAmount: json["booking_amount"],
        isRoundTrip: json["is_round_trip"],
        parcelPhoto: json["parcel_photo"],
        gst: json["gst"],
        additionalTotal: json["additional_total"],
        totalAmount: json["total_amount"],
        additionalServicesId: json["additional_services_id"],
        notes: json["notes"],
        isConfirmed: json["is_confirmed"],
        isPickuped: json["is_pickuped"],
        bookingStatus: json["booking_status"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        distance: json["distance"],
        pickupedAt: json["pickuped_at"],
        acceptedAt: json["accepted_at"] == null
            ? null
            : DateTime.parse(json["accepted_at"]),
        completedAt: json["completed_at"],
        packagePictures: json["package_pictures"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        bookingProducts: List<BookingProduct>.from(
            json["booking_products"].map((x) => BookingProduct.fromJson(x))),
        driver: json["driver"] == null ? null : Driver.fromJson(json["driver"]),
        vehicleDetails:
            List<dynamic>.from(json["vehicle_details"].map((x) => x)),
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
        "pickup_otp": pickupOtp,
        "delivery_otp": deliveryOtp,
        "booking_type": bookingTypeValues.reverse[bookingType],
        "delivery_type_id": deliveryTypeId,
        "payment_mode": paymentModeValues.reverse[paymentMode],
        "booking_amount": bookingAmount,
        "is_round_trip": isRoundTrip,
        "parcel_photo": parcelPhoto,
        "gst": gst,
        "additional_total": additionalTotal,
        "total_amount": totalAmount,
        "additional_services_id": additionalServicesId,
        "notes": notes,
        "is_confirmed": isConfirmed,
        "is_pickuped": isPickuped,
        "booking_status": bookingStatus,
        "latitude": latitude,
        "longitude": longitude,
        "distance": distance,
        "pickuped_at": pickupedAt,
        "accepted_at": acceptedAt?.toIso8601String(),
        "completed_at": completedAt,
        "package_pictures": packagePictures,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "booking_products":
            List<dynamic>.from(bookingProducts.map((x) => x.toJson())),
        "driver": driver?.toJson(),
        "vehicle_details": List<dynamic>.from(vehicleDetails.map((x) => x)),
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
  CustomerName customerName;
  String customerMobile;
  String unitnoBlockno;
  BookingDeliveryAddressAddress address;
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
        customerName: customerNameValues.map[json["customer_name"]]!,
        customerMobile: json["customer_mobile"],
        unitnoBlockno: json["unitno_blockno"],
        address: bookingDeliveryAddressAddressValues.map[json["address"]]!,
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
        "customer_name": customerNameValues.reverse[customerName],
        "customer_mobile": customerMobile,
        "unitno_blockno": unitnoBlockno,
        "address": bookingDeliveryAddressAddressValues.reverse[address],
        "postalcode": postalcode,
        "latitude": latitude,
        "longitude": longitude,
        "delivery_status": deliveryStatus,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

enum BookingDeliveryAddressAddress {
  NO_263_KCC_STREET,
  THE_123_MAIN_STREET,
  THE_456_ANOTHER_STREET
}

final bookingDeliveryAddressAddressValues = EnumValues({
  "NO.263,KCC STREET": BookingDeliveryAddressAddress.NO_263_KCC_STREET,
  "123 Main Street": BookingDeliveryAddressAddress.THE_123_MAIN_STREET,
  "456 Another Street": BookingDeliveryAddressAddress.THE_456_ANOTHER_STREET
});

enum CustomerName { JANE_SMITH, JAY, JOHN_DOE }

final customerNameValues = EnumValues({
  "Jane Smith": CustomerName.JANE_SMITH,
  "jay": CustomerName.JAY,
  "John Doe": CustomerName.JOHN_DOE
});

class BookingProduct {
  int id;
  String bookingId;
  String bookingProductId;
  String? parcelItems;
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

enum BookingType { PARCEL }

final bookingTypeValues = EnumValues({"parcel": BookingType.PARCEL});

class DeliveryType {
  int id;
  Name name;
  Description description;
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
        name: nameValues.map[json["name"]]!,
        description: descriptionValues.map[json["description"]]!,
        price05Km: json["price_0_5km"],
        price510Km: json["price_5_10km"],
        price1015Km: json["price_10_15km"],
        price1520Km: json["price_15_20km"],
        price2025Km: json["price_20_25km"],
        priceAbove25Km: json["price_above_25km"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": nameValues.reverse[name],
        "description": descriptionValues.reverse[description],
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

enum Description {
  EXPRESS_DELIVERY_WITHIN_THE_CITY,
  STANDARD_DELIVERY_WITHIN_THE_CITY
}

final descriptionValues = EnumValues({
  "Express delivery within the city":
      Description.EXPRESS_DELIVERY_WITHIN_THE_CITY,
  "Standard delivery within the city":
      Description.STANDARD_DELIVERY_WITHIN_THE_CITY
});

enum Name { EXPRESS_DELIVERY, STANDARD_DELIVERY }

final nameValues = EnumValues({
  "Express Delivery": Name.EXPRESS_DELIVERY,
  "Standard Delivery": Name.STANDARD_DELIVERY
});

class Driver {
  int id;
  String firstName;
  dynamic lastName;
  String email;
  dynamic companyId;
  String phone;
  String? latitude;
  String? longitude;
  dynamic contactPersonName;
  dynamic industryNoOfDeliveryInMonth;
  String otp;
  dynamic uenNumber;
  dynamic aecraFile;
  String? nricPicture;
  String? bankName;
  String? accountNumber;
  String? ifsCode;
  String? bankProof;
  String? emergencyContactName;
  String? emergencyContactNumber;
  String? relationship;
  dynamic referralCode;
  dynamic securityToken;
  dynamic cssNo;
  dynamic branch;
  dynamic ownerId;
  dynamic ownerType;
  bool isEnable;
  bool isAdmin;
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
    required this.securityToken,
    required this.cssNo,
    required this.branch,
    required this.ownerId,
    required this.ownerType,
    required this.isEnable,
    required this.isAdmin,
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
        securityToken: json["security_token"],
        cssNo: json["css_no"],
        branch: json["branch"],
        ownerId: json["owner_id"],
        ownerType: json["owner_type"],
        isEnable: json["is_enable"],
        isAdmin: json["is_admin"],
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
        "security_token": securityToken,
        "css_no": cssNo,
        "branch": branch,
        "owner_id": ownerId,
        "owner_type": ownerType,
        "is_enable": isEnable,
        "is_admin": isAdmin,
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

class FromAddress {
  int id;
  String userId;
  Street street;
  City city;
  State state;
  String zip;
  Country country;
  Type type;
  UnitNo unitNo;
  BlockNo blockNo;
  FromAddressAddress address;
  Landmark landmark;
  String pincode;
  CustomerName contactPerson;
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
        userId: json["user_id"],
        street: streetValues.map[json["street"]]!,
        city: cityValues.map[json["city"]]!,
        state: stateValues.map[json["state"]]!,
        zip: json["zip"],
        country: countryValues.map[json["country"]]!,
        type: typeValues.map[json["type"]]!,
        unitNo: unitNoValues.map[json["unit_no"]]!,
        blockNo: blockNoValues.map[json["block_no"]]!,
        address: fromAddressAddressValues.map[json["address"]]!,
        landmark: landmarkValues.map[json["landmark"]]!,
        pincode: json["pincode"],
        contactPerson: customerNameValues.map[json["contact_person"]]!,
        contactNumber: json["contact_number"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "street": streetValues.reverse[street],
        "city": cityValues.reverse[city],
        "state": stateValues.reverse[state],
        "zip": zip,
        "country": countryValues.reverse[country],
        "type": typeValues.reverse[type],
        "unit_no": unitNoValues.reverse[unitNo],
        "block_no": blockNoValues.reverse[blockNo],
        "address": fromAddressAddressValues.reverse[address],
        "landmark": landmarkValues.reverse[landmark],
        "pincode": pincode,
        "contact_person": customerNameValues.reverse[contactPerson],
        "contact_number": contactNumber,
        "latitude": latitude,
        "longitude": longitude,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

enum FromAddressAddress { THE_123_MAIN_ST_APT_1_A_BLOCK_B1 }

final fromAddressAddressValues = EnumValues({
  "123 Main St, Apt 1A, Block B1":
      FromAddressAddress.THE_123_MAIN_ST_APT_1_A_BLOCK_B1
});

enum BlockNo { B1 }

final blockNoValues = EnumValues({"B1": BlockNo.B1});

enum City { ANYTOWN }

final cityValues = EnumValues({"Anytown": City.ANYTOWN});

enum Country { COUNTRY }

final countryValues = EnumValues({"Country": Country.COUNTRY});

enum Landmark { NEAR_CENTRAL_PARK }

final landmarkValues =
    EnumValues({"Near Central Park": Landmark.NEAR_CENTRAL_PARK});

enum State { ANYSTATE }

final stateValues = EnumValues({"Anystate": State.ANYSTATE});

enum Street { THE_123_MAIN_ST }

final streetValues = EnumValues({"123 Main St": Street.THE_123_MAIN_ST});

enum Type { HOME }

final typeValues = EnumValues({"Home": Type.HOME});

enum UnitNo { THE_1_A }

final unitNoValues = EnumValues({"1A": UnitNo.THE_1_A});

enum PaymentMode { PAYTM, UPI }

final paymentModeValues =
    EnumValues({"paytm": PaymentMode.PAYTM, "UPI": PaymentMode.UPI});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}