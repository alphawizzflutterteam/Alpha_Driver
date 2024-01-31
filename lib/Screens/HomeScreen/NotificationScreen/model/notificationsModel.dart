// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

NotificationModel notificationModelFromJson(String str) =>
    NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) =>
    json.encode(data.toJson());

class NotificationModel {
  String totalSize;
  bool status;
  String message;
  String limit;
  String offset;
  List<Notifications> notifications;

  NotificationModel({
    required this.totalSize,
    required this.status,
    required this.message,
    required this.limit,
    required this.offset,
    required this.notifications,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        totalSize: json["total_size"],
        status: json["status"],
        message: json["message"],
        limit: json["limit"],
        offset: json["offset"],
        notifications: List<Notifications>.from(
            json["notifications"].map((x) => Notifications.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total_size": totalSize,
        "status": status,
        "message": message,
        "limit": limit,
        "offset": offset,
        "notifications":
            List<dynamic>.from(notifications.map((x) => x.toJson())),
      };
}

class Notifications {
  int id;
  int deliveryManId;
  int orderId;
  String description;
  String createdAt;
  String updatedAt;

  Notifications({
    required this.id,
    required this.deliveryManId,
    required this.orderId,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Notifications.fromJson(Map<String, dynamic> json) => Notifications(
        id: json["id"],
        deliveryManId: json["delivery_man_id"],
        orderId: json["order_id"],
        description: json["description"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "delivery_man_id": deliveryManId,
        "order_id": orderId,
        "description": description,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
