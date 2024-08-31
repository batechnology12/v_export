// To parse this JSON data, do
//
//     final getVehicleCalculation = getVehicleCalculationFromJson(jsonString);

import 'dart:convert';

GetVehicleCalculation getVehicleCalculationFromJson(String str) =>
    GetVehicleCalculation.fromJson(json.decode(str));

String getVehicleCalculationToJson(GetVehicleCalculation data) =>
    json.encode(data.toJson());

class GetVehicleCalculation {
  String status;
  String message;
  VehiclePaymentDetails paymentDetails;

  GetVehicleCalculation({
    required this.status,
    required this.message,
    required this.paymentDetails,
  });

  factory GetVehicleCalculation.fromJson(Map<String, dynamic> json) =>
      GetVehicleCalculation(
        status: json["status"],
        message: json["message"],
        paymentDetails: VehiclePaymentDetails.fromJson(json["payment_details"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "payment_details": paymentDetails.toJson(),
      };
}

class VehiclePaymentDetails {
  AdditionalStopCost vehicleType;
  AdditionalStopCost deliveryFees;
  AdditionalStopCost roundTripCost;
  AdditionalStopCost additionalStopCost;
  AdditionalStopCost driverHelpCost;
  AdditionalStopCost helperCost;
  AdditionalStopCost weekendCost;
  List<AdditionalServiceListData> additionalServices;
  AdditionalStopCost totalAdditionalServices;
  AdditionalStopCost totalCost;

  VehiclePaymentDetails({
    required this.vehicleType,
    required this.deliveryFees,
    required this.roundTripCost,
    required this.additionalStopCost,
    required this.driverHelpCost,
    required this.helperCost,
    required this.weekendCost,
    required this.additionalServices,
    required this.totalAdditionalServices,
    required this.totalCost,
  });

  factory VehiclePaymentDetails.fromJson(Map<String, dynamic> json) =>
      VehiclePaymentDetails(
        vehicleType: AdditionalStopCost.fromJson(json["vehicle_type"]),
        deliveryFees: AdditionalStopCost.fromJson(json["delivery_fees"]),
        roundTripCost: AdditionalStopCost.fromJson(json["round_trip_cost"]),
        additionalStopCost:
            AdditionalStopCost.fromJson(json["additional_stop_cost"]),
        driverHelpCost: AdditionalStopCost.fromJson(json["driver_help_cost"]),
        helperCost: AdditionalStopCost.fromJson(json["helper_cost"]),
        weekendCost: AdditionalStopCost.fromJson(json["weekend_cost"]),
        additionalServices: List<AdditionalServiceListData>.from(
            json["additional_services"]
                .map((x) => AdditionalServiceListData.fromJson(x))),
        totalAdditionalServices:
            AdditionalStopCost.fromJson(json["total_additional_services"]),
        totalCost: AdditionalStopCost.fromJson(json["total_cost"]),
      );

  Map<String, dynamic> toJson() => {
        "vehicle_type": vehicleType.toJson(),
        "delivery_fees": deliveryFees.toJson(),
        "round_trip_cost": roundTripCost.toJson(),
        "additional_stop_cost": additionalStopCost.toJson(),
        "driver_help_cost": driverHelpCost.toJson(),
        "helper_cost": helperCost.toJson(),
        "weekend_cost": weekendCost.toJson(),
        "additional_services":
            List<dynamic>.from(additionalServices.map((x) => x.toJson())),
        "total_additional_services": totalAdditionalServices.toJson(),
        "total_cost": totalCost.toJson(),
      };
}

class AdditionalServiceListData {
  String serviceName;
  String serviceCost;

  AdditionalServiceListData({
    required this.serviceName,
    required this.serviceCost,
  });

  factory AdditionalServiceListData.fromJson(Map<String, dynamic> json) =>
      AdditionalServiceListData(
        serviceName: json["service_name"],
        serviceCost: json["service_cost"],
      );

  Map<String, dynamic> toJson() => {
        "service_name": serviceName,
        "service_cost": serviceCost,
      };
}

class AdditionalStopCost {
  String name;
  String value;

  AdditionalStopCost({
    required this.name,
    required this.value,
  });

  factory AdditionalStopCost.fromJson(Map<String, dynamic> json) =>
      AdditionalStopCost(
        name: json["name"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "value": value,
      };
}


// // To parse this JSON data, do
// //
// //     final getVehicleCalculation = getVehicleCalculationFromJson(jsonString);

// import 'dart:convert';

// GetVehicleCalculation getVehicleCalculationFromJson(String str) =>
//     GetVehicleCalculation.fromJson(json.decode(str));

// String getVehicleCalculationToJson(GetVehicleCalculation data) =>
//     json.encode(data.toJson());

// class GetVehicleCalculation {
//   String status;
//   String message;
//   GetVehicleCalculationData paymentDetails;

//   GetVehicleCalculation({
//     required this.status,
//     required this.message,
//     required this.paymentDetails,
//   });

//   factory GetVehicleCalculation.fromJson(Map<String, dynamic> json) =>
//       GetVehicleCalculation(
//         status: json["status"],
//         message: json["message"],
//         paymentDetails:
//             GetVehicleCalculationData.fromJson(json["payment_details"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "message": message,
//         "payment_details": paymentDetails.toJson(),
//       };
// }

// class PaymentDetails {
//     AdditionalStopCost vehicleType;
//     AdditionalStopCost deliveryFees;
//     AdditionalStopCost roundTripCost;
//     AdditionalStopCost additionalStopCost;
//     AdditionalStopCost driverHelpCost;
//     AdditionalStopCost helperCost;
//     AdditionalStopCost weekendCost;
//     List<AdditionalService> additionalServices;
//     AdditionalStopCost totalAdditionalServices;
//     AdditionalStopCost totalCost;

//     PaymentDetails({
//         required this.vehicleType,
//         required this.deliveryFees,
//         required this.roundTripCost,
//         required this.additionalStopCost,
//         required this.driverHelpCost,
//         required this.helperCost,
//         required this.weekendCost,
//         required this.additionalServices,
//         required this.totalAdditionalServices,
//         required this.totalCost,
//     });

//     factory PaymentDetails.fromJson(Map<String, dynamic> json) => PaymentDetails(
//         vehicleType: AdditionalStopCost.fromJson(json["vehicle_type"]),
//         deliveryFees: AdditionalStopCost.fromJson(json["delivery_fees"]),
//         roundTripCost: AdditionalStopCost.fromJson(json["round_trip_cost"]),
//         additionalStopCost: AdditionalStopCost.fromJson(json["additional_stop_cost"]),
//         driverHelpCost: AdditionalStopCost.fromJson(json["driver_help_cost"]),
//         helperCost: AdditionalStopCost.fromJson(json["helper_cost"]),
//         weekendCost: AdditionalStopCost.fromJson(json["weekend_cost"]),
//         additionalServices: List<AdditionalService>.from(json["additional_services"].map((x) => AdditionalService.fromJson(x))),
//         totalAdditionalServices: AdditionalStopCost.fromJson(json["total_additional_services"]),
//         totalCost: AdditionalStopCost.fromJson(json["total_cost"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "vehicle_type": vehicleType.toJson(),
//         "delivery_fees": deliveryFees.toJson(),
//         "round_trip_cost": roundTripCost.toJson(),
//         "additional_stop_cost": additionalStopCost.toJson(),
//         "driver_help_cost": driverHelpCost.toJson(),
//         "helper_cost": helperCost.toJson(),
//         "weekend_cost": weekendCost.toJson(),
//         "additional_services": List<dynamic>.from(additionalServices.map((x) => x.toJson())),
//         "total_additional_services": totalAdditionalServices.toJson(),
//         "total_cost": totalCost.toJson(),
//     };
// }


// class AdditionalServiceListData {
//   String serviceName;
//   String serviceCost;

//   AdditionalServiceListData({
//     required this.serviceName,
//     required this.serviceCost,
//   });

//   factory AdditionalServiceListData.fromJson(Map<String, dynamic> json) =>
//       AdditionalServiceListData(
//         serviceName: json["service_name"] ?? "",
//         serviceCost: json["service_cost"] ?? "",
//       );

//   Map<String, dynamic> toJson() => {
//         "service_name": serviceName,
//         "service_cost": serviceCost,
//       };
// }

// class AdditionalStopCost {
//   String name;
//   String value;

//   AdditionalStopCost({
//     required this.name,
//     required this.value,
//   });

//   factory AdditionalStopCost.fromJson(Map<String, dynamic> json) =>
//       AdditionalStopCost(
//         name: json["name"],
//         value: json["value"],
//       );

//   Map<String, dynamic> toJson() => {
//         "name": name,
//         "value": value,
//       };
// }
