// To parse this JSON data, do
//
//     final getVehicleTypeModel = getVehicleTypeModelFromJson(jsonString);

import 'dart:convert';

GetVehicleTypeModel getVehicleTypeModelFromJson(String str) =>
    GetVehicleTypeModel.fromJson(json.decode(str));

String getVehicleTypeModelToJson(GetVehicleTypeModel data) =>
    json.encode(data.toJson());

class GetVehicleTypeModel {
  bool status;
  String message;
  List<GetVehicleTypeData> data;

  GetVehicleTypeModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetVehicleTypeModel.fromJson(Map<String, dynamic> json) =>
      GetVehicleTypeModel(
        status: json["status"],
        message: json["message"],
        data: List<GetVehicleTypeData>.from(
            json["data"].map((x) => GetVehicleTypeData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class GetVehicleTypeData {
  int id;
  String name;
  String description;
  String baseFees;
  String perkm;
  String roundTrip;
  String additionalStop;
  String driverHelp;
  String helper;
  String weekendFriSatSun;
  DateTime createdAt;
  DateTime updatedAt;

  GetVehicleTypeData({
    required this.id,
    required this.name,
    required this.description,
    required this.baseFees,
    required this.perkm,
    required this.roundTrip,
    required this.additionalStop,
    required this.driverHelp,
    required this.helper,
    required this.weekendFriSatSun,
    required this.createdAt,
    required this.updatedAt,
  });

  factory GetVehicleTypeData.fromJson(Map<String, dynamic> json) =>
      GetVehicleTypeData(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        baseFees: json["base_fees"],
        perkm: json["perkm"],
        roundTrip: json["round_trip"],
        additionalStop: json["additional_stop"],
        driverHelp: json["driver_help"],
        helper: json["helper"],
        weekendFriSatSun: json["weekend_fri_sat_sun"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "base_fees": baseFees,
        "perkm": perkm,
        "round_trip": roundTrip,
        "additional_stop": additionalStop,
        "driver_help": driverHelp,
        "helper": helper,
        "weekend_fri_sat_sun": weekendFriSatSun,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
