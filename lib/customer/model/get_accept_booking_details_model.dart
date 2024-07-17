// To parse this JSON data, do
//
//     final getAcceptBookingModeldata = getAcceptBookingModeldataFromJson(jsonString);

import 'dart:convert';

GetAcceptBookingModeldata getAcceptBookingModeldataFromJson(String str) =>
    GetAcceptBookingModeldata.fromJson(json.decode(str));

String getAcceptBookingModeldataToJson(GetAcceptBookingModeldata data) =>
    json.encode(data.toJson());

class GetAcceptBookingModeldata {
  bool status;
  String message;
  GetAcceptBookingdata data;

  GetAcceptBookingModeldata({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetAcceptBookingModeldata.fromJson(Map<String, dynamic> json) =>
      GetAcceptBookingModeldata(
        status: json["status"],
        message: json["message"],
        data: GetAcceptBookingdata.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class GetAcceptBookingdata {
  int id;
  String bookingId;
  String userId;
  String driverId;
  dynamic vehicleId;
  DateTime bookingDate;
  String pickupOtp;
  String deliveryOtp;
  String bookingType;
  String deliveryTypeId;
  String paymentMode;
  String bookingAmount;
  String isRoundTrip;
  dynamic parcelPhoto;
  String gst;
  String additionalTotal;
  String totalAmount;
  String additionalServicesId;
  String notes;
  String isConfirmed;
  String isPickuped;
  String bookingStatus;
  String pickupAddreess;
  String latitude;
  String longitude;
  String distance;
  dynamic pickupedAt;
  DateTime acceptedAt;
  dynamic completedAt;
  dynamic packagePictures;
  DateTime createdAt;
  DateTime updatedAt;
  List<BookingProduct> bookingProducts;
  Driver driver;
  List<dynamic> vehicleDetails;
  dynamic additionalService;
  List<dynamic> fromAddress;
  List<BookingDeliveryAddress> bookingDeliveryAddresses;
  DeliveryType deliveryType;

  GetAcceptBookingdata({
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
    required this.pickupAddreess,
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

  factory GetAcceptBookingdata.fromJson(Map<String, dynamic> json) => GetAcceptBookingdata(
        id: json["id"],
        bookingId: json["booking_id"],
        userId: json["user_id"],
        driverId: json["driver_id"],
        vehicleId: json["vehicle_id"],
        bookingDate: DateTime.parse(json["booking_date"]),
        pickupOtp: json["pickup_otp"],
        deliveryOtp: json["delivery_otp"],
        bookingType: json["booking_type"],
        deliveryTypeId: json["delivery_type_id"],
        paymentMode: json["payment_mode"],
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
        pickupAddreess: json["pickup_addreess"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        distance: json["distance"],
        pickupedAt: json["pickuped_at"],
        acceptedAt: DateTime.parse(json["accepted_at"]),
        completedAt: json["completed_at"],
        packagePictures: json["package_pictures"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        bookingProducts: List<BookingProduct>.from(
            json["booking_products"].map((x) => BookingProduct.fromJson(x))),
        driver: Driver.fromJson(json["driver"]),
        vehicleDetails:
            List<dynamic>.from(json["vehicle_details"].map((x) => x)),
        additionalService: json["additional_service"],
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
        "delivery_type_id": deliveryTypeId,
        "payment_mode": paymentMode,
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
        "pickup_addreess": pickupAddreess,
        "latitude": latitude,
        "longitude": longitude,
        "distance": distance,
        "pickuped_at": pickupedAt,
        "accepted_at": acceptedAt.toIso8601String(),
        "completed_at": completedAt,
        "package_pictures": packagePictures,
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
        name: json["name"],
        description: json["description"],
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

class Driver {
  int id;
  String firstName;
  dynamic lastName;
  String email;
  dynamic companyId;
  String phone;
  dynamic latitude;
  dynamic longitude;
  dynamic contactPersonName;
  dynamic industryNoOfDeliveryInMonth;
  dynamic otp;
  dynamic uenNumber;
  dynamic aecraFile;
  dynamic nricPicture;
  dynamic bankName;
  dynamic accountNumber;
  dynamic ifsCode;
  dynamic bankProof;
  dynamic emergencyContactName;
  dynamic emergencyContactNumber;
  dynamic relationship;
  String referralCode;
  dynamic referredBy;
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
  List<dynamic> media;

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
        referredBy: json["referred_by"],
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
        media: List<dynamic>.from(json["media"].map((x) => x)),
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
        "media": List<dynamic>.from(media.map((x) => x)),
      };
}
