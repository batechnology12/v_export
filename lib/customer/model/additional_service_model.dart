// To parse this JSON data, do
//
//     final additionalServicesModel = additionalServicesModelFromJson(jsonString);

import 'dart:convert';

AdditionalServicesModel additionalServicesModelFromJson(String str) =>
    AdditionalServicesModel.fromJson(json.decode(str));

String additionalServicesModelToJson(AdditionalServicesModel data) =>
    json.encode(data.toJson());

class AdditionalServicesModel {
  bool status;
  String message;
  List<AdditionalServiceData> data;

  AdditionalServicesModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory AdditionalServicesModel.fromJson(Map<String, dynamic> json) =>
      AdditionalServicesModel(
        status: json["status"],
        message: json["message"],
        data: List<AdditionalServiceData>.from(json["data"].map((x) => AdditionalServiceData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class AdditionalServiceData {
  int id;
  String name;
  String description;
  String type;
  String amount;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  AdditionalServiceData({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.amount,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AdditionalServiceData.fromJson(Map<String, dynamic> json) => AdditionalServiceData(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        type: json["type"],
        amount: json["amount"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "type": type,
        "amount": amount,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
