import 'package:basalon/modal/package_model.dart';
import 'package:basalon/screens/home_screen.dart';
import 'package:basalon/services/api_provider/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import '../blocs/application_bloc.dart';

class PackageNetwork {
  PackageModel? packageModel;

  Future getPackage(userID, context) async {
    late final application =
        Provider.of<ApplicationBloc>(context, listen: false);

    try {
      final response =
          await ApiProvider.get('get_user_packages?user_id=$userID');
      print('package chal gi 1');
      final result = PackageModel.fromJson(response['body']);
      print('package chal gi 2');
      packageModel = result;
      application.packageModel = result;
      print('package chal gi');
      print(userID);
      print(response);
      print(packageModel?.data?.userActivePackage?.iD);
    } catch (e) {
      print('package nhiiiiiiiiiiii chal gi');
      print(userID.runtimeType);

      print(e);
    }
    return packageModel;
  }

  Future renewPackage(userId, BuildContext context, packageId) async {
    try {
      final response = await ApiProvider.post(url: 'register_package', body: {
        "user_id": "$userId",
        "package_id": "$packageId",
      });

      print('package registed !!!!!!');
      print(packageId);
      print(response);
      EasyLoading.dismiss();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    } catch (e) {
      print('nhi hua package registed !!!!!!!!!!!!!!!1');
      print(e);
    }
  }
}
