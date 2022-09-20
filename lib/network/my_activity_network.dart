import 'package:basalon/modal/get_user_activity.dart';
import 'package:basalon/services/api_provider/api_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../blocs/application_bloc.dart';

class GetUserActivity {
  dynamic myActivity;

  // GetUserActivityEditDetails? myActivityEditPage;

  Future getUserActivity(bool sort, userID, BuildContext context) async {
    late final application =
        Provider.of<ApplicationBloc>(context, listen: false);
    try {
      final response =
          await ApiProvider.post(url: 'get_user_activities', body: {
        "user_id": "$userID",
        "listing_type": "all",
        "order": " ${sort ? 'ASC' : 'DESC'}",
        "orderby": "ID",
        "paged": "1",
      });
      print(response);
      print(
          'getUserActivity getUserActivity getUserActivity getUserActivity getUserActivity');
      print(userID);
      final result = MyActivity.fromJson(response['body']);
      myActivity = result.data;
      application.myActivity = result.data;
      print(result);
    } catch (e) {
      myActivity = null;

      print('my activity nhi chali!!!!!!');
      print(e);
    }
    return myActivity;
  }

  Future getUserEditActivityDetails(eventId, BuildContext context) async {
    Provider.of<ApplicationBloc>(context, listen: false);
    print(eventId);
    print('okokokok');
    print(eventId);
    try {
      final response =
          await ApiProvider.post(url: 'get_user_event_detail', body: {
        "id": "$eventId",
      });
      // print('response');
      // print(response);
      var apiResponse = Map<String, dynamic>.from(response['body']);
      print("kdjhaskjdbkjsa");
      print(apiResponse);
      print(apiResponse.runtimeType);
      print("9999");

      // result = GetUserActivityEditDetails.fromJson(apiResponse);
      // result =  Map<String, dynamic>.from(apiResponse['body']);
      // application.myActivityEditPage = result;
      print("debug888");
      print(eventId);
      print(apiResponse['body']);
      print("this is details");
      print(apiResponse);
      return apiResponse;
    } catch (e) {
      print('my activity nhi chali!!!!!! edit wali');
      print(e);
    }

    // if (rawData) {
    //   print("debug2");
    //   print(result);
    //   return result;
    // } else {
    //   print("debug3");
    //   return application.myActivityEditPage;
    // }
  }

  Future changeActivityStatus(eventId, status) async {
    print('okokokok');
    print(eventId);
    try {
      final response =
          await ApiProvider.post(url: 'change_event_status', body: {
        "event_id": "$eventId",
        "status": "$status",
      });
      print(
          'changeActivityStatus changeActivityStatus changeActivityStatus changeActivityStatus');
      print(response);
    } catch (e) {
      print('my activity STATUS nhi chali!!!!!! edit wali');
      print(e);
    }
  }
}
