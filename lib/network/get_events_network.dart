import 'package:basalon/main.dart';
import 'package:basalon/modal/event_category_model.dart';
import 'package:basalon/modal/get_event_detail_data.dart';
import 'package:basalon/modal/home_data.dart';
import 'package:basalon/screens/home_page.dart';
import 'package:basalon/services/api_provider/api_provider.dart';
import 'package:basalon/services/constant.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';

class FetchEventData {
  FetchEventData({
    this.id,
    this.filterByCategory,
    this.commentContent,
    this.rating,
    this.eventId,
    this.filterByTime,
  });

  final int? id;
  dynamic filterByCategory;
  dynamic filterByTime;

  String? eventId;
  dynamic rating;
  String? commentContent;

  var dio = Dio();
  List data = [];

  Welcome? eventData;
  List? cardData;
  FilterCategoryModel? filterCategoryModel;
  dynamic categoryData;
  Position? geoLoc;
  setLocation() async {
    geoLoc = await Geolocator.getCurrentPosition();

    // setState(() {

    // });

    return geoLoc;
  }

  Future getEventData(page, filterByCategory, filterByTime, filterByAnyWhere,
      mapLat, mapLng, keyword, startDate, endDate, BuildContext context) async {
    print(filterByAnyWhere);
    print("filterByAnyWhere");
    try {
      configLoading();
      //EasyLoading.show();
      final response = await ApiProvider.post(url: 'get_events', body: {
        "paged": "$page",
        "keyword": keyword != "" || keyword != null ? "$keyword" : "",
        "category": "${filterByCategory ?? ''}",
        "map_lat": (filterByAnyWhere == 'עיר מסויימת' ||
                filterByAnyWhere == 'בכל מקום' ||
                filterByAnyWhere == 'קרוב אליי')
            ? '$mapLat'
            : null,
        "map_lng": (filterByAnyWhere == 'עיר מסויימת' ||
                filterByAnyWhere == 'בכל מקום' ||
                filterByAnyWhere == 'קרוב אליי')
            ? '$mapLng'
            : null,
        "start_date": "$startDate",
        "end_date": "$endDate",
        "time":
            "${filterByTime == 'specific_date' ? "this_week" : filterByTime ?? " "}",
        // "sort": filterByAnyWhere == 'online'
        //     ? 'start-date'
        //     : (filterByAnyWhere == 'בכל מקום' || filterByCategory == 'אירוח קולינרי')
        //       ? 'start-date'
        //         : ((filterByAnyWhere == 'קרוב אליי' ||
        //                     filterByAnyWhere == 'עיר מסויימת') ||
        //                 mapLng != null)
        //             ? 'near'
        //             : '',
        "sort": (filterByAnyWhere == 'עיר מסויימת' ||
                filterByAnyWhere == 'קרוב אליי' ||
                application.filterAnywhereProvider == 'קרוב אליי')
            ? "near"
            : (filterByAnyWhere == 'בכל מקום')
                ? 'start-date'
                : '',
        "event_type": filterByAnyWhere == 'online' ? 'online' : 'classic',
        "el_data_taxonomy_custom[]": "",
        "show_featured": "",
      });
      print({
        "paged": "$page",
        "keyword": keyword != "" || keyword != null ? "$keyword" : "",
        "category": "${filterByCategory ?? ''}",
        "map_lat": (filterByAnyWhere == 'עיר מסויימת' ||
                filterByAnyWhere == 'בכל מקום' ||
                filterByAnyWhere == 'קרוב אליי')
            ? '$mapLat'
            : null,
        "map_lng": (filterByAnyWhere == 'עיר מסויימת' ||
                filterByAnyWhere == 'בכל מקום' ||
                filterByAnyWhere == 'קרוב אליי')
            ? '$mapLng'
            : null,
        "start_date": "$startDate",
        "end_date": "$endDate",
        "time":
            "${filterByTime == 'specific_date' ? "this_week" : filterByTime ?? " "}",
        // "sort": filterByAnyWhere == 'online'
        //     ? 'start-date'
        //     : (filterByAnyWhere == 'בכל מקום' || filterByCategory == 'אירוח קולינרי')
        //       ? 'start-date'
        //         : ((filterByAnyWhere == 'קרוב אליי' ||
        //                     filterByAnyWhere == 'עיר מסויימת') ||
        //                 mapLng != null)
        //             ? 'near'
        //             : '',
        "sort": (filterByAnyWhere == 'עיר מסויימת' ||
                filterByAnyWhere == 'קרוב אליי' ||
                application.filterAnywhereProvider == 'קרוב אליי')
            ? "near"
            : (filterByAnyWhere == 'בכל מקום')
                ? 'start-date'
                : '',
        "event_type": filterByAnyWhere == 'online' ? 'online' : 'classic',
        "el_data_taxonomy_custom[]": "",
        "show_featured": "",
      });
      //print("dklsxjkl");
      //print(application.filterAnywhereProvider);
      ////print(filterByAnyWhere);
      //print(filterByTime);

      //print(mapLat);

      final result = HomeData.fromJson(response['body']);

      //print('uiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii');
      //print(result);
      //print(filterByCategory);
      //print(filterByAnyWhere);
      //print(mapLat);
      //print(response['status']);

      //print("ajb");
      if (response['status'] == 401) {
        //print("snbdj1");
        return errorAlertMessage('no event found', '', context);
      } else {
        //print("snbdj2");
        print("chetan check page");
        print(page);
        if (page > 1) {
          //print("snbdj3");
          data = [...data, ...?result.data];
          //print("snbdj4");
          //print("result.,data");
          //print("snbdj5");
          //print(result.data);
          //print("snbdj6");
        } else {
          //print("snbdj7");
          data = result.data!;
          //print(data);
          //print("snbdj8");
        }
        EasyLoading.dismiss();
      }
    } catch (e) {
      EasyLoading.dismiss();

      //print('homepage events nhi aaye ERROR!${e}');
      //print("snbdj9");
      //print(keyword);
      if (keyword != null && keyword != '') {
        data = [];
        //print("snbdj10");
      }
      //print("snbdj11");
      data = [];
      //print("snbdj12");
    }
    //print("snbdj13");
    //print(data);

    return data;
  }

  Future getEventDetailData() async {
    try {
      final response =
          await ApiProvider.post(url: 'get_event_detail', body: {"id": "$id"});
      final result = Welcome.fromJson(response['body']);
      //print('resultlkjlkjlkjlkjlkjlk');

      //print('${result.data?.gallery}');
      eventData = result;
      //print(eventData?.data?.noOfTicket?[0].priceTicket);
      // cardData = eventData?.data?.relatedEvent;
    } catch (e) {
      //print(e);
    }
    return eventData;
  }

  Future getEventCategories() async {
    try {
      final response = await ApiProvider.get('get_event_category');
      final result = FilterCategoryModel.fromJson(response['body']);

      filterCategoryModel = result;
      //print('ye chaliu category');
      //print(filterCategoryModel?.data);
    } catch (e) {
      //print('nhi chli categories');
      //print(e);
    }
    return filterCategoryModel;
  }

  Future postFeedbackEventDetails(context, userId,
      {content, rating, eventId}) async {
    try {
      await ApiProvider.post(url: 'add_comment', body: {
        'user_id': '$userId',
        'event_id': '$eventId',
        'rating': '$rating',
        'comment_content': '$commentContent',
      });
      //print(response);
      errorAlertMessage('Waiting for approval', '', context);
    } catch (e) {
      //print('postFeedbackEventDetails nhi chala sasura');
      //print(e);
    }
  }

  Future sendEmailToAuthor(
    context,
    eventId,
    name,
    email,
    phone,
    subject,
    content,
  ) async {
    try {
      await ApiProvider.post(url: 'email_send_to_author', body: {
        'event_id': '$eventId',
        'name_customer': '$name',
        'email_customer': '$email',
        'phone_customer': '$phone',
        'subject_customer': '$subject',
        'content': '$content',
      });
      //print(response);
      errorAlertMessage('Mail Sent Successfully!', '', context);
    } catch (e) {
      //print('postFeedbackEventDetails nhi chala sasura');
      //print(e);
    }
  }

  void errorAlertMessage(
      String errorMessage, String titleMessage, BuildContext context) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        contentPadding: EdgeInsets.zero,
        title: Center(child: Text(titleMessage)),
        content: Text(
          errorMessage,
          textAlign: TextAlign.center,
          style: ktextStyleBoldMedium,
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomePage())),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
//
// import 'package:basalon/modal/event_category_model.dart';
// import 'package:basalon/modal/get_event_detail_data.dart';
// import 'package:basalon/modal/home_data.dart';
// import 'package:basalon/services/api_provider/api_provider.dart';
// import 'package:dio/dio.dart';
//
// class FetchEventData {
//   FetchEventData({
//     this.id,
//     this.filterByCategory,
//     this.commentContent,
//     this.rating,
//     this.eventId,
//   });
//
//   final int? id;
//   dynamic filterByCategory;
//
//   String? eventId;
//   dynamic rating;
//   String? commentContent;
//
//   var dio = Dio();
//   List data = [];
//
//   Welcome? eventData;
//   List? cardData;
//   FilterCategoryModel? filterCategoryModel;
//
//   Future getEventData(page, filterByCategory, filterByTime, filterByAnyWhere,
//       mapLat, mapLng, keyword, startDate, endDate) async {
//     try {
//       final response = await ApiProvider.post(url: 'get_events', body: {
//         "paged": "$page",
//         "category": "${filterByCategory ?? ""}",
//         "time": "${filterByTime ?? "this_week"}",
//         "event_type": filterByAnyWhere == 'online' ? 'online' : 'classic',
//         "sort": (filterByAnyWhere == 'online' || filterByAnyWhere == 'classic')
//             ? 'start-date'
//             : filterByAnyWhere == 'קרוב אליי'
//             ? 'near'
//             : 'near',
//         "map_lat": "$mapLat",
//         "map_lng": "$mapLng",
//         "keyword": "$keyword",
//         "start_date": "$startDate",
//         "end_date": "$endDate",
//       });
//
//       final result = HomeData.fromJson(response['body']);
//      //print('uiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii');
//      //print(filterByAnyWhere);
//
//       if (page > 1) {
//         data = [...data, ...?result.data];
//       } else {
//         data = result.data!;
//       }
//     } catch (e) {
//      //print('homepage events nhi aaye ERROR!${e}');
//       if (keyword != null && keyword != '') {
//         data = [];
//       }
//     }
//     return data;
//   }
//
//   Future getEventDetailData() async {
//     try {
//       final response =
//       await ApiProvider.post(url: 'get_event_detail', body: {"id": "$id"});
//       final result = Welcome.fromJson(response['body']);
//       ////print('resultlkjlkjlkjlkjlkjlk');
//
//       ////print('${result.toJson()}');
//       eventData = result;
//       // cardData = eventData?.data?.relatedEvent;
//     } catch (e) {
//      //print(e);
//      //print(
//           '${eventData}hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh');
//     }
//     return eventData;
//   }
//
//   Future getEventCategories() async {
//     try {
//       final response = await ApiProvider.get('get_event_category');
//       final result = FilterCategoryModel.fromJson(response['body']);
//
//       filterCategoryModel = result;
//      //print('ye chaliu category');
//      //print(filterCategoryModel?.data);
//     } catch (e) {
//      //print('nhi chli categories');
//      //print(e);
//     }
//     return filterCategoryModel;
//   }
//
//   Future postFeedbackEventDetails() async {
//     try {
//       final response = await ApiProvider.post(url: 'add_comment', body: {
//         'event_id': '$eventId',
//         'rating': '$rating',
//         'comment_content': '$commentContent',
//       });
//      //print(
//           'postFeedbackEventDetails postFeedbackEventDetails postFeedbackEventDetails postFeedbackEventDetails');
//      //print(response);
//     } catch (e) {
//      //print('postFeedbackEventDetails nhi chala sasura');
//      //print(e);
//     }
//   }
// }
