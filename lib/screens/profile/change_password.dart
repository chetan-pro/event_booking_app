import 'package:basalon/network/get_update_profile_network.dart';
import 'package:basalon/screens/activity/receiving_activity_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import '../../blocs/application_bloc.dart';
import '../../constant/login_user.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  late double width = MediaQuery.of(context).size.width;
  UpdateAndGetUserProfile _updateAndGetUserProfile = UpdateAndGetUserProfile();
  late final application = Provider.of<ApplicationBloc>(context, listen: false);
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void validate() async {
    if (formKey.currentState!.validate()) {
      print('VALIDATED');

      if (newPasswordController.text == confirmPasswordController.text) {
        //EasyLoading.show();
        await _updateAndGetUserProfile.updatePassword(
          LoginUser.shared?.userId ?? application.idFromLocalProvider,
          oldPasswordController.text,
          newPasswordController.text,
          confirmPasswordController.text,
          context,
        );
      } else {
        errorAlertMessage('errorMessage', 'Password not match', context);
      }
    } else {
      print('Not Valid');
    }
  }

  void errorAlertMessage(
      String errorMessage, String titleMessage, BuildContext context) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Center(child: Text(titleMessage)),
        content: Text(
          errorMessage,
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 100),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text('סיסמה ישנה'),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 80,
                      child: ReceivingPaymentFields(
                        controller: oldPasswordController,
                        obscureText: true,
                        maxLine: 1,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text('סיסמה חדשה'),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 80,
                      child: ReceivingPaymentFields(
                        controller: newPasswordController,
                        obscureText: true,
                        label: 'New Password',
                        maxLine: 1,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text('הכניסו שוב סיסמה חדשה'),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 80,
                      child: ReceivingPaymentFields(
                        controller: confirmPasswordController,
                        obscureText: true,
                        maxLine: 1,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              GestureDetector(
                onTap: () {
                  validate();
                },
                child: Container(
                  height: 80,
                  width: width / 2,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color.fromRGBO(112, 168, 49, 1)),
                  child: const Center(
                      child: Text(
                    'עדכון סיסמה',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
