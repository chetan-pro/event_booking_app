// To parse this JSON data, do
//
//     final myOrders = myOrdersFromJson(jsonString);

import 'dart:convert';

MyOrders myOrdersFromJson(String str) => MyOrders.fromJson(json.decode(str));

String myOrdersToJson(MyOrders data) => json.encode(data.toJson());

class MyOrders {
  MyOrders({
    this.success,
    this.data,
    this.error,
  });

  int? success;
  List<Datum>? data;
  dynamic error;

  factory MyOrders.fromJson(Map<String, dynamic> json) => MyOrders(
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
    this.id,
    this.title,
    this.dateCal,
    this.totalAfterTax,
    this.ticketType,
    this.createdDate,
    this.status,
  });

  int? id;
  String? title;
  String? dateCal;
  String? totalAfterTax;
  String? ticketType;
  String? createdDate;
  String? status;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    title: json["title"],
    dateCal: json["date_cal"],
    totalAfterTax: json["total_after_tax"],
    ticketType: json["ticket_type"],
    createdDate: json["created_date"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "date_cal": dateCal,
    "total_after_tax": totalAfterTax,
    "ticket_type": ticketType,
    "created_date": createdDate,
    "status": status,
  };
}
