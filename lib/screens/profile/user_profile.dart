import 'dart:io';

import 'package:basalon/constant/login_user.dart';
import 'package:basalon/facebookLoginController/facebook_login_controller.dart';
import 'package:basalon/modal/get_user_data.dart';
import 'package:basalon/network/get_update_profile_network.dart';
import 'package:basalon/widgets/file_picker_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import '../../blocs/application_bloc.dart';
import '../home_screen.dart';
import 'change_password.dart';

class UserProfile extends StatefulWidget {
  UserProfile({Key? key, this.getUserData}) : super(key: key);
  GetUserData? getUserData;

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  // SignInScreen signInScreen = SignInScreen();
  final UpdateAndGetUserProfile _updateAndGetUserProfile =
      UpdateAndGetUserProfile();

  late final application = Provider.of<ApplicationBloc>(context, listen: false);
  bool isRemoveDp = false;

  void errorAlertMessage(String errorMessage, String titleMessage) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(titleMessage),
        content: Text(errorMessage),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  GetUserData? getUserData;

  int currentIndex = 3;
  late double width = MediaQuery.of(context).size.width;
  File? imgfile;
  String? imgData;

  final emailController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneNoController = TextEditingController();
  final descriptionController = TextEditingController();
  final userNameController = TextEditingController();
  TextEditingController holderController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();
  TextEditingController branchController = TextEditingController();

  final UpdateAndGetUserProfile _userProfile = UpdateAndGetUserProfile();

  @override
  void initState() {
    super.initState();
    fillDetail();
    print("jbdcxxnzc,ndk");
    print(LoginUser.shared?.userId);
    // //EasyLoading.show();
    // getProfileData();
    // _updateAndGetUserProfile.getProfileData(
    //     LoginUser.shared?.userId! ?? application.idFromLocalProvider);
  }

  fillDetail() {
    emailController.text =
        application.getUserDataProfileProvider?.data?.authorEmail ?? '';

    firstNameController.text =
        application.getUserDataProfileProvider?.data?.firstName ??
            application.nameFromFacebook ??
            '';

    lastNameController.text =
        application.getUserDataProfileProvider?.data?.lastName ??
            application.nameFromFacebook ??
            '';

    phoneNoController.text =
        application.getUserDataProfileProvider?.data?.userPhone ??
            application.nameFromFacebook ??
            '';
    descriptionController.text =
        application.getUserDataProfileProvider?.data?.description ??
            application.nameFromFacebook ??
            '';
    // updatedImage = _updateAndGetUserProfile.getUserData?.data?.authorImage;
    holderController.text =
        application.getUserDataProfileProvider?.data?.userBankOwner ??
            application.nameFromFacebook ??
            '';
    numberController.text =
        application.getUserDataProfileProvider?.data?.userBankNumber ??
            application.nameFromFacebook ??
            '';
    bankNameController.text =
        application.getUserDataProfileProvider?.data?.userBankName ??
            application.nameFromFacebook ??
            '';
    branchController.text =
        application.getUserDataProfileProvider?.data?.userBankBranch ??
            application.nameFromFacebook ??
            '';
    setState(() {});
  }

  Widget profileUser(FacebookSignInController model) {
    print(
        'application.getUserDataProfileProvider?.data?.authorImage?.isNotEmpty');
    print(application.getUserDataProfileProvider?.data?.authorImage);
    print(application.imageFromFacebook);
    return Consumer(
      builder: (context, model, child) {
        return Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 100, right: 10, left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(height: 25),
                  ClipOval(
                    child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(80),
                        ),
                        child: imgfile != null
                            ? Image.file(
                                imgfile!,
                                height: 150,
                                width: 150,
                                fit: BoxFit.contain,
                              )
                            : Image.network(
                                (application.getUserDataProfileProvider?.data?.authorImage !=
                                            '' &&
                                        application.getUserDataProfileProvider
                                                ?.data?.authorImage !=
                                            null)
                                    ? application.getUserDataProfileProvider
                                        ?.data?.authorImage
                                    : application.imageFromFacebook ??
                                        'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png',
                                fit: BoxFit.fill,
                              )),
                  ),
                  const SizedBox(height: 25),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {
                            setState(() {
                              imgData = null;
                              application.getUserDataProfileProvider?.data
                                  ?.authorImage = '';
                              isRemoveDp = true;
                              setState(() {});
                            });
                          },
                          child: const Text(
                            'הסרת תמונה',
                            style: TextStyle(color: Colors.red),
                          )),
                      GestureDetector(
                        onTap: () async {
                          var fileList =
                              await pickPicture(context: context).then((value) {
                            if (value.isNotEmpty) {
                              setState(() {
                                imgfile = value[0];
                                imgData = value[1];
                              });
                            }
                          });
                        },
                        child: Container(
                          height: 50,
                          width: width / 3,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: const Color.fromRGBO(112, 168, 49, 1)),
                          child: const Center(
                              child: Text(
                            'הוספת תמונה',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          )),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // const Text('גודל מומלץ 400x400 פיקסלים',
                  //     style: TextStyle(fontSize: 18)),
                  // const SizedBox(height: 15),
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.end,
                  //   children: [
                  //     const Text('Username'),
                  //     const SizedBox(height: 10),
                  //     Container(
                  //       decoration: BoxDecoration(
                  //           borderRadius:
                  //               const BorderRadius.all(Radius.circular(5)),
                  //           border: Border.all(
                  //               color: const Color.fromRGBO(216, 216, 216, 1))),
                  //       child: TextField(
                  //           controller: userNameController,
                  //           maxLines: 1,
                  //           textAlignVertical: TextAlignVertical.top,
                  //           textAlign: TextAlign.end,
                  //           style: const TextStyle(fontSize: 15),
                  //           decoration: const InputDecoration(
                  //             border: InputBorder.none,
                  //             contentPadding:
                  //                 EdgeInsets.only(left: 10, right: 10),
                  //             hintText:
                  //                 // getUserData != null
                  //                 //     ? getUserData!.data.authorEmail
                  //                 // getUserData != null
                  //                 //     ? getUserData!.data.authorEmail
                  //                 //     : application.emailFromFacebook ??
                  //                 'שֵׁם',
                  //           )),
                  //     ),
                  //   ],
                  // ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text('שם פרטי'),
                      const SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                            border: Border.all(
                                color: const Color.fromRGBO(216, 216, 216, 1))),
                        child: TextField(
                            maxLines: 1,
                            controller: firstNameController,
                            textAlignVertical: TextAlignVertical.top,
                            textAlign: TextAlign.end,
                            style: TextStyle(fontSize: 15),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding:
                                  EdgeInsets.only(left: 10, right: 10),
                              hintText:
                                  // getUserData != null
                                  //     ? getUserData!.data.displayName
                                  //     : application.nameFromFacebook ??
                                  'שֵׁם',
                            )),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text('שם משפחה'),
                      const SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                            border: Border.all(
                                color: const Color.fromRGBO(216, 216, 216, 1))),
                        child: TextField(
                            maxLines: 1,
                            controller: lastNameController,
                            textAlignVertical: TextAlignVertical.top,
                            textAlign: TextAlign.end,
                            style: const TextStyle(fontSize: 15),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding:
                                  EdgeInsets.only(left: 10, right: 10),
                              hintText:
                                  // getUserData != null
                                  //     ? getUserData!.data.displayName
                                  //     : application.nameFromFacebook ??
                                  'שֵׁם',
                            )),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text('אימייל'),
                      const SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                            border: Border.all(
                                color: const Color.fromRGBO(216, 216, 216, 1))),
                        child: TextField(
                            maxLines: 1,
                            controller: emailController,
                            textAlignVertical: TextAlignVertical.top,
                            textAlign: TextAlign.end,
                            style: const TextStyle(fontSize: 15),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding:
                                  EdgeInsets.only(left: 10, right: 10),
                              hintText:
                                  // getUserData != null
                                  //     ? getUserData!.data.authorEmail
                                  //     : application.emailFromFacebook ??
                                  'שֵׁם',
                            )),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text('טלפון נייד'),
                      const SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                            border: Border.all(
                                color: const Color.fromRGBO(216, 216, 216, 1))),
                        child: TextField(
                            maxLines: 1,
                            controller: phoneNoController,
                            textAlignVertical: TextAlignVertical.top,
                            textAlign: TextAlign.end,
                            style: const TextStyle(fontSize: 15),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding:
                                  EdgeInsets.only(left: 10, right: 10),
                              hintText:
                                  // getUserData != null
                                  //     ? getUserData!.data.userPhone
                                  //     :
                                  'שֵׁם',
                            )),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text('ספרו על עצמכם'),
                      const SizedBox(height: 10),
                      Container(
                        height: 170,
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                            border: Border.all(
                                color: const Color.fromRGBO(216, 216, 216, 1))),
                        child: TextField(
                            maxLines: 10,
                            controller: descriptionController,
                            textAlignVertical: TextAlignVertical.top,
                            textAlign: TextAlign.end,
                            style: const TextStyle(fontSize: 15),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              hintText:
                                  // getUserData != null
                                  //     ? getUserData!.data.description
                                  //     :
                                  'שֵׁם',
                            )),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  GestureDetector(
                    onTap: () async {
                      //EasyLoading.show();
                      // getUpdateUserData();
                      await _updateAndGetUserProfile.getUpdateUserData(
                          LoginUser.shared?.userId! ??
                              application.idFromLocalProvider,
                          firstNameController.text,
                          lastNameController.text,
                          emailController.text,
                          phoneNoController.text,
                          descriptionController.text,
                          imgfile?.path,
                          imgData,
                          context,
                          isRemoveDp);
                      await _updateAndGetUserProfile.getProfileData(
                          LoginUser.shared?.userId! ??
                              application.idFromLocalProvider,
                          context: context);
                    },
                    child: Container(
                      height: 80,
                      width: width / 2,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: const Color.fromRGBO(112, 168, 49, 1)),
                      child: const Center(
                          child: Text(
                        'עדכון פרופיל',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget userBankDetail() {
    print('-----------------------');
    print(LoginUser.shared?.userId);
    print(MediaQuery.of(context).size.height);
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            children: [
              const SizedBox(height: 25),
              const Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: Text('פרטי חשבון הבנק',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text('* שם בעל החשבון'),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                          border: Border.all(
                              color: const Color.fromRGBO(216, 216, 216, 1))),
                      child: TextField(
                          scrollPadding: EdgeInsets.only(bottom: 40),
                          controller: holderController,
                          maxLines: 1,
                          textAlignVertical: TextAlignVertical.top,
                          textAlign: TextAlign.end,
                          style: const TextStyle(fontSize: 15),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.only(left: 10, right: 10),
                            hintText: 'שם בעל החשבון',
                          )),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text('* מספר חשבון'),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                          border: Border.all(
                              color: const Color.fromRGBO(216, 216, 216, 1))),
                      child: TextField(
                          scrollPadding: EdgeInsets.only(bottom: 40),
                          controller: numberController,
                          maxLines: 1,
                          textAlignVertical: TextAlignVertical.top,
                          textAlign: TextAlign.end,
                          style: TextStyle(fontSize: 15),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.only(left: 10, right: 10),
                            hintText: 'מספר חשבון',
                          )),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text('* שם הבנק'),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                          border: Border.all(
                              color: const Color.fromRGBO(216, 216, 216, 1))),
                      child: TextField(
                          scrollPadding: EdgeInsets.only(bottom: 40),
                          controller: bankNameController,
                          maxLines: 1,
                          textAlignVertical: TextAlignVertical.top,
                          textAlign: TextAlign.end,
                          style: TextStyle(fontSize: 15),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.only(left: 10, right: 10),
                            hintText: 'שם הבנק',
                          )),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text('* ענף'),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                          border: Border.all(
                              color: const Color.fromRGBO(216, 216, 216, 1))),
                      child: TextField(
                          scrollPadding: EdgeInsets.only(bottom: 40),
                          controller: branchController,
                          maxLines: 1,
                          textAlignVertical: TextAlignVertical.top,
                          textAlign: TextAlign.end,
                          style: TextStyle(fontSize: 15),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.only(left: 10, right: 10),
                            hintText: 'ענף',
                          )),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              GestureDetector(
                onTap: () async {
                  print("kjsahdas");
                  print(LoginUser.shared?.userId!);
                  //EasyLoading.show();
                  await _userProfile.updateBankDetails(
                      LoginUser.shared?.userId! ??
                          application.idFromLocalProvider,
                      holderController.text,
                      numberController.text,
                      bankNameController.text,
                      branchController.text,
                      context);
                },
                child: Container(
                  height: 80,
                  width: width / 1.5,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color.fromRGBO(112, 168, 49, 1)),
                  child: const Center(
                      child: Text(
                    'עדכון חשבון בנק',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> willPop() async {
    final shouldpop = await Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
    return shouldpop;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: willPop,
      child: SafeArea(
          child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_new_outlined,
                      )),
                  if (application.myActivity != null)
                    GestureDetector(
                      onTap: () {
                        currentIndex = 1;
                        setState(() {});
                      },
                      child: Container(
                        height: 50,
                        width: width / 3.3,
                        margin: const EdgeInsets.only(right: 10, left: 5),
                        color: currentIndex == 1
                            ? const Color.fromRGBO(233, 108, 96, 1)
                            : const Color.fromRGBO(197, 197, 197, 1),
                        child: Center(
                            child: Text(
                          'קבלת תשלום',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color:
                                currentIndex == 1 ? Colors.white : Colors.black,
                          ),
                        )),
                      ),
                    ),
                  GestureDetector(
                    onTap: () {
                      currentIndex = 2;
                      setState(() {});
                    },
                    child: Container(
                      height: 50,
                      width: width / 3.3,
                      margin: const EdgeInsets.only(right: 10),
                      color: currentIndex == 2
                          ? const Color.fromRGBO(233, 108, 96, 1)
                          : const Color.fromRGBO(197, 197, 197, 1),
                      child: Center(
                          child: Text('סיסמה',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: currentIndex == 2
                                    ? Colors.white
                                    : Colors.black,
                              ))),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      currentIndex = 3;
                      setState(() {});
                    },
                    child: Container(
                      height: 50,
                      width: width / 3.3,
                      color: currentIndex == 3
                          ? const Color.fromRGBO(233, 108, 96, 1)
                          : const Color.fromRGBO(197, 197, 197, 1),
                      child: Center(
                          child: Text('פרופיל',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: currentIndex == 3
                                    ? Colors.white
                                    : Colors.black,
                              ))),
                    ),
                  )
                ],
              ),
            ),
            if (currentIndex == 3) profileUser(FacebookSignInController()),
            if (currentIndex == 2) const ChangePassword(),
            if (currentIndex == 1) userBankDetail(),
            // if (currentIndex == 3)
            //   const SocialProfile(),
          ],
        ),
      )),
    );
  }
}
