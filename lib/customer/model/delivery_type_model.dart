// To parse this JSON data, do
//
//     final deliveyTypesModel = deliveyTypesModelFromJson(jsonString);

import 'dart:convert';

DeliveyTypesModel deliveyTypesModelFromJson(String str) =>
    DeliveyTypesModel.fromJson(json.decode(str));

String deliveyTypesModelToJson(DeliveyTypesModel data) =>
    json.encode(data.toJson());

class DeliveyTypesModel {
  bool status;
  String message;
  List<DeliveryTypeData> data;

  DeliveyTypesModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory DeliveyTypesModel.fromJson(Map<String, dynamic> json) =>
      DeliveyTypesModel(
        status: json["status"],
        message: json["message"],
        data: List<DeliveryTypeData>.from(
            json["data"].map((x) => DeliveryTypeData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DeliveryTypeData {
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

  DeliveryTypeData({
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

  factory DeliveryTypeData.fromJson(Map<String, dynamic> json) =>
      DeliveryTypeData(
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
