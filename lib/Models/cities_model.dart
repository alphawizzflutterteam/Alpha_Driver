// To parse this JSON data, do
//
//     final citiesModel = citiesModelFromJson(jsonString);

import 'dart:convert';

CitiesModel citiesModelFromJson(String str) => CitiesModel.fromJson(json.decode(str));

String citiesModelToJson(CitiesModel data) => json.encode(data.toJson());

class CitiesModel {
  bool status;
  String message;
  List<Datuc> data;

  CitiesModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CitiesModel.fromJson(Map<String, dynamic> json) => CitiesModel(
    status: json["status"],
    message: json["message"],
    data: List<Datuc>.from(json["data"].map((x) => Datuc.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datuc {
  int id;
  String name;
  int stateId;
  int countryId;
  String latitude;
  String longitude;
  DateTime createdAt;
  DateTime updatedAt;
  int flag;
  String wikiDataId;

  Datuc({
    required this.id,
    required this.name,
    required this.stateId,
    required this.countryId,
    required this.latitude,
    required this.longitude,
    required this.createdAt,
    required this.updatedAt,
    required this.flag,
    required this.wikiDataId,
  });

  factory Datuc.fromJson(Map<String, dynamic> json) => Datuc(
    id: json["id"],
    name: json["name"],
    stateId: json["state_id"],
    countryId: json["country_id"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    flag: json["flag"],
    wikiDataId: json["wikiDataId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "state_id": stateId,
    "country_id": countryId,
    "latitude": latitude,
    "longitude": longitude,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "flag": flag,
    "wikiDataId": wikiDataId,
  };
}

enum CountryCode {
  IN
}

final countryCodeValues = EnumValues({
  "IN": CountryCode.IN
});

enum StateCode {
  MP
}

final stateCodeValues = EnumValues({
  "MP": StateCode.MP
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
