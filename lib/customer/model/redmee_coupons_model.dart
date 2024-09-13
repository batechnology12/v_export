// To parse this JSON data, do
//
//     final getRedeemeModel = getRedeemeModelFromJson(jsonString);

import 'dart:convert';

GetRedeemeModel getRedeemeModelFromJson(String str) =>
    GetRedeemeModel.fromJson(json.decode(str));

String getRedeemeModelToJson(GetRedeemeModel data) =>
    json.encode(data.toJson());

class GetRedeemeModel {
  bool success;
  String message;
  RedeemeCouponData data;

  GetRedeemeModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory GetRedeemeModel.fromJson(Map<String, dynamic> json) =>
      GetRedeemeModel(
        success: json["success"],
        message: json["message"],
        data: RedeemeCouponData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
      };
}

class RedeemeCouponData {
  int id;
  String title;
  String description;
  String couponCode;
  String value;
  String type;
  String image;
  bool status;
  DateTime? createdAt;
  DateTime? updatedAt;

  RedeemeCouponData({
    required this.id,
    required this.title,
    required this.description,
    required this.couponCode,
    required this.value,
    required this.type,
    required this.image,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RedeemeCouponData.fromJson(Map<String, dynamic> json) => RedeemeCouponData(
        id: json["id"] ?? 0,
        title: json["title"] ?? "",
        description: json["description"] ?? "",
        couponCode: json["coupon_code"] ?? "",
        value: json["value"] ?? "",
        type: json["type"] ?? "",
        image: json["image"] ?? "",
        status: json["status"] ?? "",
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "coupon_code": couponCode,
        "value": value,
        "type": type,
        "image": image,
        "status": status,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
