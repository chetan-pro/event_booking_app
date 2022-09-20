// To parse this JSON data, do
//
//     final reportModel = reportModelFromJson(jsonString);

import 'dart:convert';

ReportModel reportModelFromJson(String str) => ReportModel.fromJson(json.decode(str));

String reportModelToJson(ReportModel data) => json.encode(data.toJson());

class ReportModel {
  ReportModel({
    this.success,
    this.data,
    this.error,
  });

  int? success;
  Data? data;
  dynamic error;

  factory ReportModel.fromJson(Map<String, dynamic> json) => ReportModel(
    success: json["success"],
    data: Data.fromJson(json["data"]),
    error: json["error"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
    "error": error,
  };
}

class Data {
  Data({
    this.membershipReport,
    this.chart,
  });

  MembershipReport? membershipReport;
  Chart? chart;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    membershipReport: MembershipReport.fromJson(json["membership_report"]),
    chart: Chart.fromJson(json["chart"]),
  );

  Map<String, dynamic> toJson() => {
    "membership_report": membershipReport?.toJson(),
    "chart": chart?.toJson(),
  };
}

class Chart {
  Chart({
    this.chart,
    this.nameMonth,
    this.currencyPosition,
    this.currency,
    this.chartGroupby,
    this.chartColor,
    this.timeformat,
    this.monthnames,
  });

  String? chart;
  Map<String, String>? nameMonth;
  String? currencyPosition;
  String? currency;
  String? chartGroupby;
  String? chartColor;
  String? timeformat;
  String? monthnames;

  factory Chart.fromJson(Map<String, dynamic> json) => Chart(
    chart: json["chart"],
    nameMonth: Map.from(json["name_month"]).map((k, v) => MapEntry<String, String>(k, v)),
    currencyPosition: json["currency_position"],
    currency: json["currency"],
    chartGroupby: json["chart_groupby"],
    chartColor: json["chart_color"],
    timeformat: json["timeformat"],
    monthnames: json["monthnames"],
  );

  Map<String, dynamic> toJson() => {
    "chart": chart,
    "name_month": Map.from(nameMonth!).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "currency_position": currencyPosition,
    "currency": currency,
    "chart_groupby": chartGroupby,
    "chart_color": chartColor,
    "timeformat": timeformat,
    "monthnames": monthnames,
  };
}

class MembershipReport {
  MembershipReport({
    this.status,
    this.expirationDate,
    this.remainingEvents,
    this.postedEvents,
  });

  String? status;
  String? expirationDate;
  String? remainingEvents;
  int? postedEvents;

  factory MembershipReport.fromJson(Map<String, dynamic> json) => MembershipReport(
    status: json["status"],
    expirationDate: json["expiration_date"],
    remainingEvents: json["remaining_events"],
    postedEvents: json["posted_events"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "expiration_date": expirationDate,
    "remaining_events": remainingEvents,
    "posted_events": postedEvents,
  };
}
