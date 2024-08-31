// To parse this JSON data, do
//
//     final paymentDetalis = paymentDetalisFromJson(jsonString);

import 'dart:convert';

PaymentDetalis paymentDetalisFromJson(String str) =>
    PaymentDetalis.fromJson(json.decode(str));

String paymentDetalisToJson(PaymentDetalis data) => json.encode(data.toJson());

class PaymentDetalis {
  String status;
  String message;
  PaymentDetailsData paymentDetails;

  PaymentDetalis({
    required this.status,
    required this.message,
    required this.paymentDetails,
  });

  factory PaymentDetalis.fromJson(Map<String, dynamic> json) => PaymentDetalis(
        status: json["status"],
        message: json["message"],
        paymentDetails: PaymentDetailsData.fromJson(json["payment_details"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "payment_details": paymentDetails.toJson(),
      };
}

class PaymentDetailsData {
  AccessRestrictedArea deliveryType;
  AccessRestrictedArea deliveryFees;
  AccessRestrictedArea accessRestrictedArea;
  AccessRestrictedArea cbdArea;
  AccessRestrictedArea roundTripCost;
  AccessRestrictedArea total;
  List<AccessRestrictedArea> additionalServices;

  PaymentDetailsData({
    required this.deliveryType,
    required this.deliveryFees,
    required this.accessRestrictedArea,
    required this.cbdArea,
    required this.roundTripCost,
    required this.total,
    required this.additionalServices,
  });

  factory PaymentDetailsData.fromJson(Map<String, dynamic> json) =>
      PaymentDetailsData(
        deliveryType: AccessRestrictedArea.fromJson(json["delivery_type"]),
        deliveryFees: AccessRestrictedArea.fromJson(json["delivery_fees"]),
        accessRestrictedArea:
            AccessRestrictedArea.fromJson(json["access_restricted_area"]),
        cbdArea: AccessRestrictedArea.fromJson(json["cbd_area"]),
        roundTripCost: AccessRestrictedArea.fromJson(json["round_trip_cost"]),
        total: AccessRestrictedArea.fromJson(json["total"]),
        additionalServices: List<AccessRestrictedArea>.from(
            json["additional_services"]
                .map((x) => AccessRestrictedArea.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "delivery_type": deliveryType.toJson(),
        "delivery_fees": deliveryFees.toJson(),
        "access_restricted_area": accessRestrictedArea.toJson(),
        "cbd_area": cbdArea.toJson(),
        "round_trip_cost": roundTripCost.toJson(),
        "total": total.toJson(),
        "additional_services":
            List<dynamic>.from(additionalServices.map((x) => x.toJson())),
      };
}

class AccessRestrictedArea {
  String name;
  String value;

  AccessRestrictedArea({
    required this.name,
    required this.value,
  });

  factory AccessRestrictedArea.fromJson(Map<String, dynamic> json) =>
      AccessRestrictedArea(
        name: json["name"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "value": value,
      };
}
