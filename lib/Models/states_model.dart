// To parse this JSON data, do
//
//     final stateModel = stateModelFromJson(jsonString);

import 'dart:convert';

StateModel stateModelFromJson(String str) =>
    StateModel.fromJson(json.decode(str));

String stateModelToJson(StateModel data) => json.encode(data.toJson());

class StateModel {
  bool status;
  String message;
  List<DatuState> data;

  StateModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory StateModel.fromJson(Map<String, dynamic> json) => StateModel(
        status: json["status"],
        message: json["message"],
        data: List<DatuState>.from(
            json["data"].map((x) => DatuState.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DatuState {
  int id;
  String name;
  int countryId;
  String? fipsCode;
  String iso2;
  String latitude;
  String longitude;
  DateTime createdAt;
  DateTime updatedAt;
  int flag;
  String wikiDataId;

  DatuState({
    required this.id,
    required this.name,
    required this.countryId,
    required this.fipsCode,
    required this.iso2,
    required this.latitude,
    required this.longitude,
    required this.createdAt,
    required this.updatedAt,
    required this.flag,
    required this.wikiDataId,
  });

  factory DatuState.fromJson(Map<String, dynamic> json) => DatuState(
        id: json["id"],
        name: json["name"],
        countryId: json["country_id"] ?? "",
        fipsCode: json["fips_code"] ?? "",
        iso2: json["iso2"] ?? "",
        latitude: json["latitude"] ?? "",
        longitude: json["longitude"] ?? "",
        createdAt: DateTime.parse(json["created_at"] ?? ""),
        updatedAt: DateTime.parse(json["updated_at"] ?? ""),
        flag: json["flag"] ?? 0,
        wikiDataId: json["wikiDataId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "country_id": countryId,
        "fips_code": fipsCode,
        "iso2": iso2,
        "latitude": latitude,
        "longitude": longitude,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "flag": flag,
        "wikiDataId": wikiDataId,
      };
}

enum CountryCode { IN }

final countryCodeValues = EnumValues({"IN": CountryCode.IN});

enum Type { STATE, UNION_TERRITORY }

final typeValues =
    EnumValues({"state": Type.STATE, "Union territory": Type.UNION_TERRITORY});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
