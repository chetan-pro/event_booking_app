// import 'package:basalon/network/create_event_network.dart';
// import 'package:basalon/services/constant.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../../blocs/application_bloc.dart';
//
// class TicketScreen extends StatefulWidget {
//   const TicketScreen({Key? key}) : super(key: key);
//
//   @override
//   _TicketScreenState createState() => _TicketScreenState();
// }
//
// class _TicketScreenState extends State<TicketScreen> {
//   List<int> ticketAddArray = [];
//   List<bool> editViewArray = [];
//
//   bool coupon = false;
//   double height = 700;
//
//   late double width = MediaQuery.of(context).size.width;
//   late CreateEventNetwork _createEventNetwork = CreateEventNetwork(
//     ticketPriceController: ticketPriceController.text,
//     ticketDescriptionController: ticketDescriptionController.text,
//     totalTicketController: totalTicketController.text,
//     discountCodeController: discountCodeController.text,
//     discountAmountController: discountAmountController.text,
//   );
//
//   TextEditingController ticketPriceController = TextEditingController();
//   TextEditingController ticketDescriptionController = TextEditingController();
//   TextEditingController totalTicketController = TextEditingController();
//   TextEditingController discountCodeController = TextEditingController();
//   TextEditingController discountAmountController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     ticketAddArray.add(1);
//     final application = Provider.of<ApplicationBloc>(context, listen: false);
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     final application = Provider.of<ApplicationBloc>(context, listen: false);
//     application.dispose();
//   }
//
//   GlobalKey<FormState> formkey = GlobalKey<FormState>();
//
//   // void validate() {
//   //   if (formkey.currentState.validate()) {
//   //     print('VALIDATED');
//   //   } else {
//   //     print('Not Valid');
//   //   }
//   // }
//
//   late final application = Provider.of<ApplicationBloc>(context, listen: false);
//   bool showTicket = false;
//
//   Widget addTicket(VoidCallback onDeleteTap, VoidCallback onEditTap) {
//     return Column(
//       children: [
//         Container(
//           width: width - 25,
//           clipBehavior: Clip.hardEdge,
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               color: const Color.fromRGBO(109, 109, 109, 1)),
//           child: Stack(
//             children: [
//               Padding(
//                 padding:
//                     const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
//                 child: Row(
//                   // crossAxisAlignment: CrossAxisAlignment.spaceBetween,
//                   children: [
//                     GestureDetector(
//                       onTap: onDeleteTap,
//                       child: const Icon(
//                         Icons.delete,
//                         color: Colors.white,
//                       ),
//                     ),
//                     const SizedBox(width: 20),
//                     GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             showTicket = false;
//                           });
//                           print('edit uuuuuuuuuuu');
//                           onEditTap();
//                         },
//                         child: const Icon(
//                           Icons.edit,
//                           color: Colors.white,
//                         )),
//                     // Expanded(child: Text("sds")),
//                     Expanded(
//                         child: Row(
//                       textDirection: TextDirection.rtl,
//                       children: [
//                         Expanded(
//                           child: Icon(
//                             Icons.airplane_ticket_rounded,
//                             color: Colors.white,
//                           ),
//                         ),
//                         Expanded(
//                           flex: 4,
//                           child: TextFormField(
//                             textAlign: TextAlign.end,
//                             style: TextStyle(color: Colors.white),
//                             initialValue: 'כרטיס רגיל',
//                             decoration: InputDecoration(
//                                 border: InputBorder.none,
//                                 fillColor: Colors.white,
//                                 focusColor: Colors.white),
//                           ),
//                         ),
//                       ],
//                     ))
//                   ],
//                 ),
//               ),
//               showTicket == false
//                   ? Padding(
//                       padding: const EdgeInsets.only(top: 60),
//                       child: Container(
//                         // height: 640,
//                         width: width - 25,
//                         decoration: const BoxDecoration(
//                             color: Color.fromRGBO(234, 234, 234, 1)),
//                         child: Form(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.end,
//                             children: [
//                               const Align(
//                                 alignment: Alignment.topRight,
//                                 child: Padding(
//                                   padding: EdgeInsets.only(right: 15, top: 15),
//                                   child: Text('מחיר לכרטיס בש"ח',
//                                       style: ktextStyleBold),
//                                 ),
//                               ),
//                               const SizedBox(height: 20),
//                               Padding(
//                                 padding: const EdgeInsets.only(right: 15),
//                                 child: Container(
//                                   width: 80,
//                                   decoration: BoxDecoration(
//                                       borderRadius: const BorderRadius.all(
//                                           Radius.circular(5)),
//                                       color: Colors.white,
//                                       border: Border.all(
//                                           color: const Color.fromRGBO(
//                                               216, 216, 216, 1))),
//                                   child: TextFormField(
//                                       // validator: (value) {
//                                       //   if (value!.isEmpty || value == null) {
//                                       //     return '*required';
//                                       //   } else {
//                                       //     return null;
//                                       //   }
//                                       // },
//                                       controller: ticketPriceController,
//                                       maxLines: 1,
//                                       textAlignVertical: TextAlignVertical.top,
//                                       textAlign: TextAlign.end,
//                                       style: TextStyle(fontSize: 15),
//                                       decoration: InputDecoration(
//                                         border: InputBorder.none,
//                                         contentPadding: EdgeInsets.only(
//                                             left: 10, right: 10),
//                                         // hintText: '0',
//                                       )),
//                                 ),
//                               ),
//                               SizedBox(height: 20),
//                               Align(
//                                 alignment: Alignment.topRight,
//                                 child: Padding(
//                                   padding: EdgeInsets.only(right: 15, top: 15),
//                                   child: RichText(
//                                     text: TextSpan(
//                                         text: 'סה"כ',
//                                         style: ktextStyleBold,
//                                         children: [
//                                           TextSpan(
//                                             text: ' מספר הכרטיסים',
//                                             style: TextStyle(
//                                                 fontWeight: FontWeight.normal),
//                                           ),
//                                         ]),
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(height: 20),
//                               Padding(
//                                 padding: const EdgeInsets.only(right: 15),
//                                 child: Container(
//                                   width: 80,
//                                   decoration: BoxDecoration(
//                                       borderRadius: const BorderRadius.all(
//                                           Radius.circular(5)),
//                                       color: Colors.white,
//                                       border: Border.all(
//                                           color: const Color.fromRGBO(
//                                               216, 216, 216, 1))),
//                                   child: TextFormField(
//                                       controller: totalTicketController,
//                                       maxLines: 1,
//                                       textAlignVertical: TextAlignVertical.top,
//                                       textAlign: TextAlign.end,
//                                       style: TextStyle(fontSize: 15),
//                                       decoration: InputDecoration(
//                                         border: InputBorder.none,
//                                         contentPadding: EdgeInsets.only(
//                                             left: 10, right: 10),
//                                         // hintText: '10',
//                                       )),
//                                 ),
//                               ),
//                               const SizedBox(height: 20),
//                               const Padding(
//                                 padding: EdgeInsets.only(left: 10, right: 10),
//                                 child: Divider(
//                                   color: Colors.grey,
//                                 ),
//                               ),
//                               const SizedBox(height: 20),
//                               const Padding(
//                                 padding: EdgeInsets.only(right: 15),
//                                 child: Text(
//                                   "הוסיפו פרטים שיעזרו לרוכשים להגיע לפעילות שלכם - מס' כניסה לבניין, קוד כניסה או כל פרט אחר שיכול לעזור.",
//                                   textDirection: TextDirection.rtl,
//                                   style: TextStyle(fontSize: 13),
//                                   // textDirection: TextDirection.rtl,
//                                 ),
//                               ),
//                               const Padding(
//                                 padding: EdgeInsets.only(right: 15),
//                                 child: Text(
//                                   "אם מדובר בפעילות אונליין נא להוסיף לכאן את הלינק",
//                                   textDirection: TextDirection.rtl,
//                                   style: TextStyle(fontSize: 13),
//                                   // textDirection: TextDirection.rtl,
//                                 ),
//                               ),
//                               const Padding(
//                                 padding: EdgeInsets.only(right: 15),
//                                 child: Text(
//                                   "(כל מה שתכתבו כאן יחשף רק למי שקנה כרטיס ולא יופיע באתר/אפליקציה)",
//                                   textDirection: TextDirection.rtl,
//                                   style: TextStyle(fontSize: 13),
//                                   // textDirection: TextDirection.rtl,
//                                 ),
//                               ),
//                               const SizedBox(height: 20),
//                               Padding(
//                                 padding:
//                                     const EdgeInsets.only(left: 15, right: 15),
//                                 child: Container(
//                                   height: 170,
//                                   decoration: BoxDecoration(
//                                       borderRadius: const BorderRadius.all(
//                                           Radius.circular(5)),
//                                       color: Colors.white,
//                                       border: Border.all(
//                                           color: const Color.fromRGBO(
//                                               216, 216, 216, 1))),
//                                   child: TextFormField(
//                                       controller: ticketDescriptionController,
//                                       maxLines: 10,
//                                       textAlignVertical: TextAlignVertical.top,
//                                       textAlign: TextAlign.end,
//                                       style: TextStyle(fontSize: 15),
//                                       decoration: InputDecoration(
//                                         border: InputBorder.none,
//                                         contentPadding: EdgeInsets.only(
//                                             left: 10, right: 10),
//                                         hintText: '',
//                                       )),
//                                 ),
//                               ),
//                               const SizedBox(height: 20),
//                               Padding(
//                                 padding: const EdgeInsets.only(
//                                     right: 15, bottom: 20),
//                                 child: GestureDetector(
//                                   onTap: () {
//                                     setState(() {
//                                       showTicket = true;
//                                     });
//                                   },
//                                   child: Container(
//                                     height: 50,
//                                     width: width / 2.2,
//                                     decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(5),
//                                         color: const Color.fromRGBO(
//                                             112, 168, 49, 1)),
//                                     child: const Center(
//                                         child: Text('שמירת כרטיס',
//                                             textAlign: TextAlign.center,
//                                             style: TextStyle(
//                                                 color: Colors.white,
//                                                 fontSize: 17))),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     )
//                   : Container()
//             ],
//           ),
//         ),
//         const SizedBox(height: 25),
//       ],
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.only(
//             bottom: 100,
//             left: 20,
//             right: 20,
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               const SizedBox(height: 25),
//               ListView.builder(
//                 itemCount: ticketAddArray.length,
//                 physics: const NeverScrollableScrollPhysics(),
//                 shrinkWrap: true,
//                 itemBuilder: (context, index) {
//                   return addTicket(() {
//                     ticketAddArray.removeAt(index);
//                     setState(() {});
//                   }, () {
//                     editViewArray[index] = !editViewArray[index];
//                     height = editViewArray[index] ? 700 : 60;
//                     setState(() {});
//                   });
//                 },
//               ),
//               GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     ticketAddArray.add(1);
//                     editViewArray.add(true);
//                   });
//                 },
//                 child: Container(
//                   height: 50,
//                   width: width / 2,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(5),
//                       color: const Color.fromRGBO(112, 168, 49, 1)),
//                   child: const Center(
//                     child: Text(
//                       'הוספת כרטיס נוסף',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(color: Colors.white, fontSize: 17),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 25),
//               coupon == true
//                   ? Column(
//                       crossAxisAlignment: CrossAxisAlignment.end,
//                       children: [
//                           Padding(
//                             padding: const EdgeInsets.only(right: 15),
//                             child: Container(
//                               width: 220,
//                               decoration: BoxDecoration(
//                                   borderRadius: const BorderRadius.all(
//                                       Radius.circular(5)),
//                                   color: Colors.white,
//                                   border: Border.all(
//                                       color: const Color.fromRGBO(
//                                           216, 216, 216, 1))),
//                               child: TextField(
//                                   controller: discountCodeController,
//                                   maxLines: 1,
//                                   textAlignVertical: TextAlignVertical.top,
//                                   textAlign: TextAlign.end,
//                                   style: TextStyle(fontSize: 15),
//                                   decoration: InputDecoration(
//                                     border: InputBorder.none,
//                                     contentPadding:
//                                         EdgeInsets.only(left: 10, right: 10),
//                                     hintText: 'קוד קופון',
//                                   )),
//                             ),
//                           ),
//                           const SizedBox(height: 20),
//                           const Padding(
//                             padding: EdgeInsets.only(right: 15, left: 15),
//                             child: Text(
//                               'קוד הקופון צריך להכיל 5 תווים לפחות',
//                               textAlign: TextAlign.right,
//                               style: TextStyle(),
//                             ),
//                           ),
//                           const Padding(
//                             padding: EdgeInsets.only(right: 15, left: 15),
//                             child: Text(
//                               'נא להשתמש באותיות באנגלית ומספרים בלבד (ללא תווים מיוחדים)',
//                               textAlign: TextAlign.right,
//                               style: TextStyle(fontSize: 12),
//                             ),
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             //crossAxisAlignment: CrossAxisAlignment.end,
//                             children: [
//                               // const Text(
//                               //   '\$',
//                               //   style: TextStyle(
//                               //       fontWeight: FontWeight.bold, fontSize: 16),
//                               // ),
//                               Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 10, vertical: 10),
//                                 child: Container(
//                                   width: 120,
//                                   decoration: BoxDecoration(
//                                       borderRadius: const BorderRadius.all(
//                                           Radius.circular(5)),
//                                       color: Colors.white,
//                                       border: Border.all(
//                                           color: const Color.fromRGBO(
//                                               216, 216, 216, 1))),
//                                   child: TextField(
//                                       controller: discountAmountController,
//                                       maxLines: 1,
//                                       textAlignVertical: TextAlignVertical.top,
//                                       textAlign: TextAlign.end,
//                                       style: TextStyle(fontSize: 15),
//                                       decoration: InputDecoration(
//                                         border: InputBorder.none,
//                                         contentPadding: EdgeInsets.only(
//                                             left: 10, right: 10),
//                                         hintText: '5',
//                                       )),
//                                 ),
//                               ),
//                               const Text(
//                                 ':סכום ההנחה בשקלים',
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold, fontSize: 16),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 15),
//                           SizedBox(
//                             width: 170,
//                             child: MaterialButton(
//                               height: 50,
//                               onPressed: () {
//                                 setState(() {
//                                   coupon = false;
//                                 });
//                               },
//                               color: const Color.fromRGBO(233, 108, 96, 1),
//                               child: const Center(
//                                   child: Text(
//                                 'הסרת קופון',
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                     color: Colors.white, fontSize: 17),
//                               )),
//                             ),
//                           ),
//                         ])
//                   : Container(),
//               coupon == true
//                   ? SizedBox()
//                   : GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           coupon = true;
//                         });
//                       },
//                       child: Container(
//                         height: 40,
//                         width: width / 2.5,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(5),
//                             color: const Color.fromRGBO(112, 168, 49, 1)),
//                         child: const Center(
//                             child: Text('הוספת קופון הנחה',
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                     color: Colors.white, fontSize: 17))),
//                       ),
//                     ),
//               SizedBox(
//                 height: 50,
//               ),
//               Center(
//                 child: GestureDetector(
//                   onTap: () {
//                     application.previewTicketProvider =
//                         ticketPriceController.text;
//                     application.validate();
//                     _createEventNetwork.postCreateEventsTicket(context);
//                     _createEventNetwork.postCreateEventsTicketCoupon(context);
//                   },
//                   child: Container(
//                     height: 50,
//                     width: width / 2.5,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(5),
//                         color: const Color.fromRGBO(112, 168, 49, 1)),
//                     child: const Center(
//                         child: Text(
//                       'שמירה והמשך',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(color: Colors.white, fontSize: 17),
//                     )),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
