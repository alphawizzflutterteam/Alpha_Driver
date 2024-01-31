// To parse this JSON data, do
//
//     final withdrawModel = withdrawModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

WithdrawModel withdrawModelFromJson(String str) =>
    WithdrawModel.fromJson(json.decode(str));

String withdrawModelToJson(WithdrawModel data) => json.encode(data.toJson());

class WithdrawModel {
  int totalSize;
  String limit;
  String offset;
  List<Withdraw> withdraws;

  WithdrawModel({
    required this.totalSize,
    required this.limit,
    required this.offset,
    required this.withdraws,
  });

  factory WithdrawModel.fromJson(Map<String, dynamic> json) => WithdrawModel(
        totalSize: json["total_size"],
        limit: json["limit"],
        offset: json["offset"],
        withdraws: List<Withdraw>.from(
            json["withdraws"].map((x) => Withdraw.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total_size": totalSize,
        "limit": limit,
        "offset": offset,
        "withdraws": List<dynamic>.from(withdraws.map((x) => x.toJson())),
      };
}

class Withdraw {
  int id;
  int sellerId;
  int deliveryManId;
  // int adminId;
  String amount;
  int withdrawalMethodId;
  List<dynamic> withdrawalMethodFields;
  String transactionNote;
  String approved;
  String createdAt;
  String updatedAt;

  Withdraw({
    required this.id,
    required this.sellerId,
    required this.deliveryManId,
    // required this.adminId,
    required this.amount,
    required this.withdrawalMethodId,
    required this.withdrawalMethodFields,
    required this.transactionNote,
    required this.approved,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Withdraw.fromJson(Map<String, dynamic> json) => Withdraw(
        id: json["id"],
        sellerId: json["seller_id"],
        deliveryManId: json["delivery_man_id"],
        //    adminId: json["admin_id"],
        amount: json["amount"],
        withdrawalMethodId: json["withdrawal_method_id"],
        withdrawalMethodFields:
            List<dynamic>.from(json["withdrawal_method_fields"].map((x) => x)),
        transactionNote: json["transaction_note"],
        approved: json["approved"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "seller_id": sellerId,
        "delivery_man_id": deliveryManId,
        // "admin_id": adminId,
        "amount": amount,
        "withdrawal_method_id": withdrawalMethodId,
        "withdrawal_method_fields":
            List<dynamic>.from(withdrawalMethodFields.map((x) => x)),
        "transaction_note": transactionNote,
        "approved": approved,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
