// To parse this JSON data, do
//
//     final mongodbModule = mongodbModuleFromJson(jsonString);

import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

MongodbModule mongodbModuleFromJson(String str) => MongodbModule.fromJson(json.decode(str));

String mongodbModuleToJson(MongodbModule data) => json.encode(data.toJson());

class MongodbModule {
  ObjectId id;
  String name;
  String email;
  String password;
  String photo;
  String phone;
  DateTime createdAt;
  DateTime updatedAt;
  String catagory;
  String latitude;
  String longitude;
  String lastupdatetime;

  MongodbModule({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.photo,
    required this.phone,
    required this.createdAt,
    required this.updatedAt,
    required this.catagory,
    required this.latitude,
    required this.longitude,
    required this.lastupdatetime,
  });

  factory MongodbModule.fromJson(Map<String, dynamic> json) => MongodbModule(
    id: json["_id"],
    name: json["name"],
    email: json["email"],
    password: json["password"],
    photo: json["photo"],
    phone: json["phone"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    catagory: json["catagory"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    lastupdatetime: json["lastupdatetime"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "email": email,
    "password": password,
    "photo": photo,
    "phone": phone,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "catagory": catagory,
    "latitude": latitude,
    "longitude": longitude,
    "lastupdatetime": lastupdatetime,
  };
}