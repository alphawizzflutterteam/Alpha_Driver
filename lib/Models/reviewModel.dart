// To parse this JSON data, do
//
//     final reviewModel = reviewModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ReviewModel reviewModelFromJson(String str) =>
    ReviewModel.fromJson(json.decode(str));

String reviewModelToJson(ReviewModel data) => json.encode(data.toJson());

class ReviewModel {
  int totalSize;
  String limit;
  String offset;
  String averageRating;
  List<Review> review;

  ReviewModel({
    required this.totalSize,
    required this.limit,
    required this.offset,
    required this.averageRating,
    required this.review,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) => ReviewModel(
        totalSize: json["total_size"],
        limit: json["limit"],
        offset: json["offset"],
        averageRating: json["average_rating"],
        review:
            List<Review>.from(json["review"].map((x) => Review.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total_size": totalSize,
        "limit": limit,
        "offset": offset,
        "average_rating": averageRating,
        "review": List<dynamic>.from(review.map((x) => x.toJson())),
      };
}

class Review {
  int orderId;
  String customerName;
  int rating;
  String comment;
  String createdAt;

  Review({
    required this.orderId,
    required this.customerName,
    required this.rating,
    required this.comment,
    required this.createdAt,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        orderId: json["order_id"],
        customerName: json["customer_name"],
        rating: json["rating"],
        comment: json["comment"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "customer_name": customerName,
        "rating": rating,
        "comment": comment,
        "created_at": createdAt,
      };
}
