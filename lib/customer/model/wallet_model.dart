// To parse this JSON data, do
//
//     final walletShowModel = walletShowModelFromJson(jsonString);

import 'dart:convert';

WalletShowModel walletShowModelFromJson(String str) =>
    WalletShowModel.fromJson(json.decode(str));

String walletShowModelToJson(WalletShowModel data) =>
    json.encode(data.toJson());

class WalletShowModel {
  bool status;
  String message;
  WalletData data;

  WalletShowModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory WalletShowModel.fromJson(Map<String, dynamic> json) =>
      WalletShowModel(
        status: json["status"],
        message: json["message"],
        data: WalletData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class WalletData {
  String totalCredits;
  String totalDebits;
  String earnings;
  String walletBalance;
  int jobs;
  List<WalletHistory> walletHistory;

  WalletData({
    required this.totalCredits,
    required this.totalDebits,
    required this.earnings,
    required this.walletBalance,
    required this.jobs,
    required this.walletHistory,
  });

  factory WalletData.fromJson(Map<String, dynamic> json) => WalletData(
        totalCredits: json["total_credits"] ?? "",
        totalDebits: json["total_debits"] ?? "",
        earnings: json["earnings"] ?? "",
        walletBalance: json["wallet_balance"] ?? "",
        jobs: json["jobs"] ?? "",
        walletHistory: List<WalletHistory>.from(
            json["wallet_history"].map((x) => WalletHistory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total_credits": totalCredits,
        "total_debits": totalDebits,
        "earnings": earnings,
        "wallet_balance": walletBalance,
        "jobs": jobs,
        "wallet_history":
            List<dynamic>.from(walletHistory.map((x) => x.toJson())),
      };
}

class WalletHistory {
  int id;
  String userId;
  dynamic bookingId;
  dynamic bookingShowId;
  String referenceNumber;
  String amount;
  String transactionType;
  String paymentType;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  WalletHistory({
    required this.id,
    required this.userId,
    required this.bookingId,
    required this.bookingShowId,
    required this.referenceNumber,
    required this.amount,
    required this.transactionType,
    required this.paymentType,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory WalletHistory.fromJson(Map<String, dynamic> json) => WalletHistory(
        id: json["id"] ?? 0,
        userId: json["user_id"] ?? "",
        bookingId: json["booking_id"] ?? "",
        bookingShowId: json["booking_show_id"] ?? "",
        referenceNumber: json["reference_number"] ?? "",
        amount: json["amount"] ?? "",
        transactionType: json["transaction_type"] ?? "",
        paymentType: json["payment_type"] ?? "",
        status: json["status"] ?? "",
        createdAt: json["created_at"] == null
            ? DateTime.now()
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? DateTime.now()
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "booking_id": bookingId,
        "booking_show_id": bookingShowId,
        "reference_number": referenceNumber,
        "amount": amount,
        "transaction_type": transactionType,
        "payment_type": paymentType,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
