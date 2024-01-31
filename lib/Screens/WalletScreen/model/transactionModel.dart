// To parse this JSON data, do
//
//     final transactionModel = transactionModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

TransactionModel transactionModelFromJson(String str) =>
    TransactionModel.fromJson(json.decode(str));

String transactionModelToJson(TransactionModel data) =>
    json.encode(data.toJson());

class TransactionModel {
  int totalSize;
  String totalAmount;
  String totalOrders;
  String limit;
  String offset;
  List<Datum> data;
  bool status;
  String message;

  TransactionModel({
    required this.totalSize,
    required this.totalAmount,
    required this.totalOrders,
    required this.limit,
    required this.offset,
    required this.data,
    required this.status,
    required this.message,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        totalSize: json["total_size"],
        totalAmount: json["total_amount"],
        totalOrders: json["total_orders"],
        limit: json["limit"],
        offset: json["offset"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "total_size": totalSize,
        "total_amount": totalAmount,
        "total_orders": totalOrders,
        "limit": limit,
        "offset": offset,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "status": status,
        "message": message,
      };
}

class Datum {
  int id;
  int deliveryManId;
  int userId;
  String userType;
  String transactionId;
  String debit;
  String credit;
  String transactionType;
  String createdAt;
  String updatedAt;

  Datum({
    required this.id,
    required this.deliveryManId,
    required this.userId,
    required this.userType,
    required this.transactionId,
    required this.debit,
    required this.credit,
    required this.transactionType,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        deliveryManId: json["delivery_man_id"],
        userId: json["user_id"],
        userType: json["user_type"],
        transactionId: json["transaction_id"],
        debit: json["debit"],
        credit: json["credit"],
        transactionType: json["transaction_type"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "delivery_man_id": deliveryManId,
        "user_id": userId,
        "user_type": userType,
        "transaction_id": transactionId,
        "debit": debit,
        "credit": credit,
        "transaction_type": transactionType,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
