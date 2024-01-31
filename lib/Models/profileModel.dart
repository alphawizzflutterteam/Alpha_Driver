// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ProfileModel profileModelFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  bool status;
  String message;
  List<Datum> data;

  ProfileModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  int id;
  String sellerId;
  String fName;
  String lName;
  String address;
  String countryCode;
  String phone;
  String email;
  String identityNumber;
  String identityType;
  String identityImage;
  String image;
  String bankName;
  String branch;
  String accountNo;
  String holderName;
  String accountType;
  String micrCode;
  String bankAddress;
  String ifscCode;
  int isActive;
  int isOnline;
  String createdAt;
  String updatedAt;
  String vehicleType;
  String registerationNumber;
  String issueDate;
  String expirationDate;
  String policyNumber;
  String coverageDate;
  String vehicleImage;
  String licenseNumber;
  String licenseDoi;
  String licenseExpDate;
  String licenseState;
  String licenseImage;
  String city;
  String state;
  String pincode;
  String country;
  String withdrawableBalance;
  String currentBalance;
  String cashInHand;
  String pendingWithdraw;
  String totalWithdraw;
  String totalEarn;
  String completedDelivery;
  String pendingDelivery;
  String totalDelivery;
  String pauseDelivery;
  String totalDeposit;
  String averageRating;

  Datum({
    required this.id,
    required this.sellerId,
    required this.fName,
    required this.lName,
    required this.address,
    required this.countryCode,
    required this.phone,
    required this.email,
    required this.identityNumber,
    required this.identityType,
    required this.identityImage,
    required this.image,
    required this.bankName,
    required this.branch,
    required this.accountNo,
    required this.holderName,
    required this.accountType,
    required this.micrCode,
    required this.bankAddress,
    required this.ifscCode,
    required this.isActive,
    required this.isOnline,
    required this.createdAt,
    required this.updatedAt,
    required this.vehicleType,
    required this.registerationNumber,
    required this.issueDate,
    required this.expirationDate,
    required this.policyNumber,
    required this.coverageDate,
    required this.vehicleImage,
    required this.licenseNumber,
    required this.licenseDoi,
    required this.licenseExpDate,
    required this.licenseState,
    required this.licenseImage,
    required this.city,
    required this.state,
    required this.pincode,
    required this.country,
    required this.withdrawableBalance,
    required this.currentBalance,
    required this.cashInHand,
    required this.pendingWithdraw,
    required this.totalWithdraw,
    required this.totalEarn,
    required this.completedDelivery,
    required this.pendingDelivery,
    required this.totalDelivery,
    required this.pauseDelivery,
    required this.totalDeposit,
    required this.averageRating,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        sellerId: json["seller_id"],
        fName: json["f_name"],
        lName: json["l_name"],
        address: json["address"],
        countryCode: json["country_code"],
        phone: json["phone"],
        email: json["email"],
        identityNumber: json["identity_number"],
        identityType: json["identity_type"],
        identityImage: json["identity_image"],
        image: json["image"],
        bankName: json["bank_name"],
        branch: json["branch"],
        accountNo: json["account_no"],
        holderName: json["holder_name"],
        accountType: json["account_type"],
        micrCode: json["micr_code"],
        bankAddress: json["bank_address"],
        ifscCode: json["ifsc_code"],
        isActive: json["is_active"],
        isOnline: json["is_online"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        vehicleType: json["vehicle_type"],
        registerationNumber: json["registeration_number"],
        issueDate: json["issue_date"],
        expirationDate: json["expiration_date"],
        policyNumber: json["policy_number"],
        coverageDate: json["coverage_date"],
        vehicleImage: json["vehicle_image"],
        licenseNumber: json["license_number"],
        licenseDoi: json["license_doi"],
        licenseExpDate: json["license_exp_date"],
        licenseState: json["license_state"],
        licenseImage: json["license_image"],
        city: json["city"],
        state: json["state"],
        pincode: json["pincode"],
        country: json["country"],
        withdrawableBalance: json["withdrawable_balance"],
        currentBalance: json["current_balance"],
        cashInHand: json["cash_in_hand"],
        pendingWithdraw: json["pending_withdraw"],
        totalWithdraw: json["total_withdraw"],
        totalEarn: json["total_earn"],
        completedDelivery: json["completed_delivery"],
        pendingDelivery: json["pending_delivery"],
        totalDelivery: json["total_delivery"],
        pauseDelivery: json["pause_delivery"],
        totalDeposit: json["total_deposit"],
        averageRating: json["average_rating"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "seller_id": sellerId,
        "f_name": fName,
        "l_name": lName,
        "address": address,
        "country_code": countryCode,
        "phone": phone,
        "email": email,
        "identity_number": identityNumber,
        "identity_type": identityType,
        "identity_image": identityImage,
        "image": image,
        "bank_name": bankName,
        "branch": branch,
        "account_no": accountNo,
        "holder_name": holderName,
        "account_type": accountType,
        "micr_code": micrCode,
        "bank_address": bankAddress,
        "ifsc_code": ifscCode,
        "is_active": isActive,
        "is_online": isOnline,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "vehicle_type": vehicleType,
        "registeration_number": registerationNumber,
        "issue_date": issueDate,
        "expiration_date": expirationDate,
        "policy_number": policyNumber,
        "coverage_date": coverageDate,
        "vehicle_image": vehicleImage,
        "license_number": licenseNumber,
        "license_doi": licenseDoi,
        "license_exp_date": licenseExpDate,
        "license_state": licenseState,
        "license_image": licenseImage,
        "city": city,
        "state": state,
        "pincode": pincode,
        "country": country,
        "withdrawable_balance": withdrawableBalance,
        "current_balance": currentBalance,
        "cash_in_hand": cashInHand,
        "pending_withdraw": pendingWithdraw,
        "total_withdraw": totalWithdraw,
        "total_earn": totalEarn,
        "completed_delivery": completedDelivery,
        "pending_delivery": pendingDelivery,
        "total_delivery": totalDelivery,
        "pause_delivery": pauseDelivery,
        "total_deposit": totalDeposit,
        "average_rating": averageRating,
      };
}
