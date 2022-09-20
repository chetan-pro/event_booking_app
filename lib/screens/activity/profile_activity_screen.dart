// import 'dart:io';
//
// import 'package:basalon/network/create_event_network.dart';
// import 'package:basalon/screens/activity/general_screen.dart';
// import 'package:basalon/screens/activity/receiving_activity_screen.dart';
// import 'package:basalon/widgets/file_picker_helper.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../../blocs/application_bloc.dart';
//
// class ProfileActivityScreen extends StatefulWidget {
//   const ProfileActivityScreen({Key? key}) : super(key: key);
//
//   @override
//   _ProfileActivityScreenState createState() => _ProfileActivityScreenState();
// }
//
// class _ProfileActivityScreenState extends State<ProfileActivityScreen> {
//   late double width = MediaQuery.of(context).size.width;
//
//   GlobalKey<FormState> formkey = GlobalKey<FormState>();
//   GeneralScreen _generalScreen = GeneralScreen();
//   int currentIndex = 5;
//   late final application = Provider.of<ApplicationBloc>(context, listen: false);
//
//   void validate() {
//     if (formkey.currentState!.validate()) {
//       print('VALIDATED');
//       application.validate();
//       // Navigator.push(
//       //     context, MaterialPageRoute(builder: (context) => TicketScreen()));
//     } else {
//       print('Not Valid');
//     }
//   }
//
//   File? imgfile;
//   String? imgData;
//
//   TextEditingController firstnameController = TextEditingController();
//   TextEditingController lastnameController = TextEditingController();
//   TextEditingController UsersurNameController = TextEditingController();
//   TextEditingController userAddressController = TextEditingController();
//   TextEditingController userImageController = TextEditingController();
//   TextEditingController userDescriptionController = TextEditingController();
//   TextEditingController userPhoneController = TextEditingController();
//
//   late CreateEventNetwork _createEventNetwork = CreateEventNetwork(
//     firstnameController: firstnameController.text,
//     lastnameController: lastnameController.text,
//     userAddressController: userAddressController.text,
//     userImage: userImageController.text,
//     userDescription: userDescriptionController.text,
//     userPhoneController: userPhoneController.text,
//   );
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//
//     getFacebookDataFromLocal();
//   }
//
//   void didChangeDependencies() {
//     // TODO: implement initState
//     super.didChangeDependencies();
//   }
//
//   late String firstAndLastname =
//       firstAndLastnamee != null ? firstAndLastnamee : '';
//
//   var facebookImage;
//   var firstAndLastnamee;
//
//   getFacebookDataFromLocal() async {
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     var obtainedImage = sharedPreferences.getString('facebookImage');
//     var obtainedName = sharedPreferences.getString('facebookName');
//     setState(() {
//       facebookImage = obtainedImage;
//       firstAndLastnamee = obtainedName;
//       firstnameController.text = firstAndLastnamee != null
//           ? firstAndLastnamee.split(' ').first as String
//           : '';
//       lastnameController.text = firstAndLastnamee != null
//           ? firstAndLastnamee.split(' ').last as String
//           : '';
//     });
//     print(
//         'facebookImage facebookImage facebookImage facebookImage facebookImage$facebookImage');
//     print(
//         'firstAndLastname firstAndLastname firstAndLastname $firstAndLastnamee');
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.only(bottom: 100),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 const SizedBox(height: 25),
//                 Container(
//                     height: 200,
//                     width: width * 0.5,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(80),
//                     ),
//                     child: imgfile != null
//                         ? Image.file(
//                             imgfile!,
//                             height: 150,
//                             width: 150,
//                             fit: BoxFit.contain,
//                           )
//                         : facebookImage != null
//                             ? Image.network(
//                                 '${facebookImage}',
//                                 fit: BoxFit.fill,
//                               )
//                             : Image.asset('assets/images/dummy_user.png')),
//
//                 const SizedBox(height: 25),
//                 GestureDetector(
//                   onTap: () async {
//                     var fileList =
//                         await pickPicture(context: context).then((value) {
//                       if (value.isNotEmpty) {
//                         setState(() {
//                           imgfile = value[0];
//                           imgData = value[1];
//                         });
//                       }
//                     });
//                   },
//                   child: Container(
//                     height: 50,
//                     width: width / 2.8,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(5),
//                         color: const Color.fromRGBO(112, 168, 49, 1)),
//                     child: const Center(
//                         child: Text(
//                       'הוספת תמונה',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(color: Colors.white, fontSize: 17),
//                     )),
//                   ),
//                 ),
//                 // const SizedBox(height: 10),
//                 // const Text('גודל מומלץ 400x400 פיקסלים',
//                 //     style: TextStyle(fontSize: 18)
//                 // ),
//                 SizedBox(
//                   height: 30,
//                 ),
//                 Form(
//                   key: formkey,
//                   child: Column(
//                     children: [
//                       ReceivingPaymentFields(
//                         controller: firstnameController,
//                         obscureText: false,
//                         label: 'שם פרטי',
//                         showRequired: true,
//                         // hintText: 'שֵׁם',
//                       ),
//                       SizedBox(
//                         height: 30,
//                       ),
//                       ReceivingPaymentFields(
//                         controller: lastnameController,
//                         obscureText: false,
//                         label: 'שם משפחה',
//                         showRequired: true,
//
//                         // hintText: 'שֵׁם',
//                       ),
//                       SizedBox(
//                         height: 30,
//                       ),
//                       ReceivingPaymentFields(
//                         controller: userAddressController,
//                         obscureText: false,
//                         label: 'דואר אלקטורני',
//                         showRequired: true,
//
//                         // hintText: 'שֵׁם',
//                       ),
//                       SizedBox(
//                         height: 30,
//                       ),
//                       ReceivingPaymentFields(
//                         controller: userPhoneController,
//                         obscureText: false,
//                         label: 'טלפון נייד',
//                         showRequired: true,
//
//                         // hintText: 'שֵׁם',
//                       ),
//                       SizedBox(
//                         height: 30,
//                       ),
//                       ReceivingPaymentFields(
//                         controller: userDescriptionController,
//                         maxLine: 10,
//                         obscureText: false,
//                         label: 'ספרו על עצמכם',
//                         // hintText: 'שֵׁם',
//                         showRequired: true,
//                       ),
//                     ],
//                   ),
//                 ),
//
//                 const SizedBox(height: 35),
//                 Center(
//                   child: GestureDetector(
//                     onTap: () {
//                       application.previewFirstnameProvider =
//                           firstnameController.text;
//                       application.previewLastnameProvider =
//                           lastnameController.text;
//                       application.previewAuthorDescriptionrovider =
//                           userDescriptionController.text;
//                       application.previewAuthorImagerovider = imgfile;
//                       validate();
//                       _createEventNetwork
//                           .postCreateEventsUpdateProfile(context);
//                     },
//                     child: Container(
//                       height: 50,
//                       width: width / 2.5,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(5),
//                           color: const Color.fromRGBO(112, 168, 49, 1)),
//                       child: const Center(
//                           child: Text(
//                         'שמירה והמשך',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(color: Colors.white, fontSize: 17),
//                       )),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
