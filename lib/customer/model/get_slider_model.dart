// To parse this JSON data, do
//
//     final getSliderModel = getSliderModelFromJson(jsonString);

import 'dart:convert';

GetSliderModel getSliderModelFromJson(String str) =>
    GetSliderModel.fromJson(json.decode(str));

String getSliderModelToJson(GetSliderModel data) => json.encode(data.toJson());

class GetSliderModel {
  bool status;
  String message;
  List<SliderData> data;

  GetSliderModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetSliderModel.fromJson(Map<String, dynamic> json) => GetSliderModel(
        status: json["status"],
        message: json["message"],
        data: List<SliderData>.from(json["data"].map((x) => SliderData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class SliderData {
  int id;
  String title;
  String description;
  String image;
  String type;
  bool status;
  DateTime createdAt;
  DateTime updatedAt;

  SliderData({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.type,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SliderData.fromJson(Map<String, dynamic> json) => SliderData(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        image: json["image"],
        type: json["type"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "image": image,
        "type": type,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
