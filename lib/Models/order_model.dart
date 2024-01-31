// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class Datuo {
  int orderId;
  int totalDelivery;
  String order_status;
  String payment_status;
  String expected_delivery_date;

  String customerName;
  ShipingModel shippingAddress;

  Datuo(
      this.orderId,
      this.totalDelivery,
      this.order_status,
      this.payment_status,
      this.expected_delivery_date,
      this.customerName,
      this.shippingAddress);
}

class ShipingModel {
  String id;
  String customerId;
  String contactPersonName;
  String addressType;
  String address;
  String address1;
  String city;
  String zip;
  String phone;
  String altPhone;
  String createdAt;
  String updatedAt;
  String state;
  String country;
  String latitude;
  String longitude;
  String isBilling;

  ShipingModel(
      this.id,
      this.customerId,
      this.contactPersonName,
      this.addressType,
      this.address,
      this.address1,
      this.city,
      this.zip,
      this.phone,
      this.altPhone,
      this.createdAt,
      this.updatedAt,
      this.state,
      this.country,
      this.latitude,
      this.longitude,
      this.isBilling);
}
