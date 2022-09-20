import 'dart:async';

import 'package:basalon/services/my_color.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;

String convertDate(startDate, endDate) {
  final startdate = DateFormat('dd-MMM').format(DateTime.parse(startDate));
  final enddate = DateFormat('dd-MMM').format(DateTime.parse(endDate));
  final date = "$startdate" "  -  " "$enddate";
  return date;
}

String convertSingleDate(date) {
  // return DateFormat('yyyy-MM-dd').format(DateTime.parse(date.toString()));
  return DateFormat('dd-MM-yyyy').format(DateTime.parse(date.toString()));
}

String convertDateFormat(date) {
  // return DateFormat('yyyy-MM-dd').format(DateTime.parse(date));
  return DateFormat('dd-MM-yyyy').format(DateTime.parse(date));
}

DateTime convertDateFromStringToDatetime(date) {
  // var result = DateFormat('yyyy/MM/dd').format(DateTime.parse(date));
  var result = DateFormat('dd-MM-yyyy').format(DateTime.parse(date));
  return DateTime.parse(result);
}

FutureOr<String> selectDate({BuildContext? context, bool isDob = true}) async {
  var date = DateTime.now();
  var lastdate = DateTime(date.year, date.month, date.day);
  var passportExplast = DateTime(date.year + 50, date.month, date.day);
  final DateTime? picked = await showDatePicker(
    textDirection:ui.TextDirection.rtl,
    locale:Locale("iw","IW"),
      builder: (context, child) {
        return Theme(
            data: ThemeData.from(
                colorScheme: ColorScheme(
              primary: MyColors.topOrange,
              primaryVariant: Colors.white,
              secondary: MyColors.topOrange,
              secondaryVariant: Colors.white,
              surface: Colors.white,
              background: Colors.white,
              error: Colors.red,
              onPrimary: Colors.white,
              onSecondary: Colors.white,
              onSurface: Colors.black,
              onBackground: Colors.amber,
              onError: Colors.amber,
              brightness: Theme.of(context).brightness,
            )),
            child: child!);
      },
      context: context!,
      initialDate: isDob ? lastdate : DateTime.now(),
      firstDate:DateTime.now(),
      lastDate: isDob ? DateTime(2100) : passportExplast);
  return picked.toString();
}
