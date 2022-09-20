import 'package:basalon/screens/activity/receiving_activity_screen.dart';
import 'package:basalon/services/constant.dart';
import 'package:basalon/services/my_color.dart';
import 'package:basalon/widgets/custom_buttons.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/link.dart';

import '../../network/contact_network.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  late double width = MediaQuery.of(context).size.width;

  @override
  void initState() {
    super.initState();
    _contactNetWork.getContact();
    Future.delayed(Duration(seconds: 2), () {
      setState(() {});
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  final ContactNetWork _contactNetWork = ContactNetWork();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 100, right: 10, left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_new_outlined,
                      )),
                  Text(
                    _contactNetWork.contact?.data?[0].title ?? 'צרו איתנו קשר',
                    style: ktextStyleLarge,
                  ),
                ],
              ),
              SizedBox(
                width: 50,
                child: Divider(
                  color: MyColors.topOrange,
                  thickness: 2,
                ),
              ),
              Link(
                uri: Uri.parse('tel:0506871111'),
                builder: (BuildContext context,
                    Future<void> Function()? followLink) {
                  return ListTile(
                    onTap: followLink,
                    dense: true,
                    title: Text(
                      _contactNetWork.contact?.data?[0].phone ?? '0506871111',
                      textDirection: TextDirection.rtl,
                      style: ktextStyle,
                    ),
                    trailing: Icon(
                      Icons.phone_enabled_outlined,
                      color: MyColors.topOrange,
                    ),
                  );
                },
              ),
              Link(
                uri: Uri.parse('mailto:info@basalon.co.il'),
                builder: (BuildContext context,
                    Future<void> Function()? followLink) {
                  return ListTile(
                    onTap: followLink,
                    dense: true,
                    title: Text(
                      _contactNetWork.contact?.data?[0].email ??
                          'info@basalon.co.il',
                      textDirection: TextDirection.rtl,
                      style: ktextStyle,
                    ),
                    trailing: Icon(
                      Icons.mail_outline_sharp,
                      color: MyColors.topOrange,
                    ),
                  );
                },
              ),
              ListTile(
                dense: true,
                title: Text(
                  _contactNetWork.contact?.data?[0].address ??
                      'שינקין 44, גבעתיים',
                  textDirection: TextDirection.rtl,
                  style: ktextStyle,
                ),
                trailing: Icon(
                  Icons.location_on,
                  color: MyColors.topOrange,
                ),
              ),
              Text(
                _contactNetWork.contact?.data?[0].mainTitle ??
                    'אפשר גם מכאן 🙂',
                style: ktextStyleLarge,
                textDirection: TextDirection.rtl,
              ),
              Container(
                width: 50,
                child: Divider(
                  color: MyColors.topOrange,
                  thickness: 2,
                ),
              ),
              Directionality(
                  textDirection: TextDirection.rtl,
                  child: ReceivingPaymentFields(
                    controller: nameController,
                    obscureText: false,
                    hintText: '?מה שמך',
                    suffixIcon: Icon(
                      FontAwesomeIcons.user,
                      color: MyColors.topOrange,
                      size: 20,
                    ),
                  )),
              const SizedBox(height: 30),
              Directionality(
                  textDirection: TextDirection.rtl,
                  child: ReceivingPaymentFields(
                    controller: emailController,
                    obscureText: false,
                    hintText: 'דואר אלקטרוני',
                    suffixIcon: Icon(
                      Icons.mail_outline_sharp,
                      color: MyColors.topOrange,
                      size: 20,
                    ),
                  )),
              const SizedBox(height: 30),
              Directionality(
                  textDirection: TextDirection.rtl,
                  child: ReceivingPaymentFields(
                    controller: messageController,
                    obscureText: false,
                    hintText: 'ההודעה שלך',
                    maxLine: 8,
                  )),
              const SizedBox(height: 30),
              Align(
                alignment: Alignment.centerLeft,
                child: CustomButton(
                  onPressed: () async {
                    await _contactNetWork.postContact(nameController.text,
                        emailController.text, messageController.text, context);
                  },
                  outlineColor: MyColors.topOrange,
                  isOutlinedButton: true,
                  width: width / 3,
                  text: 'שלח/י הודעה',
                  textStyle: TextStyle(color: MyColors.topOrange),
                  radius: 0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
