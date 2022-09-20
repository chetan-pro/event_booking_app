// To parse this JSON data, do
//
//     final contact = contactFromJson(jsonString);

import 'dart:convert';

Contact contactFromJson(String str) => Contact.fromJson(json.decode(str));

String contactToJson(Contact data) => json.encode(data.toJson());

class Contact {
  Contact({
    this.success,
    this.data,
    this.error,
  });

  int? success;
  List<Datum>? data;
  dynamic error;

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
    success: json["success"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    error: json["error"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "error": error,
  };
}

class Datum {
  Datum({
    this.title,
    this.phone,
    this.email,
    this.address,
    this.mainTitle,
  });

  String? title;
  String? phone;
  String? email;
  String? address;
  String? mainTitle;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    title: json["title"] == null ? null : json["title"],
    phone: json["phone"] == null ? null : json["phone"],
    email: json["email"] == null ? null : json["email"],
    address: json["address"] == null ? null : json["address"],
    mainTitle: json["main_title"] == null ? null : json["main_title"],
  );

  Map<String, dynamic> toJson() => {
    "title": title == null ? null : title,
    "phone": phone == null ? null : phone,
    "email": email == null ? null : email,
    "address": address == null ? null : address,
    "main_title": mainTitle == null ? null : mainTitle,
  };
}
