import 'dart:convert';

CountryModel countryModelFromJson(String str) =>
    CountryModel.fromJson(json.decode(str));

String countryModelToJson(CountryModel data) => json.encode(data.toJson());

class CountryModel {
  bool status;
  String message;
  List<DataCountry> data;

  CountryModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
        status: json["status"],
        message: json["message"],
        data: List<DataCountry>.from(
            json["data"].map((x) => DataCountry.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DataCountry {
  int id;
  String name;

  DataCountry({
    required this.id,
    required this.name,
  });

  factory DataCountry.fromJson(Map<String, dynamic> json) => DataCountry(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
