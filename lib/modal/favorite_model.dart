// // To parse this JSON data, do
// //
// //     final favoriteEvents = favoriteEventsFromJson(jsonString);
//
// import 'dart:convert';
//
// FavoriteEvents favoriteEventsFromJson(String str) => FavoriteEvents.fromJson(json.decode(str));
//
// String favoriteEventsToJson(FavoriteEvents data) => json.encode(data.toJson());
//
// class FavoriteEvents {
//   FavoriteEvents({
//     this.success,
//     this.data,
//     this.error,
//   });
//
//   int? success;
//   List<Datum>? data;
//   dynamic error;
//
//   factory FavoriteEvents.fromJson(Map<String, dynamic> json) => FavoriteEvents(
//     success: json["success"],
//     data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
//     error: json["error"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "success": success,
//     "data": List<dynamic>.from(data!.map((x) => x.toJson())),
//     "error": error,
//   };
// }
//
// class Datum {
//   Datum({
//     this.eventId,
//     this.title,
//     this.startDate,
//     this.endDate,
//     this.address,
//     this.shareLink,
//   });
//
//   int? eventId;
//   String? title;
//   String? startDate;
//   String? endDate;
//   String? address;
//   String? shareLink;
//
//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//     eventId: json["event_id"],
//     title: json["title"],
//     startDate: json["start_date"],
//     endDate: json["end_date"],
//     address: json["address"],
//     shareLink: json["getPermlink"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "event_id": eventId,
//     "title": title,
//     "start_date": startDate,
//     "end_date": endDate,
//     "address": address,
//     "getPermlink": shareLink,
//   };
// }


// To parse this JSON data, do
//
//     final homeData = homeDataFromJson(jsonString);

import 'dart:convert';

FavoriteEvents favoriteEventsFromJson(String str) => FavoriteEvents.fromJson(json.decode(str));

String favoriteEventsToJson(FavoriteEvents data) => json.encode(data.toJson());

class FavoriteEvents {
  FavoriteEvents({
    this.success,
    this.data,
    this.error,
  });

  int? success;
  List<Datum>? data;
  dynamic error;

  factory FavoriteEvents.fromJson(Map<String, dynamic> json) => FavoriteEvents(
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
    this.eventId,
    this.title,
    this.startDate,
    this.endDate,
    this.address,
    this.getPermlink,
  });

  int? eventId;
  String? title;
  String? startDate;
  String? endDate;
  String? address;
  String? getPermlink;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    eventId: json["event_id"],
    title: json["title"],
    startDate: json["start_date"],
    endDate: json["end_date"],
    address: json["address"],
    getPermlink: json["getPermlink"],
  );

  Map<String, dynamic> toJson() => {
    "event_id": eventId,
    "title": title,
    "start_date": startDate,
    "end_date": endDate,
    "address": address,
    "getPermlink": getPermlink,
  };
}
