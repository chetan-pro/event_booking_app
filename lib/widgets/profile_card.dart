// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, must_be_immutable
import 'package:basalon/network/get_events_network.dart';
import 'package:basalon/screens/activity/receiving_activity_screen.dart';
import 'package:basalon/services/constant.dart';
import 'package:basalon/services/my_color.dart';
import 'package:basalon/widgets/custom_buttons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../blocs/application_bloc.dart';

class ProfileCard extends StatefulWidget {
  ProfileCard({
    required this.content,
    required this.title,
    required this.image,
    required this.showCircleAvatar,
    this.eventId,
  });

  String content;
  String title;
  String image;
  bool showCircleAvatar;

  String? eventId;

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  late final application = Provider.of<ApplicationBloc>(context);
  bool showMail = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  FetchEventData _fetchEventData = FetchEventData();

  @override
  Widget build(BuildContext context) {
    print('widget.eventId');
    print(widget.eventId);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        // padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                // mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                textDirection: TextDirection.rtl,
                children: [
                  widget.showCircleAvatar == true
                      ? ClipOval(
                          child: Image.network(
                            widget.image,
                            errorBuilder: (stacktrace, exception, c) {
                              return Image.asset(
                                'assets/images/dummy_user.png',
                                height: 70,
                                width: 70,
                              );
                            },
                            height: 70,
                            width: 70,
                            fit: BoxFit.fill,
                          ),
                        )
                      : Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          child: application.previewAuthorImagerovider != null
                              ? Image.file(
                                  application.previewAuthorImagerovider,
                                  fit: BoxFit.fill,
                                  height: 70,
                                  width: 70,
                                )
                              : Image.asset('assets/images/dummy_user.png')),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      widget.title,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Divider(
                thickness: 1,
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  widget.content,
                  textAlign: TextAlign.start,
                  textDirection: TextDirection.rtl,
                  style: ktextStyle,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              if (showMail == true)
                Column(
                  children: [
                    SizedBox(height: 20),
                    ReceivingPaymentFields(
                      controller: nameController,
                      obscureText: false,
                      hintText: 'שם מלא',
                    ),
                    SizedBox(height: 20),
                    ReceivingPaymentFields(
                      controller: emailController,
                      obscureText: false,
                      hintText: 'דואר אלקטורני',
                    ),
                    SizedBox(height: 20),
                    ReceivingPaymentFields(
                      controller: phoneController,
                      obscureText: false,
                      hintText: 'טלפון נייד',
                    ),
                    SizedBox(height: 20),
                    ReceivingPaymentFields(
                      controller: subjectController,
                      obscureText: false,
                      hintText: 'נושא',
                    ),
                    SizedBox(height: 20),
                    ReceivingPaymentFields(
                      controller: contentController,
                      obscureText: false,
                      maxLine: 8,
                      hintText: 'תוכן ההודעה',
                    ),
                    SizedBox(height: 20),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Center(
                        child: CustomButton(
                            onPressed: () async {
                              setState(() {
                                showMail = true;
                              });
                              await _fetchEventData.sendEmailToAuthor(
                                context,
                                widget.eventId,
                                nameController.text,
                                emailController.text,
                                phoneController.text,
                                subjectController.text,
                                contentController.text,
                              );
                            },
                            isOutlinedButton: true,
                            outlineColor: MyColors.topOrange,
                            width: 150,
                            text: 'שלחו הודעה',
                            textStyle: TextStyle(color: MyColors.topOrange),
                            icon: Icons.mail_outline,
                            iconColor: MyColors.topOrange),
                      ),
                    )
                  ],
                ),
              SizedBox(height: 20),
              if (showMail == false)
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Center(
                    child: CustomButton(
                        onPressed: () {
                          setState(() {
                            showMail = true;
                          });
                        },
                        isOutlinedButton: true,
                        outlineColor: MyColors.topOrange,
                        width: 150,
                        text: 'שלחו הודעה',
                        textStyle: TextStyle(color: MyColors.topOrange),
                        icon: Icons.mail_outline,
                        iconColor: MyColors.topOrange),
                  ),
                )
            ],
          ),
        ),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(3),
              topRight: Radius.circular(3),
              bottomLeft: Radius.circular(3),
              bottomRight: Radius.circular(3)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 4,
              blurRadius: 3,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
      ),
    );
  }
}
