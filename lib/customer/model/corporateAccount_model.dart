// To parse this JSON data, do
//
//     final getCorporateAccountModel = getCorporateAccountModelFromJson(jsonString);

import 'dart:convert';

GetCorporateAccountModel getCorporateAccountModelFromJson(String str) =>
    GetCorporateAccountModel.fromJson(json.decode(str));

String getCorporateAccountModelToJson(GetCorporateAccountModel data) =>
    json.encode(data.toJson());

class GetCorporateAccountModel {
  bool status;
  String message;
  GetCorporateAccountModelData data;
  String role;

  GetCorporateAccountModel({
    required this.status,
    required this.message,
    required this.data,
    required this.role,
  });

  factory GetCorporateAccountModel.fromJson(Map<String, dynamic> json) =>
      GetCorporateAccountModel(
        status: json["status"],
        message: json["message"],
        data: GetCorporateAccountModelData.fromJson(json["data"]),
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
        "role": role,
      };
}

class GetCorporateAccountModelData {
  int id;
  String firstName;
  dynamic lastName;
  String email;
  dynamic companyId;
  String phone;
  dynamic latitude;
  dynamic longitude;
  String contactPersonName;
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
  String isVerifyCode;
  String isProfilePicture;
  String isVehicleDetails;
  String isNricPicture;
  String isAccountDetails;
  String isEmrgencyDetails;
  String adminCharges;
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
  dynamic address;
  String fullName;
  String imageUrl;
  dynamic addresses;
  Company? company;
  List<Role> roles;
  List<dynamic> media;

  GetCorporateAccountModelData({
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
    required this.adminCharges,
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
    required this.address,
    required this.fullName,
    required this.imageUrl,
    required this.addresses,
    required this.company,
    required this.roles,
    required this.media,
  });

  factory GetCorporateAccountModelData.fromJson(Map<String, dynamic> json) =>
      GetCorporateAccountModelData(
        id: json["id"] ?? 0,
        firstName: json["first_name"] ?? "",
        lastName: json["last_name"] ?? "",
        email: json["email"] ?? "",
        companyId: json["company_id"] ?? "",
        phone: json["phone"] ?? "",
        latitude: json["latitude"] ?? "",
        longitude: json["longitude"] ?? "",
        contactPersonName: json["contact_person_name"] ?? "",
        industryNoOfDeliveryInMonth:
            json["industry_no_of_delivery_in_month"] ?? "",
        otp: json["otp"] ?? "",
        uenNumber: json["UEN_number"] ?? "",
        aecraFile: json["aecra_file"] ?? "",
        nricPicture: json["nric_picture"] ?? "",
        bankName: json["bank_name"] ?? "",
        accountNumber: json["account_number"] ?? "",
        ifsCode: json["ifs_code"] ?? "",
        bankProof: json["bank_proof"] ?? "",
        emergencyContactName: json["emergency_contact_name"] ?? "",
        emergencyContactNumber: json["emergency_contact_number"] ?? "",
        relationship: json["relationship"] ?? "",
        referralCode: json["referral_code"] ?? "",
        referredBy: json["referred_by"] ?? "",
        securityToken: json["security_token"] ?? "",
        cssNo: json["css_no"] ?? "",
        branch: json["branch"] ?? "",
        ownerId: json["owner_id"] ?? "",
        ownerType: json["owner_type"] ?? "",
        isEnable: json["is_enable"],
        isAdmin: json["is_admin"],
        isVerifyCode: json["is_verify_code"] ?? "",
        isProfilePicture: json["is_profile_picture"] ?? "",
        isVehicleDetails: json["is_vehicle_details"] ?? "",
        isNricPicture: json["is_nric_picture"] ?? "",
        isAccountDetails: json["is_account_details"] ?? "",
        isEmrgencyDetails: json["is_emrgency_details"] ?? "",
        adminCharges: json["admin_charges"] ?? "",
        image: json["image"] ?? "",
        facebook: json["facebook"] ?? "",
        linkedin: json["linkedin"] ?? "",
        skype: json["skype"] ?? "",
        staffMember: json["staff_member"] ?? "",
        sendWelcomeEmail: json["send_welcome_email"] ?? "",
        defaultLanguage: json["default_language"] ?? "",
        emailVerifiedAt: json["email_verified_at"] ?? "",
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        stripeId: json["stripe_id"] ?? "",
        pmType: json["pm_type"] ?? "",
        pmLastFour: json["pm_last_four"] ?? "",
        trialEndsAt: json["trial_ends_at"] ?? "",
        apiToken: json["api_token"] ?? "",
        statusOnOff: json["status_on_off"] ?? "",
        isKycVerify: json["is_kyc_verify"] ?? "",
        address: json["address"] ?? "",
        fullName: json["full_name"] ?? "",
        imageUrl: json["image_url"] ?? "",
        addresses: json["addresses"] ?? "",
        company:
            json["company"] == null ? null : Company.fromJson(json["company"]),
        roles: List<Role>.from(json["roles"].map((x) => Role.fromJson(x))),
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
        "is_verify_code": isVerifyCode,
        "is_profile_picture": isProfilePicture,
        "is_vehicle_details": isVehicleDetails,
        "is_nric_picture": isNricPicture,
        "is_account_details": isAccountDetails,
        "is_emrgency_details": isEmrgencyDetails,
        "admin_charges": adminCharges,
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
        "address": address,
        "full_name": fullName,
        "image_url": imageUrl,
        "addresses": addresses,
        "company": company!.toJson(),
        "roles": List<dynamic>.from(roles.map((x) => x.toJson())),
        "media": List<dynamic>.from(media.map((x) => x)),
      };
}

class Company {
  String userId;
  String companyName;
  dynamic companylogo;
  String industry;
  dynamic blobkNo;
  dynamic street;
  dynamic address;
  dynamic landmark;
  dynamic city;
  dynamic unitNo;
  dynamic contactPersonName;
  String industryNoOfDeliveryInMonth;
  dynamic pincode;
  String contactPerson;
  String contactNumber;
  dynamic latitude;
  dynamic longitude;
  DateTime createdAt;
  DateTime updatedAt;

  Company({
    required this.userId,
    required this.companyName,
    required this.companylogo,
    required this.industry,
    required this.blobkNo,
    required this.street,
    required this.address,
    required this.landmark,
    required this.city,
    required this.unitNo,
    required this.contactPersonName,
    required this.industryNoOfDeliveryInMonth,
    required this.pincode,
    required this.contactPerson,
    required this.contactNumber,
    required this.latitude,
    required this.longitude,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Company.fromJson(Map<String, dynamic> json) => Company(
        userId: json["user_id"] ?? "",
        companyName: json["company_name"] ?? "",
        companylogo: json["companylogo"] ?? "",
        industry: json["industry"] ?? "",
        blobkNo: json["blobk_no"] ?? "",
        street: json["street"] ?? "",
        address: json["address"] ?? "",
        landmark: json["landmark"] ?? "",
        city: json["city"] ?? "",
        unitNo: json["unit_no"] ?? "",
        contactPersonName: json["contact_person_name"] ?? "",
        industryNoOfDeliveryInMonth: json["industry_no_of_delivery_in_month"] ?? "",
        pincode: json["pincode"] ?? "",
        contactPerson: json["contact_person"] ?? "",
        contactNumber: json["contact_number"] ?? "",
        latitude: json["latitude"] ?? "",
        longitude: json["longitude"] ?? "",
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "company_name": companyName,
        "companylogo": companylogo,
        "industry": industry,
        "blobk_no": blobkNo,
        "street": street,
        "address": address,
        "landmark": landmark,
        "city": city,
        "unit_no": unitNo,
        "contact_person_name": contactPersonName,
        "industry_no_of_delivery_in_month": industryNoOfDeliveryInMonth,
        "pincode": pincode,
        "contact_person": contactPerson,
        "contact_number": contactNumber,
        "latitude": latitude,
        "longitude": longitude,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Role {
  int id;
  String name;
  String displayName;
  dynamic description;
  String guardName;
  bool isDefault;
  DateTime createdAt;
  DateTime updatedAt;
  Pivot? pivot;

  Role({
    required this.id,
    required this.name,
    required this.displayName,
    required this.description,
    required this.guardName,
    required this.isDefault,
    required this.createdAt,
    required this.updatedAt,
    required this.pivot,
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["id"] ?? "",
        name: json["name"] ?? "",
        displayName: json["display_name"] ?? "",
        description: json["description"] ?? "",
        guardName: json["guard_name"] ?? "",
        isDefault: json["is_default"] ?? "",
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        pivot:json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "display_name": displayName,
        "description": description,
        "guard_name": guardName,
        "is_default": isDefault,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "pivot": pivot!.toJson(),
      };
}

class Pivot {
  String modelId;
  String roleId;
  String modelType;

  Pivot({
    required this.modelId,
    required this.roleId,
    required this.modelType,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        modelId: json["model_id"],
        roleId: json["role_id"],
        modelType: json["model_type"],
      );

  Map<String, dynamic> toJson() => {
        "model_id": modelId,
        "role_id": roleId,
        "model_type": modelType,
      };
}
