// ignore_for_file: must_be_immutable, unused_field

import 'package:basalon/network/create_event_network.dart';
import 'package:basalon/screens/home_screen.dart';
import 'package:basalon/screens/preview/preview_event_detail.dart';
import 'package:basalon/services/constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../blocs/application_bloc.dart';

class ReceivingActivityScreen extends StatefulWidget {
  @override
  _ReceivingActivityScreenState createState() =>
      _ReceivingActivityScreenState();
}

class _ReceivingActivityScreenState extends State<ReceivingActivityScreen> {
  late final application = Provider.of<ApplicationBloc>(context);

  late double width = MediaQuery.of(context).size.width;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  void errorAlertMessage() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Event Created Successfully!'),
        content: Text('Waiting for approval'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context, rootNavigator: true)
                .push(MaterialPageRoute(builder: (context) => HomeScreen())),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void validate() {
    if (formkey.currentState!.validate()) {
      print('VALIDATED');
      errorAlertMessage();
    } else {
      print('Not Valid');
    }
  }

  TextEditingController bankBranchController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();
  TextEditingController bankNumberController = TextEditingController();
  TextEditingController bankOwnerController = TextEditingController();

  late CreateEventNetwork _createEventNetwork = CreateEventNetwork(
    bankBranchController: bankBranchController.text,
    bankNameController: bankNameController.text,
    bankNumberController: bankNumberController.text,
    bankOwnerController: bankOwnerController.text,
  );

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(height: 25),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'פרטי חשבון בנק',
                          style: ktextStyleBoldMedium,
                          textDirection: TextDirection.rtl,
                        ),
                        Text(
                          '(על מנת שנוכל להעביר לכם את התשלום)',
                          style: ktextStyle,
                          textDirection: TextDirection.rtl,
                        ),
                      ],
                    )

                    // RichText(
                    //   textDirection: TextDirection.rtl,
                    //   text: TextSpan(
                    //       text: 'פרטי חשבון בנק',
                    //       style: ktextStyleBoldMedium,
                    //       children: [
                    //         TextSpan(
                    //             text: '(על מנת שנוכל להעביר לכם את התשלום)',
                    //             style: TextStyle(
                    //               fontWeight: FontWeight.w300,
                    //               fontSize: 16,
                    //             ))
                    //       ]),
                    // ),

                    // Text(
                    //     'פרטי חשבון בנק (על מנת שנוכל להעביר לכם את התשלום)',
                    //     textAlign: TextAlign.end),
                    ),
              ),
              const SizedBox(height: 20),
              Form(
                key: formkey,
                child: Column(
                  children: [
                    ReceivingPaymentFields(
                      controller: bankOwnerController,
                      obscureText: false,
                      label: 'שם בעל/ת חשבון',
                      showRequired: true,

                      // hintText: 'Account Holder Name',
                    ),
                    const SizedBox(height: 20),
                    ReceivingPaymentFields(
                      controller: bankNumberController,
                      obscureText: false,
                      label: 'מספר חשבון',
                      showRequired: true,

                      // hintText: 'Account Number',
                    ),
                    const SizedBox(height: 20),
                    ReceivingPaymentFields(
                      controller: bankNameController,
                      obscureText: false,
                      label: 'שם הבנק',
                      showRequired: true,

                      // hintText: 'Bank Name',
                    ),
                    const SizedBox(height: 20),
                    ReceivingPaymentFields(
                      controller: bankBranchController,
                      obscureText: false,
                      label: 'סניף',
                      showRequired: true,

                      // hintText: 'Branch',
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),

              // Padding(
              //   padding: const EdgeInsets.only(left: 15, right: 15),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.end,
              //     children: [
              //       const Text('* Account Holder Name'),
              //       const SizedBox(height: 10),
              //       Container(
              //         decoration: BoxDecoration(
              //             borderRadius:
              //                 const BorderRadius.all(Radius.circular(5)),
              //             border: Border.all(
              //                 color: const Color.fromRGBO(216, 216, 216, 1))),
              //         child: const TextField(
              //             maxLines: 1,
              //             textAlignVertical: TextAlignVertical.top,
              //             textAlign: TextAlign.end,
              //             style: TextStyle(fontSize: 15),
              //             decoration: InputDecoration(
              //               border: InputBorder.none,
              //               contentPadding:
              //                   EdgeInsets.only(left: 10, right: 10),
              //               hintText: 'Account Holder Name',
              //             )),
              //       ),
              //     ],
              //   ),
              // ),
              // const SizedBox(height: 20),
              // Padding(
              //   padding: const EdgeInsets.only(left: 15, right: 15),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.end,
              //     children: [
              //       const Text('* Account Number'),
              //       const SizedBox(height: 10),
              //       Container(
              //         decoration: BoxDecoration(
              //             borderRadius:
              //                 const BorderRadius.all(Radius.circular(5)),
              //             border: Border.all(
              //                 color: const Color.fromRGBO(216, 216, 216, 1))),
              //         child: const TextField(
              //             maxLines: 1,
              //             textAlignVertical: TextAlignVertical.top,
              //             textAlign: TextAlign.end,
              //             style: TextStyle(fontSize: 15),
              //             decoration: InputDecoration(
              //               border: InputBorder.none,
              //               contentPadding:
              //                   EdgeInsets.only(left: 10, right: 10),
              //               hintText: 'Account Number',
              //             )),
              //       ),
              //     ],
              //   ),
              // ),
              // const SizedBox(height: 20),
              // Padding(
              //   padding: const EdgeInsets.only(left: 15, right: 15),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.end,
              //     children: [
              //       const Text('* The Bank Name'),
              //       const SizedBox(height: 10),
              //       Container(
              //         decoration: BoxDecoration(
              //             borderRadius:
              //                 const BorderRadius.all(Radius.circular(5)),
              //             border: Border.all(
              //                 color: const Color.fromRGBO(216, 216, 216, 1))),
              //         child: const TextField(
              //             maxLines: 1,
              //             textAlignVertical: TextAlignVertical.top,
              //             textAlign: TextAlign.end,
              //             style: TextStyle(fontSize: 15),
              //             decoration: InputDecoration(
              //               border: InputBorder.none,
              //               contentPadding:
              //                   EdgeInsets.only(left: 10, right: 10),
              //               hintText: 'The Bank Name',
              //             )),
              //       ),
              //     ],
              //   ),
              // ),
              // const SizedBox(height: 20),
              // Padding(
              //   padding: const EdgeInsets.only(left: 15, right: 15),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.end,
              //     children: [
              //       const Text('* Branch'),
              //       const SizedBox(height: 10),
              //       Container(
              //         decoration: BoxDecoration(
              //             borderRadius:
              //                 const BorderRadius.all(Radius.circular(5)),
              //             border: Border.all(
              //                 color: const Color.fromRGBO(216, 216, 216, 1))),
              //         child: const TextField(
              //             maxLines: 1,
              //             textAlignVertical: TextAlignVertical.top,
              //             textAlign: TextAlign.end,
              //             style: TextStyle(fontSize: 15),
              //             decoration: InputDecoration(
              //               border: InputBorder.none,
              //               contentPadding:
              //                   EdgeInsets.only(left: 10, right: 10),
              //               hintText: 'Branch',
              //             )),
              //       ),
              //     ],
              //   ),
              // ),
              // const SizedBox(height: 25),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Visibility(
                    visible: application.showPreview,
                    replacement: SizedBox(
                      width: 100,
                    ),
                    child: Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PreviewEventDetailScreen()));
                        },
                        child: Container(
                          height: 80,
                          // width: 180,
                          padding: EdgeInsets.symmetric(vertical: 15),

                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: const Color.fromRGBO(112, 168, 49, 1)),
                          child: const Center(
                              child: Text(
                            ' תצוגה מקדימה של הפעילות',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          )),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        validate();
                        // _createEventNetwork.postCreateEventsUserPayment(
                        //   context,
                        //   LoginUser.shared?.userId! ??
                        //       application.idFromLocalProvider,
                        // );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        height: 80,
                        // width: 180,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: const Color.fromRGBO(112, 168, 49, 1)),
                        child: const Center(
                            child: Text(
                          'העברת פעילות לבדיקה',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        )),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReceivingPaymentFields extends StatelessWidget {
  ReceivingPaymentFields({
    this.label,
    this.hintText,
    required this.obscureText,
    this.prefixIcon,
    this.height,
    this.controller,
    this.maxLine,
    this.showRequired,
    this.suffixIcon,
    this.onTap,
    this.colors,
    this.width,
    this.textColor,
    this.onChange,
    this.onFieldSubmit,
    this.isBorder = true,
    this.textColorPrimary,
    this.showLabel,
    this.isFocus,
    this.fillcolor,
  });

  final String? label;
  double? height;
  final TextEditingController? controller;
  final String? hintText;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final maxLine;
  bool? showRequired;
  dynamic onTap;
  dynamic fillcolor;
  dynamic colors;
  dynamic textColor;
  dynamic textColorPrimary;
  dynamic onChange;
  dynamic onFieldSubmit;

  double? width;
  bool? isBorder;
  bool? showLabel = true;
  bool? isFocus = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: colors,
      child: Row(
        textDirection: TextDirection.rtl,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          showLabel == true
              ? Expanded(
                  flex: 1,
                  child: RichText(
                    // textAlign: TextAlign.end,
                    text: TextSpan(
                        text: showRequired == true ? '*' : '',
                        style: TextStyle(color: Colors.red),
                        children: <TextSpan>[
                          TextSpan(
                              text: label,
                              style: TextStyle(color: Colors.black)),
                        ]),
                  ),
                )
              : SizedBox(),
          Expanded(
            child: TextFormField(
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
              onFieldSubmitted: onFieldSubmit,
              onChanged: onChange,
              onTap: onTap,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '*field is required';
                } else {
                  return null;
                }
              },
              obscureText: obscureText,
              maxLines: maxLine,
              textAlignVertical: TextAlignVertical.top,
              // textAlign: TextAlign.end,
              controller: controller,
              style: TextStyle(color: textColorPrimary ?? Colors.black),
              decoration: InputDecoration(
                border: isBorder == true
                    ? OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none,
                        // (
                        //     width: 0, color: Color.fromRGBO(216, 216, 216, 1))
                      )
                    : null,
                contentPadding: EdgeInsets.only(left: 10, right: 10, top: 12),
                hintText: hintText,
                filled: true,
                fillColor: fillcolor ?? Colors.white,
                hintStyle: TextStyle(color: textColor ?? Colors.black),
                prefixIcon: prefixIcon,
                suffixIcon: suffixIcon,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ReceivingPaymentFieldColumn extends StatelessWidget {
  ReceivingPaymentFieldColumn(
      {this.label,
      this.hintText,
      required this.obscureText,
      this.prefixIcon,
      // this.height,
      this.controller,
      this.onChange,
      this.onFieldSubmit,
      this.showRequired});

  final String? label;

  // int? height;
  final TextEditingController? controller;
  final String? hintText;
  final bool obscureText;
  final Widget? prefixIcon;
  dynamic onChange;
  dynamic onFieldSubmit;
  bool? showRequired;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          RichText(
            text: TextSpan(
                text: showRequired == false ? '' : '*',
                style: TextStyle(color: Colors.red),
                children: <TextSpan>[
                  TextSpan(
                      text: label,
                      style: TextStyle(color: Colors.black, fontSize: 15)),
                ]),
          ),
          SizedBox(
            height: 5,
          ),
          TextFormField(
            // inputFormatters: [
            //   TextInputFormatter.withFunction((oldValue, newValue) {
            //     return TextEditingValue(text: 'XXXX');
            //   })
            // ],
            onFieldSubmitted: onFieldSubmit,
            onChanged: onChange,
            validator: (value) {
              if (value!.isEmpty) {
                return '*field is required';
              } else {
                return null;
              }
            },
            obscureText: obscureText,
            maxLines: 1,
            textAlignVertical: TextAlignVertical.top,
            textAlign: TextAlign.end,
            controller: controller,
            style: TextStyle(fontSize: 15),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 0, color: Color.fromRGBO(216, 216, 216, 1))),
              contentPadding: EdgeInsets.only(left: 10, right: 10),
              hintText: hintText,
              prefixIcon: prefixIcon,
            ),
          ),
        ],
      ),
    );
  }
}
