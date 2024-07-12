// // To parse this JSON data, do
// //
// //     final getUserModel = getUserModelFromJson(jsonString);

// import 'dart:convert';

// GetUserModel getUserModelFromJson(String str) =>
//     GetUserModel.fromJson(json.decode(str));

// String getUserModelToJson(GetUserModel data) => json.encode(data.toJson());

// class GetUserModel {
//   bool status;
//   String message;
//   UserData data;

//   GetUserModel({
//     required this.status,
//     required this.message,
//     required this.data,
//   });

//   factory GetUserModel.fromJson(Map<String, dynamic> json) => GetUserModel(
//         status: json["status"],
//         message: json["message"],
//         data: UserData.fromJson(json["data"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "message": message,
//         "data": data.toJson(),
//       };
// }

// class UserData {
//   int id;
//   String firstName;
//   dynamic lastName;
//   String email;
//   dynamic companyId;
//   String phone;
//   dynamic latitude;
//   dynamic longitude;
//   dynamic contactPersonName;
//   dynamic industryNoOfDeliveryInMonth;
//   dynamic otp;
//   dynamic uenNumber;
//   dynamic aecraFile;
//   dynamic nricPicture;
//   dynamic bankName;
//   dynamic accountNumber;
//   dynamic ifsCode;
//   dynamic bankProof;
//   dynamic emergencyContactName;
//   dynamic emergencyContactNumber;
//   dynamic relationship;
//   dynamic referralCode;
//   dynamic securityToken;
//   dynamic cssNo;
//   dynamic branch;
//   dynamic ownerId;
//   dynamic ownerType;
//   bool isEnable;
//   bool isAdmin;
//   dynamic image;
//   dynamic facebook;
//   dynamic linkedin;
//   dynamic skype;
//   dynamic staffMember;
//   dynamic sendWelcomeEmail;
//   dynamic defaultLanguage;
//   dynamic emailVerifiedAt;
//   DateTime createdAt;
//   DateTime updatedAt;
//   dynamic stripeId;
//   dynamic pmType;
//   dynamic pmLastFour;
//   dynamic trialEndsAt;
//   dynamic apiToken;
//   String statusOnOff;
//   String fullName;
//   String imageUrl;
//   dynamic addresses;
//   List<dynamic> media;

//   UserData({
//     required this.id,
//     required this.firstName,
//     required this.lastName,
//     required this.email,
//     required this.companyId,
//     required this.phone,
//     required this.latitude,
//     required this.longitude,
//     required this.contactPersonName,
//     required this.industryNoOfDeliveryInMonth,
//     required this.otp,
//     required this.uenNumber,
//     required this.aecraFile,
//     required this.nricPicture,
//     required this.bankName,
//     required this.accountNumber,
//     required this.ifsCode,
//     required this.bankProof,
//     required this.emergencyContactName,
//     required this.emergencyContactNumber,
//     required this.relationship,
//     required this.referralCode,
//     required this.securityToken,
//     required this.cssNo,
//     required this.branch,
//     required this.ownerId,
//     required this.ownerType,
//     required this.isEnable,
//     required this.isAdmin,
//     required this.image,
//     required this.facebook,
//     required this.linkedin,
//     required this.skype,
//     required this.staffMember,
//     required this.sendWelcomeEmail,
//     required this.defaultLanguage,
//     required this.emailVerifiedAt,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.stripeId,
//     required this.pmType,
//     required this.pmLastFour,
//     required this.trialEndsAt,
//     required this.apiToken,
//     required this.statusOnOff,
//     required this.fullName,
//     required this.imageUrl,
//     required this.addresses,
//     required this.media,
//   });

//   factory UserData.fromJson(Map<String, dynamic> json) => UserData(
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
//         securityToken: json["security_token"],
//         cssNo: json["css_no"],
//         branch: json["branch"],
//         ownerId: json["owner_id"],
//         ownerType: json["owner_type"],
//         isEnable: json["is_enable"],
//         isAdmin: json["is_admin"],
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
//         fullName: json["full_name"],
//         imageUrl: json["image_url"],
//         addresses: json["addresses"],
//         media: List<dynamic>.from(json["media"].map((x) => x)),
//       );

//   Map<String, dynamic> toJson() => {
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
//         "security_token": securityToken,
//         "css_no": cssNo,
//         "branch": branch,
//         "owner_id": ownerId,
//         "owner_type": ownerType,
//         "is_enable": isEnable,
//         "is_admin": isAdmin,
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
//         "full_name": fullName,
//         "image_url": imageUrl,
//         "addresses": addresses,
//         "media": List<dynamic>.from(media.map((x) => x)),
//       };
// }

// To parse this JSON data, do
//
//     final getUserModel = getUserModelFromJson(jsonString);

import 'dart:convert';

GetUserModel getUserModelFromJson(String str) =>
    GetUserModel.fromJson(json.decode(str));

String getUserModelToJson(GetUserModel data) => json.encode(data.toJson());

class GetUserModel {
  bool status;
  String message;
  UserData data;

  GetUserModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetUserModel.fromJson(Map<String, dynamic> json) => GetUserModel(
        status: json["status"],
        message: json["message"],
        data: UserData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class UserData {
  int id;
  String firstName;
  String lastName;
  String email;
  dynamic companyId;
  String phone;
  String latitude;
  String longitude;
  String contactPersonName;
  String industryNoOfDeliveryInMonth;
  dynamic otp;
  dynamic uenNumber;
  dynamic aecraFile;
  dynamic nricPicture;
  String bankName;
  String accountNumber;
  String ifsCode;
  dynamic bankProof;
  String emergencyContactName;
  String emergencyContactNumber;
  String relationship;
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
  dynamic addresses;
  List<Media> media;

  UserData({
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
    required this.addresses,
    required this.media,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
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
        addresses: json["addresses"],
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
        "addresses": addresses,
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
