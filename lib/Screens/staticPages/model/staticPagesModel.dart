// To parse this JSON data, do
//
//     final staticPagesModel = staticPagesModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

StaticPagesModel staticPagesModelFromJson(String str) =>
    StaticPagesModel.fromJson(json.decode(str));

String staticPagesModelToJson(StaticPagesModel data) =>
    json.encode(data.toJson());

class StaticPagesModel {
  bool status;
  String message;
  Data data;

  StaticPagesModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory StaticPagesModel.fromJson(Map<String, dynamic> json) =>
      StaticPagesModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  String aboutUs;
  CancellationPolicy privacyPolicy;
  List<Faq> faq;
  CancellationPolicy termsNConditions;
  CancellationPolicy refundPolicy;
  CancellationPolicy returnPolicy;
  CancellationPolicy cancellationPolicy;
  CancellationPolicy shippingDeliveryPolicy;
  CancellationPolicy securityPolicyPolicy;
  CancellationPolicy paymentPolicy;
  CancellationPolicy conditionOfUsePolicy;
  CancellationPolicy securityInformation;
  // CancellationPolicy contactUs;

  Data({
    required this.aboutUs,
    required this.privacyPolicy,
    required this.faq,
    required this.termsNConditions,
    required this.refundPolicy,
    required this.returnPolicy,
    required this.cancellationPolicy,
    required this.shippingDeliveryPolicy,
    required this.securityPolicyPolicy,
    required this.paymentPolicy,
    required this.conditionOfUsePolicy,
    required this.securityInformation,
    // required this.contactUs,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        aboutUs: json["about_us"],
        privacyPolicy: CancellationPolicy.fromJson(json["privacy_policy"]),
        faq: List<Faq>.from(json["faq"].map((x) => Faq.fromJson(x))),
        termsNConditions:
            CancellationPolicy.fromJson(json["terms_n_conditions"]),
        refundPolicy: CancellationPolicy.fromJson(json["refund_policy"]),
        returnPolicy: CancellationPolicy.fromJson(json["return_policy"]),
        cancellationPolicy:
            CancellationPolicy.fromJson(json["cancellation_policy"]),
        shippingDeliveryPolicy:
            CancellationPolicy.fromJson(json["shipping_delivery_policy"]),
        securityPolicyPolicy:
            CancellationPolicy.fromJson(json["security_policy_policy"]),
        paymentPolicy: CancellationPolicy.fromJson(json["payment_policy"]),
        conditionOfUsePolicy:
            CancellationPolicy.fromJson(json["condition_of_use_policy"]),
        securityInformation:
            CancellationPolicy.fromJson(json["security_information"]),
        //  contactUs: CancellationPolicy.fromJson(json["contact_us"]),
      );

  Map<String, dynamic> toJson() => {
        "about_us": aboutUs,
        "privacy_policy": privacyPolicy.toJson(),
        "faq": List<dynamic>.from(faq.map((x) => x.toJson())),
        "terms_n_conditions": termsNConditions.toJson(),
        "refund_policy": refundPolicy.toJson(),
        "return_policy": returnPolicy.toJson(),
        "cancellation_policy": cancellationPolicy.toJson(),
        "shipping_delivery_policy": shippingDeliveryPolicy.toJson(),
        "security_policy_policy": securityPolicyPolicy.toJson(),
        "payment_policy": paymentPolicy.toJson(),
        "condition_of_use_policy": conditionOfUsePolicy.toJson(),
        "security_information": securityInformation.toJson(),
        // "contact_us": contactUs.toJson(),
      };
}

class CancellationPolicy {
  int status;
  String content;

  CancellationPolicy({
    required this.status,
    required this.content,
  });

  factory CancellationPolicy.fromJson(Map<String, dynamic> json) =>
      CancellationPolicy(
        status: json["status"],
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "content": content,
      };
}

class Faq {
  int id;
  String question;
  String answer;
  int ranking;
  int status;
  DateTime createdAt;
  DateTime updatedAt;

  Faq({
    required this.id,
    required this.question,
    required this.answer,
    required this.ranking,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Faq.fromJson(Map<String, dynamic> json) => Faq(
        id: json["id"],
        question: json["question"],
        answer: json["answer"],
        ranking: json["ranking"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "question": question,
        "answer": answer,
        "ranking": ranking,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
