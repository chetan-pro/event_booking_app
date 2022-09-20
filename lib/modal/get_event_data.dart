// import 'dart:convert';
//
// import 'package:basalon/modal/home_data.dart';
// import 'package:http/http.dart' as http;
//
// class GetEvent {
//   List<Datum> getEvent = [];
//
//   Future getGetEventDataAPI() async {
//     String url = 'https://basalon.co.il/wp-json/wp/v2/get_events';
//
//     var response = await http.get(Uri.parse(url));
//     getEvent = HomeData.fromJson(jsonDecode(response.body)).data!;
//     for (var data in getEvent) {}
//   }
// }
