import 'dart:convert';
import 'package:basalon/modal/login_data.dart';
import 'package:basalon/services/api_provider/api_provider.dart';
import 'package:basalon/services/constant.dart';
import 'package:dio/dio.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../blocs/application_bloc.dart';
import '../constant/login_user.dart';
import '../screens/home_screen.dart';
import '../utils/utils.dart';

class LoginRegisterNetwork {
  Map? userData;
  LoginData? getLoginData;
  String? emailController;
  String? passwordController;

  LoginRegisterNetwork({this.emailController, this.passwordController});

  getUserLoginData(BuildContext context) async {
    late final application =
        Provider.of<ApplicationBloc>(context, listen: false);
    try {
      final response = await ApiProvider.post(
        url: 'user_login',
        body: {'email_id': emailController, 'password': passwordController},
      );
      print('sign in chala');
      print(response);

      EasyLoading.dismiss();
      if (response['body']['success'] == 401) {
        errorAlertMessage('Invalid Credential!', context);
        isUserLogin(false);
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.remove('email');
      } else {
        print('ye wala login chala');
        getLoginData = LoginData.fromJson(response['body']);

        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setInt('loginId', getLoginData!.data.id!);
        isUserLogin(true);
        LoginUser(
          userName: getLoginData!.data.name!,
          email: getLoginData!.data.userEmail!,
          userId: getLoginData!.data.id!,
        );
        LoginUser.shared?.userId = sharedPreferences.getInt('loginId');
        // LoginUser.shared?.userId = sharedPreferences.getInt(loginId);
        print('pppppppppppppppppppppppppppppppppppppppppppp');
        application.isUserLogin = true;
        print(sharedPreferences.getInt('loginId'));
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => HomeScreen()),
            (Route<dynamic> route) => false);
      }
    } catch (e) {
      print("sajkhdjs");
      print(e);
      EasyLoading.dismiss();
      errorAlertMessage('Something went wrong!', context);
    }
  }

  registerFbData(accessToken, userID) async {
    try {
      final response =
          await ApiProvider.post(url: 'fb_user_registration', body: {
        "accessToken": {
          jsonEncode("access_token"): jsonEncode("$accessToken"),
          jsonEncode("token_type"): jsonEncode("bearer"),
          jsonEncode("expires_in"): jsonEncode(5183998),
          jsonEncode("created"): jsonEncode(userID)
        }.toString().replaceAll(' ', '')
      });
      print('fb register hua kya ojojojoj');
      print(jsonEncode(accessToken));
      print("dsajdjkaskjj");
      print(response);
      print("ky aayee id");
      print(response);
      print(LoginUser.shared?.userId);
      print(sendUserId(response));
      // print(response['body']['data']['user_id']);
      print('thk haisd');
      var id = await sendUserId(response);
      print(id.runtimeType);
      print('thk haia');
      print(id);
      print('thk haiadj');
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      sharedPreferences.setInt('loginId', id);
      LoginUser.shared?.userId = sharedPreferences.getInt('loginId');
    } catch (e) {
      print('nhi hua fb register');
      print(e);
    }
  }

  registerAppleData(accessToken, userID) async {
    try {
      return await ApiProvider.post(
          url: 'ios_user_registration',
          body: {"social_access_token": accessToken, "social_id": userID});
    } catch (e) {
      print('nhi hua fb register');
      print(e);
    }
  }

  sendUserId(response) async {
    if (response['body']['data'].runtimeType == int) {
      return response['body']['data'];
    } else if (response['body']['data'].runtimeType == String) {
      return int.parse(response['body']['data']);
    } else {
      return response['body']['data']['user_id'];
    }
  }

  forgotPassword(email, BuildContext context) async {
    try {
      final response = await ApiProvider.post(url: 'forgot_password', body: {
        "email_id": "$email",
      });

      print('forgotPassword forgotPassword forgotPassword');
      print(response);
    } catch (e) {
      print('nhi hua forgotPassword forgotPassword forgotPassword');
      print(e);
    }
  }

  void errorAlertMessage(String errorMessage, BuildContext context) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: Text(errorMessage),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
// body: {
// "accessToken": {
// jsonEncode("access_token"):
// "${jsonEncode(accessToken)},${jsonEncode("token_type")}:${jsonEncode("bearer")},${jsonEncode("expires_in")}:${jsonEncode("5183998")},${jsonEncode("created")}:${jsonEncode("$userID")}"
// }
// },

deleteUser({dataId}) async {
  // print(object)
  var dio = Dio();
  var dataDe = {
    "user_id": dataId,
  };

  print('usidddddddddddddddddd');
  print(dataId);

  FormData formData = FormData.fromMap(dataDe);

  try {
    var response = await dio.post(
      'https://basalon.co.il/wp-json/wp/v2/delete_user_account',
      data: formData,
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
        headers: {
          "Client-Service": client_service,
          "Auth-Key": auth_key,
        },
      ),
    );

    if (response.statusCode == 200) {
      print('user Succesullyssssssss ');
    } else {
      print('not founddddddddddddddddddd');
    }
  } catch (e) {
    print(e);
    print('eroorrrrrrrrrrrrr');
    // Get.snackbar('title', 'message');
  }
}
