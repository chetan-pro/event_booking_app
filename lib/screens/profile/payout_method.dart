// import 'package:basalon/network/get_update_profile_network.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:provider/provider.dart';
//
// import '../../blocs/application_bloc.dart';
// import '../../constant/login_user.dart';
//
// class PayoutMethod extends StatefulWidget {
//   const PayoutMethod({Key? key}) : super(key: key);
//
//   @override
//   _PayoutMethodState createState() => _PayoutMethodState();
// }
//
// class _PayoutMethodState extends State<PayoutMethod> {
//   late double width = MediaQuery.of(context).size.width;
//   late final application = Provider.of<ApplicationBloc>(context, listen: false);
//
//   final UpdateAndGetUserProfile _userProfile = UpdateAndGetUserProfile();
//   TextEditingController holderController = TextEditingController();
//   TextEditingController numberController = TextEditingController();
//   TextEditingController bankNameController = TextEditingController();
//   TextEditingController branchController = TextEditingController();
//   final UpdateAndGetUserProfile _updateAndGetUserProfile =
//   UpdateAndGetUserProfile();
//  @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _updateAndGetUserProfile.getProfileData(
//         LoginUser.shared?.userId! ?? application.idFromLocalProvider);
//     Future.delayed(const Duration(seconds: 2), () => fillDetail());
//   }
//
//   fillDetail() {
//     holderController.text = _updateAndGetUserProfile.getUserData?.data != null
//         ? _updateAndGetUserProfile.getUserData?.data.userBankOwner
//         : application.emailFromFacebook ?? '';
//     numberController.text = _updateAndGetUserProfile.getUserData?.data != null
//         ? _updateAndGetUserProfile.getUserData?.data.userBankNumber
//         : application.emailFromFacebook ?? '';
//     bankNameController.text =
//     _updateAndGetUserProfile.getUserData?.data != null
//         ? _updateAndGetUserProfile.getUserData?.data.userBankName
//         : application.nameFromFacebook ?? '';
//     branchController.text = _updateAndGetUserProfile.getUserData?.data != null
//         ? _updateAndGetUserProfile.getUserData?.data.userBankBranch
//         : application.nameFromFacebook ?? '';
//
//     setState(() {});
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.only(bottom: 100),
//           child: Column(
//             children: [
//               const SizedBox(height: 25),
//               const Align(
//                 alignment: Alignment.topRight,
//                 child: Padding(
//                   padding: EdgeInsets.only(right: 15),
//                   child: Text('Bank Account Details',
//                       style:
//                           TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Padding(
//                 padding: const EdgeInsets.only(left: 15, right: 15),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     const Text('* Account Holder Name'),
//                     const SizedBox(height: 10),
//                     Container(
//                       decoration: BoxDecoration(
//                           borderRadius:
//                               const BorderRadius.all(Radius.circular(5)),
//                           border: Border.all(
//                               color: const Color.fromRGBO(216, 216, 216, 1))),
//                       child: TextField(
//                           controller: holderController,
//                           maxLines: 1,
//                           textAlignVertical: TextAlignVertical.top,
//                           textAlign: TextAlign.end,
//                           style: const TextStyle(fontSize: 15),
//                           decoration: const InputDecoration(
//                             border: InputBorder.none,
//                             contentPadding:
//                                 EdgeInsets.only(left: 10, right: 10),
//                             hintText: 'Account Holder Name',
//                           )),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Padding(
//                 padding: const EdgeInsets.only(left: 15, right: 15),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     const Text('* Account Number'),
//                     const SizedBox(height: 10),
//                     Container(
//                       decoration: BoxDecoration(
//                           borderRadius:
//                               const BorderRadius.all(Radius.circular(5)),
//                           border: Border.all(
//                               color: const Color.fromRGBO(216, 216, 216, 1))),
//                       child: TextField(
//                           controller: numberController,
//                           maxLines: 1,
//                           textAlignVertical: TextAlignVertical.top,
//                           textAlign: TextAlign.end,
//                           style: TextStyle(fontSize: 15),
//                           decoration: InputDecoration(
//                             border: InputBorder.none,
//                             contentPadding:
//                                 EdgeInsets.only(left: 10, right: 10),
//                             hintText: 'Account Number',
//                           )),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Padding(
//                 padding: const EdgeInsets.only(left: 15, right: 15),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     const Text('* The Bank Name'),
//                     const SizedBox(height: 10),
//                     Container(
//                       decoration: BoxDecoration(
//                           borderRadius:
//                               const BorderRadius.all(Radius.circular(5)),
//                           border: Border.all(
//                               color: const Color.fromRGBO(216, 216, 216, 1))),
//                       child: TextField(
//                           controller: bankNameController,
//                           maxLines: 1,
//                           textAlignVertical: TextAlignVertical.top,
//                           textAlign: TextAlign.end,
//                           style: TextStyle(fontSize: 15),
//                           decoration: InputDecoration(
//                             border: InputBorder.none,
//                             contentPadding:
//                                 EdgeInsets.only(left: 10, right: 10),
//                             hintText: 'The Bank Name',
//                           )),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Padding(
//                 padding: const EdgeInsets.only(left: 15, right: 15),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     const Text('* Branch'),
//                     const SizedBox(height: 10),
//                     Container(
//                       decoration: BoxDecoration(
//                           borderRadius:
//                               const BorderRadius.all(Radius.circular(5)),
//                           border: Border.all(
//                               color: const Color.fromRGBO(216, 216, 216, 1))),
//                       child: TextField(
//                           controller: branchController,
//                           maxLines: 1,
//                           textAlignVertical: TextAlignVertical.top,
//                           textAlign: TextAlign.end,
//                           style: TextStyle(fontSize: 15),
//                           decoration: InputDecoration(
//                             border: InputBorder.none,
//                             contentPadding:
//                                 EdgeInsets.only(left: 10, right: 10),
//                             hintText: 'Branch',
//                           )),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 25),
//               GestureDetector(
//                 onTap: () async {
//                   //EasyLoading.show();
//                   await _userProfile.updateBankDetails(
//                       LoginUser.shared?.userId! ??
//                           application.idFromLocalProvider,
//                       holderController.text,
//                       numberController.text,
//                       bankNameController.text,
//                       branchController.text,
//                       context);
//                 },
//                 child: Container(
//                   height: 80,
//                   width: width / 1.5,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(5),
//                       color: const Color.fromRGBO(112, 168, 49, 1)),
//                   child: const Center(
//                       child: Text(
//                     'Bank Account Update',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(color: Colors.white, fontSize: 17),
//                   )),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
