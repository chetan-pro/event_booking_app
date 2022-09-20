// import 'package:basalon/screens/activity/receiving_activity_screen.dart';
// import 'package:basalon/services/constant.dart';
// import 'package:basalon/widgets/custom_icons.dart';
// import 'package:basalon/widgets/date_helper.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../../blocs/application_bloc.dart';
// import '../../network/create_event_network.dart';
//
// class ActivityItemScreen extends StatefulWidget {
//   const ActivityItemScreen({Key? key}) : super(key: key);
//
//   @override
//   _ActivityItemScreenState createState() => _ActivityItemScreenState();
// }
//
// class _ActivityItemScreenState extends State<ActivityItemScreen> {
//   void initState() {
//     super.initState();
//     // dobtextEditingController.text = time;
//     defaultAddSpecificdates();
//   }
//
//   GlobalKey<FormState> formkey = GlobalKey<FormState>();
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
//   List<int> activityAddArray = [];
//   List<bool> editViewArray = [];
//   double height = 700;
//   var items = ktimeList;
//   DateTime date = DateTime.now();
//   late String time = "${date.day}/${date.month}/${date.year}";
//   late double width = MediaQuery.of(context).size.width;
//   late final application = Provider.of<ApplicationBloc>(context, listen: false);
//   late CreateEventNetwork _createEventNetwork = CreateEventNetwork(
//     recurrenceIntervalController: _dropDownValue,
//     recurrenceByDaysController: _dropDownValue,
//     optionCalenderController: dobtextEditingController.text,
//     startTimeController: startingTime,
//     endTimeController: endingTime,
//     recurrenceFrequencyController: _dropDownValueWeekly,
//   );
//
//   String? _dropDownValue;
//   String? _dropDownValueWeekly;
//   String? _dropDownValueFrequency;
//   String? startingTime;
//   String? endingTime;
//   String? optionCalender;
//
//   TextEditingController dobtextEditingController = TextEditingController();
//   TextEditingController startDOBtextEditingController = TextEditingController();
//   TextEditingController endDOBtextEditingController = TextEditingController();
//
//   Widget addActivity(VoidCallback onDeleteTap, VoidCallback onEditTap) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.end,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             Container(
//               width: 150,
//               decoration: BoxDecoration(
//                   borderRadius: const BorderRadius.all(Radius.circular(5)),
//                   color: Colors.white,
//                   border: Border.all(
//                       color: const Color.fromRGBO(216, 216, 216, 1))),
//               child: TextField(
//                 controller: startDOBtextEditingController,
//                 onTap: () async {
//                   var date = await selectDate(isDob: true, context: context);
//                   if (date != "null") {
//                     setState(() {
//                       startDOBtextEditingController.text =
//                           convertSingleDate(date);
//                     });
//                   }
//                 },
//                 decoration: InputDecoration(
//                     prefixIcon: CustomIconButton(
//                         onpressed: () async {
//                           var date =
//                               await selectDate(isDob: true, context: context);
//                           if (date != "null") {
//                             setState(() {
//                               startDOBtextEditingController.text =
//                                   convertSingleDate(date);
//                             });
//                           }
//                         },
//                         icon: Icons.calendar_today),
//                     // disable: true,
//                     // width: screenWidth(context) * 0.4,
//                     //context: context,
//                     hintText: 'd-m-Y'),
//               ),
//             ),
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 10),
//               child: Text(': ועד'),
//             ),
//             Container(
//               width: 150,
//               decoration: BoxDecoration(
//                   borderRadius: const BorderRadius.all(Radius.circular(5)),
//                   color: Colors.white,
//                   border: Border.all(
//                       color: const Color.fromRGBO(216, 216, 216, 1))),
//               child: TextField(
//                 controller: endDOBtextEditingController,
//                 onTap: () async {
//                   var date = await selectDate(isDob: true, context: context);
//                   if (date != "null") {
//                     setState(() {
//                       endDOBtextEditingController.text =
//                           convertSingleDate(date);
//                     });
//                   }
//                 },
//                 decoration: InputDecoration(
//                     prefixIcon: CustomIconButton(
//                         onpressed: () async {
//                           var date =
//                               await selectDate(isDob: true, context: context);
//                           if (date != "null") {
//                             setState(() {
//                               endDOBtextEditingController.text =
//                                   convertSingleDate(date);
//                             });
//                           }
//                         },
//                         icon: Icons.calendar_today),
//                     // disable: true,
//                     // width: screenWidth(context) * 0.4,
//                     //context: context,
//                     hintText: 'd-m-Y'),
//               ),
//             ),
//           ],
//         ),
//         GestureDetector(
//           onTap: () {
//             onDeleteTap();
//           },
//           child: Container(
//             height: 50,
//             width: 50,
//             decoration: const BoxDecoration(
//               color: Color.fromRGBO(233, 108, 96, 1),
//               borderRadius: BorderRadius.all(Radius.circular(5)),
//             ),
//             child: const Center(
//                 child: Text('X',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(color: Colors.white))),
//           ),
//         ),
//       ],
//     );
//   }
//
//   int activeRadio = 1;
//   List<int> timeOptionAddArray = [];
//
//   List<int> cyclicalAndArray = [];
//   bool isMonday = false;
//   bool isTuesday = false;
//   bool isWednesday = false;
//   bool isThursday = false;
//   bool isFriday = false;
//   bool isSaturday = false;
//   bool isSunday = false;
//
//   Future<void> defaultAddSpecificdates() async {
//     setState(() {
//       timeOptionAddArray.add(timeOptionAddArray.length + 1);
//     });
//   }
//
//   Widget addSpecificDates(VoidCallback onTap, int index) {
//     return Form(
//       key: formkey,
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(left: 15, right: 15),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 Row(
//                   textDirection: TextDirection.rtl,
//                   children: [
//                     // GestureDetector(
//                     //   onTap: onTap,
//                     //   child: Container(
//                     //     height: 25,
//                     //     width: 25,
//                     //     decoration: const BoxDecoration(
//                     //       color: Color.fromRGBO(233, 108, 96, 1),
//                     //       borderRadius: BorderRadius.all(Radius.circular(5)),
//                     //     ),
//                     //     child: const Center(
//                     //         child: Text('X',
//                     //             textAlign: TextAlign.center,
//                     //             style: TextStyle(color: Colors.white))),
//                     //   ),
//                     // ),
//                     const Text(
//                       'פעילות מתחילה מ:',
//                       textDirection: TextDirection.rtl,
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 10),
//                 Row(
//                   textDirection: TextDirection.rtl,
//                   children: [
//                     Container(
//                       width: 120,
//                       decoration: BoxDecoration(
//                           borderRadius:
//                               const BorderRadius.all(Radius.circular(5)),
//                           border: Border.all(
//                               color: const Color.fromRGBO(216, 216, 216, 1))),
//                       child: Directionality(
//                         textDirection: TextDirection.rtl,
//                         child: DropdownButtonHideUnderline(
//                           child: ButtonTheme(
//                             alignedDropdown: true,
//                             child: DropdownButton(
//                               isExpanded: true,
//                               menuMaxHeight: 300,
//                               hint: startingTime == null
//                                   ? const Padding(
//                                       padding: EdgeInsets.all(8.0),
//                                       child: Text(
//                                         'HH:MM',
//                                         style: TextStyle(color: Colors.grey),
//                                       ),
//                                     )
//                                   : Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Text(
//                                         startingTime!,
//                                         style: const TextStyle(
//                                             color: Colors.black),
//                                       ),
//                                     ),
//                               iconSize: 30.0,
//                               style: const TextStyle(color: Colors.black),
//                               items: items.map(
//                                 (val) {
//                                   return DropdownMenuItem<String>(
//                                     value: val,
//                                     child: Text(val),
//                                   );
//                                 },
//                               ).toList(),
//                               onChanged: (val) {
//                                 setState(
//                                   () {
//                                     startingTime = val as String?;
//                                   },
//                                 );
//                               },
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Container(
//                       padding: EdgeInsets.symmetric(horizontal: 10),
//                       child: Text('ועד'),
//                     ),
//                     Container(
//                       width: 120,
//                       decoration: BoxDecoration(
//                           borderRadius:
//                               const BorderRadius.all(Radius.circular(5)),
//                           border: Border.all(
//                               color: const Color.fromRGBO(216, 216, 216, 1))),
//                       child: Directionality(
//                         textDirection: TextDirection.rtl,
//                         child: DropdownButtonHideUnderline(
//                           child: ButtonTheme(
//                             alignedDropdown: true,
//                             child: DropdownButton(
//                               isExpanded: true,
//                               menuMaxHeight: 300,
//                               hint: endingTime == null
//                                   ? const Padding(
//                                       padding: EdgeInsets.all(8.0),
//                                       child: Text(
//                                         'HH:MM',
//                                         style: TextStyle(color: Colors.grey),
//                                       ),
//                                     )
//                                   : Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Text(
//                                         endingTime!,
//                                         style: const TextStyle(
//                                             color: Colors.black),
//                                       ),
//                                     ),
//                               iconSize: 30.0,
//                               style: const TextStyle(color: Colors.black),
//                               items: ktimeList.map(
//                                 (val) {
//                                   return DropdownMenuItem<String>(
//                                     value: val,
//                                     child: Text(val),
//                                   );
//                                 },
//                               ).toList(),
//                               onChanged: (val) {
//                                 setState(
//                                   () {
//                                     endingTime = val as String?;
//                                   },
//                                 );
//                               },
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     Text('שבועות'),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 10.0),
//                       child: Container(
//                         width: 70,
//                         decoration: BoxDecoration(
//                             borderRadius:
//                                 const BorderRadius.all(Radius.circular(5)),
//                             border: Border.all(
//                                 color: const Color.fromRGBO(216, 216, 216, 1))),
//                         child: Directionality(
//                           textDirection: TextDirection.rtl,
//                           child: DropdownButtonHideUnderline(
//                             child: ButtonTheme(
//                               alignedDropdown: true,
//                               child: DropdownButton(
//                                 isExpanded: true,
//                                 menuMaxHeight: 300,
//                                 hint: _dropDownValue == null
//                                     ? const Padding(
//                                         padding: EdgeInsets.all(8.0),
//                                         child: Text(
//                                           '1',
//                                           style: TextStyle(color: Colors.grey),
//                                         ),
//                                       )
//                                     : Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: Text(
//                                           _dropDownValue!,
//                                           style: const TextStyle(
//                                               color: Colors.black),
//                                         ),
//                                       ),
//                                 iconSize: 30.0,
//                                 style: const TextStyle(color: Colors.black),
//                                 items: ['1', '2', '3', '4', '5'].map(
//                                   (val) {
//                                     return DropdownMenuItem<String>(
//                                       value: val,
//                                       child: Text(val),
//                                     );
//                                   },
//                                 ).toList(),
//                                 onChanged: (val) {
//                                   setState(
//                                     () {
//                                       _dropDownValue = val as String?;
//                                     },
//                                   );
//                                 },
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     // Expanded(
//                     //   child: Container(
//                     //     margin: EdgeInsets.all(10),
//                     //     width: 100,
//                     //     height: 40,
//                     //     decoration: BoxDecoration(
//                     //         borderRadius:
//                     //             const BorderRadius.all(Radius.circular(5)),
//                     //         border: Border.all(
//                     //             color: const Color.fromRGBO(216, 216, 216, 1))),
//                     //     child: Directionality(
//                     //       textDirection: TextDirection.rtl,
//                     //       child: DropdownButtonHideUnderline(
//                     //         child: ButtonTheme(
//                     //           alignedDropdown: true,
//                     //           child: DropdownButton(
//                     //             isExpanded: true,
//                     //             menuMaxHeight: 300,
//                     //             hint: _dropDownValueWeekly == null
//                     //                 ? Text('Weekly', style: ktextStyle)
//                     //                 : Padding(
//                     //                     padding: const EdgeInsets.all(8.0),
//                     //                     child: Text(
//                     //                       _dropDownValueWeekly!,
//                     //                       style: const TextStyle(
//                     //                           color: Colors.black),
//                     //                     ),
//                     //                   ),
//                     //             iconSize: 30.0,
//                     //             style: const TextStyle(color: Colors.black),
//                     //             items:
//                     //                 ['Daily', 'Weekly', 'Monthly', 'Yearly'].map(
//                     //               (val) {
//                     //                 return DropdownMenuItem<String>(
//                     //                   value: val,
//                     //                   child: Text(val),
//                     //                 );
//                     //               },
//                     //             ).toList(),
//                     //             onChanged: (val) {
//                     //               setState(
//                     //                 () {
//                     //                   _dropDownValueWeekly = val as String?;
//                     //                 },
//                     //               );
//                     //             },
//                     //           ),
//                     //         ),
//                     //       ),
//                     //     ),
//                     //   ),
//                     // ),
//                     SizedBox(width: 10),
//                     const Text(
//                       'פעילות זו חוזרת על עצמה כל',
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     Text('רביעי'),
//                     Container(
//                       width: 24,
//                       height: 24,
//                       child: Checkbox(
//                         value: isWednesday,
//                         onChanged: (bool? value) {
//                           // This is where we update the state when the checkbox is tapped
//                           setState(() {
//                             isWednesday = value!;
//                           });
//                         },
//                       ),
//                     ),
//                     SizedBox(width: 29),
//                     Text('שלישי'),
//                     Container(
//                       width: 24,
//                       height: 24,
//                       child: Checkbox(
//                         value: isTuesday,
//                         onChanged: (bool? value) {
//                           // This is where we update the state when the checkbox is tapped
//                           setState(() {
//                             isTuesday = value!;
//                           });
//                         },
//                       ),
//                     ),
//                     SizedBox(width: 29),
//                     Text('שני'),
//                     Container(
//                       width: 24,
//                       height: 24,
//                       child: Checkbox(
//                         value: isMonday,
//                         onChanged: (bool? value) {
//                           // This is where we update the state when the checkbox is tapped
//                           setState(() {
//                             isMonday = value!;
//                           });
//                         },
//                       ),
//                     ),
//                     SizedBox(width: 29),
//                     Text('ראשון'),
//                     Container(
//                       width: 24,
//                       height: 24,
//                       child: Checkbox(
//                         value: isSunday,
//                         onChanged: (bool? value) {
//                           // This is where we update the state when the checkbox is tapped
//                           setState(() {
//                             isSunday = value!;
//                           });
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     Text('שבת'),
//                     Container(
//                       width: 24,
//                       height: 24,
//                       child: Checkbox(
//                         value: isSaturday,
//                         onChanged: (bool? value) {
//                           // This is where we update the state when the checkbox is tapped
//                           setState(() {
//                             isSaturday = value!;
//                           });
//                         },
//                       ),
//                     ),
//                     SizedBox(width: 24),
//                     Text('שישי'),
//                     Container(
//                       width: 24,
//                       height: 24,
//                       child: Checkbox(
//                         value: isFriday,
//                         onChanged: (bool? value) {
//                           // This is where we update the state when the checkbox is tapped
//                           setState(() {
//                             isFriday = value!;
//                           });
//                         },
//                       ),
//                     ),
//                     SizedBox(width: 24),
//                     Text('חמישי'),
//                     Container(
//                       width: 24,
//                       height: 24,
//                       child: Checkbox(
//                         value: isThursday,
//                         onChanged: (bool? value) {
//                           // This is where we update the state when the checkbox is tapped
//                           setState(() {
//                             isThursday = value!;
//                           });
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 20),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     GestureDetector(
//                       onTap: () async {
//                         var date =
//                             await selectDate(isDob: true, context: context);
//                         if (date != "null") {
//                           setState(() {
//                             dobtextEditingController.text =
//                                 convertSingleDate(date);
//                           });
//                         }
//                       },
//                       child: Container(
//                         child: ReceivingPaymentFields(
//                           obscureText: false,
//                           controller: dobtextEditingController,
//                           onTap: () async {
//                             var date =
//                                 await selectDate(isDob: true, context: context);
//                             if (date != "null") {
//                               setState(() {
//                                 dobtextEditingController.text =
//                                     convertSingleDate(date);
//                               });
//                             }
//                           },
//                         ),
//
//                         // TextFormField(
//                         //   key: formkey,
//                         //   // validator: validate(),
//                         //   textAlign: TextAlign.center,
//                         //   controller: dobtextEditingController,
//                         //   // initialValue: "fhg",
//                         //   onTap: () async {
//                         //     var date =
//                         //     await selectDate(isDob: true, context: context);
//                         //     if (date != "null") {
//                         //       setState(() {
//                         //         dobtextEditingController.text =
//                         //             convertSingleDate(date);
//                         //       });
//                         //     }
//                         //   },
//                         // ),
//                         margin: EdgeInsets.symmetric(horizontal: 10),
//                         // padding: EdgeInsets.only(left: 15),
//                         width: 120,
//                         // height: 100,
//                       ),
//                     ),
//                     Expanded(
//                       child: Text(
//                         'הפעילות מתחילה החל מתאריך',
//                       ),
//                     )
//                   ],
//                 ),
//                 const SizedBox(height: 10),
//                 const Text(
//                   'כמה דקות לפני תחילת הפעילות תרצו שמכירת הכרטיסים תיפסק? (השתדלו שמספר הדקות יהיה נמוך - רצוי 0-30 דקות)',
//                   textAlign: TextAlign.end,
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Container(
//                   width: 50,
//                   decoration: BoxDecoration(
//                       borderRadius: const BorderRadius.all(Radius.circular(5)),
//                       border: Border.all(
//                           color: const Color.fromRGBO(216, 216, 216, 1))),
//                   child: TextField(
//                       maxLines: 1,
//                       textAlignVertical: TextAlignVertical.top,
//                       textAlign: TextAlign.end,
//                       //controller: socialText,
//                       style: const TextStyle(fontSize: 15),
//                       decoration: InputDecoration(
//                         border: InputBorder.none,
//                         contentPadding:
//                             const EdgeInsets.only(left: 10, right: 10),
//                         hintText: (timeOptionAddArray[index] - 1).toString(),
//                       )),
//                 ),
//                 const SizedBox(height: 10),
//                 Text(
//                   'האם ישנם תאריכים מסויימים שלא תוכלו לקיים את הפעילות?',
//                   style: ktextStyleBold,
//                   textDirection: TextDirection.rtl,
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     ListView.builder(
//                       itemCount: activityAddArray.length,
//                       physics: const NeverScrollableScrollPhysics(),
//                       shrinkWrap: true,
//                       itemBuilder: (context, index) {
//                         return addActivity(() {
//                           activityAddArray.removeAt(index);
//                           setState(() {});
//                         }, () {
//                           editViewArray[index] = !editViewArray[index];
//                           height = editViewArray[index] ? 700 : 60;
//                           setState(() {});
//                         });
//                       },
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           activityAddArray.add(1);
//                           editViewArray.add(true);
//                         });
//                       },
//                       child: Container(
//                         height: 40,
//                         width: width / 4,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(5),
//                             color: const Color.fromRGBO(112, 168, 49, 1)),
//                         child: const Center(
//                             child: Text('הוספה',
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                     color: Colors.white, fontSize: 17))),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget addCyclicalActivity(VoidCallback onTap, int index) {
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(left: 15, right: 15),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               // const Text(': Activity Starting From'),
//               const SizedBox(height: 10),
//               SizedBox(
//                 width: width,
//                 child: Row(
//                   children: [
//                     Expanded(
//                       flex: 1,
//                       child: Container(
//                         decoration: BoxDecoration(
//                             borderRadius:
//                                 const BorderRadius.all(Radius.circular(5)),
//                             border: Border.all(
//                                 color: const Color.fromRGBO(216, 216, 216, 1))),
//                         child: Directionality(
//                           textDirection: TextDirection.rtl,
//                           child: DropdownButtonHideUnderline(
//                             child: ButtonTheme(
//                               alignedDropdown: true,
//                               child: DropdownButton(
//                                 isExpanded: true,
//                                 menuMaxHeight: 300,
//                                 hint: startingTime == null
//                                     ? Text(
//                                         'HH:MM',
//                                         style: TextStyle(color: Colors.grey),
//                                       )
//                                     : Text(
//                                         startingTime!,
//                                         style: const TextStyle(
//                                             color: Colors.black),
//                                       ),
//                                 iconSize: 30.0,
//                                 style: const TextStyle(color: Colors.black),
//                                 items: items.map(
//                                   (val) {
//                                     return DropdownMenuItem<String>(
//                                       value: val,
//                                       child: Text(val),
//                                     );
//                                   },
//                                 ).toList(),
//                                 onChanged: (val) {
//                                   setState(
//                                     () {
//                                       startingTime = val as String?;
//                                     },
//                                   );
//                                 },
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: const Center(
//                         child: Text(
//                           'ועד:',
//                           textDirection: TextDirection.rtl,
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       child: Container(
//                         decoration: BoxDecoration(
//                             borderRadius:
//                                 const BorderRadius.all(Radius.circular(5)),
//                             border: Border.all(
//                                 color: const Color.fromRGBO(216, 216, 216, 1))),
//                         child: Directionality(
//                           textDirection: TextDirection.rtl,
//                           child: DropdownButtonHideUnderline(
//                             child: ButtonTheme(
//                               alignedDropdown: true,
//                               child: DropdownButton(
//                                 isExpanded: true,
//                                 menuMaxHeight: 300,
//                                 hint: endingTime == null
//                                     ? Text(
//                                         'HH:MM',
//                                         style: TextStyle(color: Colors.grey),
//                                       )
//                                     : Text(
//                                         endingTime!,
//                                         style: const TextStyle(
//                                             color: Colors.black),
//                                       ),
//                                 iconSize: 30.0,
//                                 style: const TextStyle(color: Colors.black),
//                                 items: items.map(
//                                   (val) {
//                                     return DropdownMenuItem<String>(
//                                       value: val,
//                                       child: Text(val),
//                                     );
//                                   },
//                                 ).toList(),
//                                 onChanged: (val) {
//                                   setState(() {
//                                     endingTime = val as String?;
//                                   });
//                                 },
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Text(
//                       'החל מ:',
//                       textDirection: TextDirection.rtl,
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               Row(
//                 children: [
//                   Expanded(
//                     child: Container(
//                       decoration: BoxDecoration(
//                           borderRadius:
//                               const BorderRadius.all(Radius.circular(5)),
//                           border: Border.all(
//                               color: const Color.fromRGBO(216, 216, 216, 1))),
//                       child: TextField(
//                           maxLines: 1,
//                           textAlignVertical: TextAlignVertical.top,
//                           textAlign: TextAlign.end,
//                           //controller: socialText,
//                           style: const TextStyle(fontSize: 15),
//                           decoration: InputDecoration(
//                             border: InputBorder.none,
//                             contentPadding:
//                                 const EdgeInsets.only(left: 10, right: 10),
//                             //hintText: timeOptionAddArray[index].toString(),
//                           )),
//                     ),
//                   ),
//                   Expanded(
//                     flex: 2,
//                     child: Text(
//                       'כמה דקות לפני תחילת הפעילות תרצו שמכירת הכרטיסים תיפסק? (השתדלו שמספר הדקות יהיה נמוך - רצוי 0-30 דקות)',
//                       textAlign: TextAlign.end,
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 10),
//             ],
//           ),
//         ),
//         const SizedBox(height: 40),
//       ],
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.only(bottom: 100),
//           child: Column(
//             children: [
//               const SizedBox(height: 20),
//               const Align(
//                 alignment: Alignment.topRight,
//                 child: Padding(
//                   padding: EdgeInsets.only(right: 15),
//                   child: Text(
//                     'אפשרויות זמנים:',
//                     textDirection: TextDirection.rtl,
//                   ),
//                 ),
//               ),
//
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     Row(
//                       textDirection: TextDirection.rtl,
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         SizedBox(
//                           height: 24,
//                           width: 24,
//                           child: Radio(
//                             value: 0,
//                             groupValue: activeRadio,
//                             onChanged: (int? value) {
//                               print(value);
//                               setState(() {
//                                 activeRadio = value!;
//                                 optionCalender = 'auto';
//                               });
//                               print(optionCalender);
//                             },
//                           ),
//                         ),
//                         const Text('תאריכים ספציפיים'),
//                       ],
//                     ),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     Row(
//                       textDirection: TextDirection.rtl,
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         SizedBox(
//                           height: 24,
//                           width: 24,
//                           child: Radio(
//                             value: 1,
//                             groupValue: activeRadio,
//                             onChanged: (int? value) {
//                               print(
//                                   '$value oooooooooooooooooooooopppppppppppppppp');
//                               setState(() {
//                                 activeRadio = value!;
//                                 optionCalender = 'manual';
//                               });
//                               print(optionCalender);
//                             },
//                           ),
//                         ),
//                         const Text('פעילות מחזורית ')
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 20),
//               if (activeRadio == 0)
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     Expanded(
//                       flex: 2,
//                       child: Align(
//                         alignment: Alignment.centerRight,
//                         child: Container(
//                             width: width / 3,
//                             decoration: BoxDecoration(
//                                 borderRadius:
//                                     const BorderRadius.all(Radius.circular(5)),
//                                 color: Colors.white,
//                                 border: Border.all(
//                                     color: const Color.fromRGBO(
//                                         216, 216, 216, 1))),
//                             child: TextField(
//                               textAlign: TextAlign.center,
//                               controller: dobtextEditingController,
//                               onTap: () async {
//                                 var date = await selectDate(
//                                     isDob: true, context: context);
//                                 if (date != "null") {
//                                   setState(() {
//                                     dobtextEditingController.text =
//                                         convertSingleDate(date);
//                                   });
//                                 }
//                               },
//                               // decoration: InputDecoration(
//                               //     prefixIcon: CustomIconButton(
//                               //
//                               //         onpressed: () async {
//                               //           var date = await selectDate(
//                               //               isDob: true, context: context);
//                               //           if (date != "null") {
//                               //             setState(() {
//                               //               dobtextEditingController.text =
//                               //                   convertSingleDate(date);
//                               //             });
//                               //           }
//                               //         },
//                               //         icon: Icons.calendar_today),
//                               //     hintText: 'd-m-Y'),
//                             )),
//                       ),
//                     ),
//                     Expanded(
//                       child: Text(
//                         'תאריך הפעילות',
//                         textAlign: TextAlign.right,
//                       ),
//                     ),
//                   ],
//                 ),
//               ListView.builder(
//                 physics: const NeverScrollableScrollPhysics(),
//                 shrinkWrap: true,
//                 itemCount: activeRadio == 1 ? timeOptionAddArray.length : 1,
//                 itemBuilder: (context, index) {
//                   return activeRadio == 1
//                       ? addSpecificDates(() {
//                           timeOptionAddArray.removeAt(index);
//                           setState(() {});
//                         }, index)
//                       : addCyclicalActivity(() {
//                           cyclicalAndArray.removeAt(index);
//                           setState(() {});
//                         }, index);
//                 },
//               ),
//               // ListView.builder(
//               //     physics: const NeverScrollableScrollPhysics(),
//               //     shrinkWrap: true,
//               //     itemCount: activeRadio == 0 ? cyclicalAndArray.length : 1,
//               //     itemBuilder: (context, index) {
//               //       return activeRadio == 1
//               //           ? addCyclicalActivity(() {
//               //               cyclicalAndArray.removeAt(index);
//               //               setState(() {});
//               //             }, index)
//               //           : addSpecificDates(() {
//               //               timeOptionAddArray.removeAt(index);
//               //               setState(() {});
//               //             }, index);
//               //     }),
//               if (activeRadio == 0)
//                 Align(
//                   alignment: Alignment.topRight,
//                   child: Padding(
//                     padding: const EdgeInsets.only(right: 15),
//                     child: GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           cyclicalAndArray.add(cyclicalAndArray.length + 1);
//                         });
//                       },
//                       child: Container(
//                         height: 50,
//                         width: width / 2,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(5),
//                             color: const Color.fromRGBO(112, 168, 49, 1)),
//                         child: const Center(
//                             child: Text('הוספת תאריך נוסף',
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                     color: Colors.white, fontSize: 17))),
//                       ),
//                     ),
//                   ),
//                 ),
//               SizedBox(
//                 height: 50,
//               ),
//               Container(
//                 width: 170,
//                 child: MaterialButton(
//                   height: 50,
//                   onPressed: () {
//                     application.previewDateProvider =
//                         dobtextEditingController.text;
//                     validate();
//                     // //EasyLoading.show();
//                     _createEventNetwork.postCreateEventsCalender(context);
//                   },
//                   color: const Color.fromRGBO(112, 168, 49, 1),
//                   child: const Center(
//                       child: Text(
//                     'שמירה והמשך',
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
