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
//   Data data;

//   GetUserModel({
//     required this.status,
//     required this.message,
//     required this.data,
//   });

//   factory GetUserModel.fromJson(Map<String, dynamic> json) => GetUserModel(
//         status: json["status"],
//         message: json["message"],
//         data: Data.fromJson(json["data"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "message": message,
//         "data": data.toJson(),
//       };
// }

// class Data {
//   UserData user;
//   List<dynamic> addresses;

//   Data({
//     required this.user,
//     required this.addresses,
//   });

//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//         user: UserData.fromJson(json["user"]),
//         addresses: List<dynamic>.from(json["addresses"].map((x) => x)),
//       );

//   Map<String, dynamic> toJson() => {
//         "user": user.toJson(),
//         "addresses": List<dynamic>.from(addresses.map((x) => x)),
//       };
// }

// class UserData {
//   int id;
//   String firstName;
//   dynamic lastName;
//   String email;
//   dynamic companyId;
//   String phone;
//   String contactPersonName;
//   String industryNoOfDeliveryInMonth;
//   String otp;
//   String uenNumber;
//   String aecraFile;
//   String nricPicture;
//   String bankName;
//   String accountNumber;
//   String ifsCode;
//   String bankProof;
//   String emergencyContactName;
//   String emergencyContactNumber;
//   String relationship;
//   String referralCode;
//   String securityToken;
//   String cssNo;
//   String branch;
//   String ownerId;
//   String ownerType;
//   bool isEnable;
//   bool isAdmin;
//   String image;
//   String facebook;
//   String linkedin;
//   String skype;
//   String staffMember;
//   String sendWelcomeEmail;
//   String defaultLanguage;
//   String emailVerifiedAt;
//   DateTime createdAt;
//   DateTime updatedAt;
//   String stripeId;
//   String pmType;
//   String pmLastFour;
//   String trialEndsAt;
//   String apiToken;
//   String fullName;
//   String imageUrl;
//   List<String> addresses;
//   List<String> media;

//   UserData({
//     required this.id,
//     required this.firstName,
//     required this.lastName,
//     required this.email,
//     required this.companyId,
//     required this.phone,
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
//     required this.fullName,
//     required this.imageUrl,
//     required this.addresses,
//     required this.media,
//   });

//   factory UserData.fromJson(Map<String, dynamic> json) => UserData(
//         id: json["id"] ?? 0,
//         firstName: json["first_name"] ?? "",
//         lastName: json["last_name"],
//         email: json["email"] ?? "",
//         companyId: json["company_id"],
//         phone: json["phone"] ?? "",
//         contactPersonName: json["contact_person_name"] ?? "",
//         industryNoOfDeliveryInMonth:
//             json["industry_no_of_delivery_in_month"] ?? "",
//         otp: json["otp"] ?? "",
//         uenNumber: json["UEN_number"] ?? "",
//         aecraFile: json["aecra_file"] ?? "",
//         nricPicture: json["nric_picture"] ?? "",
//         bankName: json["bank_name"] ?? "",
//         accountNumber: json["account_number"] ?? "",
//         ifsCode: json["ifs_code"] ?? "",
//         bankProof: json["bank_proof"] ?? "",
//         emergencyContactName: json["emergency_contact_name"] ?? "",
//         emergencyContactNumber: json["emergency_contact_number"] ?? "",
//         relationship: json["relationship"] ?? "",
//         referralCode: json["referral_code"] ?? "",
//         securityToken: json["security_token"] ?? "",
//         cssNo: json["css_no"] ?? "",
//         branch: json["branch"] ?? "",
//         ownerId: json["owner_id"] ?? "",
//         ownerType: json["owner_type"] ?? "",
//         isEnable: json["is_enable"],
//         isAdmin: json["is_admin"],
//         image: json["image"] ?? "",
//         facebook: json["facebook"] ?? "",
//         linkedin: json["linkedin"] ?? "",
//         skype: json["skype"] ?? "",
//         staffMember: json["staff_member"] ?? "",
//         sendWelcomeEmail: json["send_welcome_email"] ?? "",
//         defaultLanguage: json["default_language"] ?? "",
//         emailVerifiedAt: json["email_verified_at"] ?? "",
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//         stripeId: json["stripe_id"] ?? "",
//         pmType: json["pm_type"] ?? "",
//         pmLastFour: json["pm_last_four"] ?? "",
//         trialEndsAt: json["trial_ends_at"] ?? "",
//         apiToken: json["api_token"] ?? "",
//         fullName: json["full_name"] ?? "",
//         imageUrl: json["image_url"] ?? "",
//         addresses: List<String>.from(json["addresses"].map((x) => x)),
//         media: List<String>.from(json["media"].map((x) => x)),
//       );


//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "first_name": firstName,
//         "last_name": lastName,
//         "email": email,
//         "company_id": companyId,
//         "phone": phone,
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
//         "full_name": fullName,
//         "image_url": imageUrl,
//         "addresses": List<dynamic>.from(addresses.map((x) => x)),
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
  Data data;

  GetUserModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetUserModel.fromJson(Map<String, dynamic> json) => GetUserModel(
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
  User user;
  UserData addresses;

  Data({
    required this.user,
    required this.addresses,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: User.fromJson(json["user"]),
        addresses: UserData.fromJson(json["addresses"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "addresses": addresses.toJson(),
      };
}

class UserData {
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

  UserData({
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

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json["id"],
        userId: json["user_id"],
        street: json["street"],
        city: json["city"],
        state: json["state"],
        zip: json["zip"],
        country: json["country"],
        type: json["type"],
        unitNo: json["unit_no"],
        blockNo: json["block_no"],
        address: json["address"],
        landmark: json["landmark"],
        pincode: json["pincode"],
        contactPerson: json["contact_person"],
        contactNumber: json["contact_number"],
        latitude: json["latitude"],
        longitude: json["longitude"],
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

class User {
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
  String otp;
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
  UserData addresses;
  List<dynamic> media;

  User({
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

  factory User.fromJson(Map<String, dynamic> json) => User(
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
        addresses: UserData.fromJson(json["addresses"]),
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
        "addresses": addresses.toJson(),
        "media": List<dynamic>.from(media.map((x) => x)),
      };
}
