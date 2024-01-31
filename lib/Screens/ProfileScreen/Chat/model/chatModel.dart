// To parse this JSON data, do
//
//     final chatModel = chatModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ChatModel chatModelFromJson(String str) => ChatModel.fromJson(json.decode(str));

String chatModelToJson(ChatModel data) => json.encode(data.toJson());

class ChatModel {
  int totalSize;
  String limit;
  String offset;
  List<Message> message;

  ChatModel({
    required this.totalSize,
    required this.limit,
    required this.offset,
    required this.message,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        totalSize: json["total_size"],
        limit: json["limit"],
        offset: json["offset"],
        message:
            List<Message>.from(json["message"].map((x) => Message.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total_size": totalSize,
        "limit": limit,
        "offset": offset,
        "message": List<dynamic>.from(message.map((x) => x.toJson())),
      };
}

class Message {
  int adminId;
  int userId;
  String message;
  String sentByDeliveryMan;
  String sentByAdmin;
  String createdAt;

  Message({
    required this.adminId,
    required this.userId,
    required this.message,
    required this.sentByDeliveryMan,
    required this.sentByAdmin,
    required this.createdAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        adminId: json["admin_id"],
        userId: json["user_id"],
        message: json["message"],
        sentByDeliveryMan: json["sent_by_delivery_man"],
        sentByAdmin: json["sent_by_admin"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "admin_id": adminId,
        "user_id": userId,
        "message": message,
        "sent_by_delivery_man": sentByDeliveryMan,
        "sent_by_admin": sentByAdmin,
        "created_at": createdAt,
      };
}
