// ignore_for_file: import_of_legacy_library_into_null_safe, must_be_immutable

import 'package:basalon/network/place_order_network.dart';
import 'package:basalon/screens/activity/receiving_activity_screen.dart';
import 'package:basalon/services/constant.dart';
import 'package:basalon/services/my_color.dart';
import 'package:basalon/widgets/side_drawer.dart';
import 'package:dio/dio.dart';
// import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../blocs/application_bloc.dart';

class CheckoutPage extends StatefulWidget {
  CheckoutPage({
    required this.totalAmount,
    required this.email,
    required this.eventDate,
    required this.eventTitle,
    required this.fullName,
    required this.mobileNumber,
    required this.nOofTicketInstance,
    required this.numOfTicket,
    required this.userId,
    required this.eventID,
    this.couponCode,
    this.totalAfterTax,
    this.couponAmount,
    required this.formattedDate,
    this.initialPrice,
  });

  var initialPrice;
  String eventTitle;
  String eventDate;
  String formattedDate;
  String fullName;
  String mobileNumber;
  String email;
  List totalAmount;
  List? nOofTicketInstance;
  List numOfTicket;
  dynamic userId;
  dynamic eventID;
  dynamic couponCode;
  dynamic couponAmount;
  dynamic totalAfterTax;

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

bool isClickable = true;

class _CheckoutPageState extends State<CheckoutPage> {
  late final PlaceOrderNetwork _placeOrderNetwork = PlaceOrderNetwork(
    userPhone: widget.mobileNumber,
    userId: widget.userId,
    userEmail: widget.email,
    userAddress: '',
    userFullname: widget.fullName,
    ticketId: widget.nOofTicketInstance,
    totalAmount: widget.totalAmount,
    numOfTicket: widget.numOfTicket,
    productId: widget.eventID,
    couponCode: widget.couponCode,
    couponAmount: widget.couponAmount,
    totalAfterTax: widget.totalAfterTax,
    eventTax: '0',
    formatDate: widget.formattedDate,
  );
  final cardDate = kdateList;
  String? selectCardDate;
  String? startingTime;
  String? endTime;
  final cardMonth = kmonthList;
  bool checkBoxValue = true;
  bool saveCard = true;

  Future cardComApi() async {
    print("popopopop");
    print(cardValueChange);
    print(temp);
    print(cardNumberController.text);
    var dio = Dio();
    try {
      Response response;
      var totalAmount = widget.totalAmount.fold(
          0,
          (previousValue, element) =>
              int.parse(previousValue.toString()) + element);
      response = await dio.post(
        'https://secure.cardcom.solutions/Interface/Direct2.aspx?TerminalNumber=130735&Sum=$totalAmount&cardnumber=${cardValueChange == false ? temp : cardNumberController.text}&cardvalidityyear=$endTime&cardvaliditymonth=$startingTime&username=rq6xvee8hxRaDewuTQT7&Languages=en&coinid=1&codpage=65001&Cvv=${cvvController.text}&CardOwnerName=${holderController.text}',
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );
      print(response);
      String status = response.data;
      print(status);
      print(widget.totalAmount.fold(
          0,
          (previousValue, element) =>
              int.parse(previousValue.toString()) + element));
      print(cardNumberController.text);
      print(endTime);
      print(startingTime);
      print(cvvController.text);
      print(status.split(' ').first.contains('ResponseCode=0'));
      if (status.split(' ').first.contains('ResponseCode=0')) {
        await _placeOrderNetwork.placeOrder(context, checkBoxValue);
      } else {
        EasyLoading.dismiss();
        errorAlertMessage(context, 'Invalid Credentials!');
      }
    } catch (e) {
      print(e);
    }
  }

  void errorAlertMessage(BuildContext context, String errorMsg) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(errorMsg),
        // content: Text('Waiting for approval'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
      ));

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    isClickable = true;
    print('dispose dispose');
  }

  // var translator = MaskedTextController.getDefaultTranslator();

  // static final facebookAppEvents = FacebookAppEvents();

  late var controller =
      MaskedTextController(mask: '0000000000000000', text: 'XXXX-XXXX-XXXX');
  late final application = Provider.of<ApplicationBloc>(context, listen: false);
  cardToStar(val) {
    print("kitne no  ka hso");
    print(val);
    val = '************' + val.substring(12, val.length);
    return val;
  }

  var temp;
  bool cardValueChange = false;
  @override
  void initState() {
    super.initState();
    isClickable = true;

    print('init init');
    holderController.text = application.cardHolderProvider ?? '';
    cardNumberController.text = application.cardNumberProvider ?? '';
    cvvController.text = application.cardCvvProvider ?? '';
    startingTime = application.cardMonthProvider ?? '';
    endTime = application.cardYearProvider ?? '';

    temp = cardNumberController.text;

    print("memax2");
    print(cardValueChange);
    print(cardNumberController.text);

    if (cardNumberController.text != null && cardNumberController.text != "") {
      cardNumberController.text = cardToStar(temp);
      print("is card change");
      print(cardNumberController.text);
      print(temp);
    }
  }

  TextEditingController holderController = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  late String fakecardVale;

  @override
  Widget build(BuildContext context) {
    print('endTime');
    print(application.getUserDataProfileProvider?.data?.authorImage);
    print(widget.nOofTicketInstance);
    print(startingTime);
    print(widget.formattedDate);
    var counts = widget.numOfTicket.fold(
        0,
        (previousValue, element) =>
            int.parse(previousValue.toString()) + element);
    var finalPrice = widget.totalAmount.fold(
        int.parse(widget.initialPrice.toString()),
        (previousValue, element) =>
            int.parse(previousValue.toString()) + element);
    return Scaffold(
      backgroundColor: Colors.white,
      endDrawer: NavDrawer(),
      appBar: AppBar(
        toolbarHeight: 70,
        centerTitle: true,
        backgroundColor: MyColors.purpleAppbar,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new_outlined,
            )),
        // leading: (isUserLogin(application.isUserLogin) &&
        //                               application.getUserDataProfileProvider
        //                                       ?.data?.authorImage !=
        //                                   null)
        //     ? Padding(
        //         padding: const EdgeInsets.all(8.0),
        //         child: CircleAvatar(
        //           backgroundImage:
        //               // AssetImage(
        //               //     'assets/images/dummy_user.png'),

        //               NetworkImage(
        //                                   application.getUserDataProfileProvider
        //                                               ?.data?.authorImage !=
        //                                           ''
        //                                       ? application
        //                                           .getUserDataProfileProvider
        //                                           ?.data
        //                                           ?.authorImage
        //                                       : application.imageFromFacebook ??
        //                                           'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png',
        //                                 ),
        //           backgroundColor: Colors.grey.shade600,
        //         ),
        //       )
        //     : SizedBox(),
        title: Container(
          child: Image.asset(
            kLogoImage,
            fit: BoxFit.fill,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: Text(
                "פרטי ההזמנה",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Table(
                border: TableBorder.all(width: 1, color: Colors.grey),
                columnWidths: {
                  0: FlexColumnWidth(2),
                  1: FlexColumnWidth(8),
                },
                children: [
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Column(children: [
                        Text(
                          'סכום ביניים',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center,
                        ),
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 5),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('מוצר',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold))
                          ]),
                    ),
                  ]),
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 100),
                      child: Center(
                          child: Text('₪${finalPrice}',
                              style: TextStyle(fontSize: 20.0))),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 5),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          textDirection: TextDirection.rtl,
                          children: [
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: RichText(
                                  text: TextSpan(
                                    text: "${widget.eventTitle}  ",
                                    style: ktextStyle,
                                    children: [
                                      TextSpan(
                                        text: '${counts}x',
                                        style: ktextStyleBold,
                                      ),
                                    ],
                                  ),
                                  textDirection: TextDirection.rtl,
                                )),
                            checkoutDetails(":תאריך", "${widget.eventDate}"),
                            checkoutDetails(":שם מלא", "${widget.fullName}"),
                            checkoutDetails(
                                ":טלפון נייד", "${widget.mobileNumber}"),
                            checkoutDetails(":אימייל", "${widget.email}"),
                            for (int i = 0;
                                i < widget.nOofTicketInstance!.length;
                                i++)
                              checkoutDetails(":סוג כרטיס",
                                  "${widget.nOofTicketInstance?[i].nameTicket}: ${widget.numOfTicket[i]}"),
                            // checkoutDetails(":סוג כרטיס", "ילד מגיל 7-18 כמות: 2"),
                          ]),
                    ),
                  ]),
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Column(children: [
                        Text(
                          '₪${finalPrice}',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 5),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('סכום ביניים',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold))
                          ]),
                    ),
                  ]),
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Column(children: [
                        Text(
                          '₪${finalPrice}',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 5),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('סה"כ',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold))
                          ]),
                    ),
                  ]),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: CheckboxListTile(
                dense: true,
                visualDensity: VisualDensity.lerp(
                    VisualDensity.compact, VisualDensity.compact, 0.0),
                title: Transform.translate(
                  offset: Offset(10, 0),
                  child: Text(
                    "שלחו לי פעילויות מעניינות והטבות",
                    style: ktextStyle,
                    textAlign: TextAlign.end,
                  ),
                ),
                contentPadding: EdgeInsets.zero,
                value: checkBoxValue,
                onChanged: (value) {
                  setState(() {
                    if (checkBoxValue) {
                      checkBoxValue = false;
                    } else {
                      checkBoxValue = true;
                    }
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'תשלום מאובטח',
                textAlign: TextAlign.center,
                style: ktextStyleLarge,
              ),
            ),
            paymentCard(),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  Widget checkoutDetails(keys, values) {
    return Container(
      margin: const EdgeInsets.only(right: 10, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              values,
              textDirection: TextDirection.rtl,
            ),
          ),
          const SizedBox(width: 2),
          Text(
            keys,
            style: const TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  String showThisValue = '';

  Widget paymentCard() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300, width: 2)),
      padding: EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            height: 200,
            child: Stack(
              children: [
                Positioned(
                  right: 0,
                  child: SizedBox(
                    height: 80,
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: ReceivingPaymentFieldColumn(
                      obscureText: false,
                      label: 'שם בעל הכרטיס',
                      controller: holderController,
                      showRequired: false,
                    ),
                  ),
                ),
                Positioned(
                  right: 140,
                  top: 95,
                  child: SizedBox(
                    height: 60,
                    width: 150,
                    child: Image.asset("assets/images/payment-logo.png"),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: SizedBox(
                    height: 80,
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: ReceivingPaymentFieldColumn(
                      obscureText: false,
                      label: 'מספר כרטיס אשראי',
                      controller: cardNumberController,
                      showRequired: false,
                      onChange: (String val) {
                        if (val.length < 8) {
                          for (int i = 0; i <= val.length; i++) {
                            showThisValue = val;
                          }
                        }

                        if (!cardValueChange) {
                          cardNumberController.text = '';
                        }
                        cardValueChange = true;

                        print(val.length);
                        print(showThisValue);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          CheckboxListTile(
            dense: true,
            visualDensity: VisualDensity.lerp(
                VisualDensity.compact, VisualDensity.compact, 0.0),
            title: Transform.translate(
              offset: Offset(20, 0),
              child: Text(
                "שמירת פרטי הכרטיס לרכישה הבאה",
                style: ktextStyle,
                textAlign: TextAlign.end,
              ),
            ),
            contentPadding: EdgeInsets.zero,
            value: saveCard,
            onChanged: (value) {
              setState(() {
                if (saveCard) {
                  saveCard = false;
                } else {
                  saveCard = true;
                }
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    const Text(
                      "3 ספרות בגב הכרטיס",
                      textDirection: TextDirection.rtl,
                      style: TextStyle(fontSize: 15),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width / 3,
                      child: TextFormField(
                        controller: cvvController,
                        textAlign: TextAlign.right,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'קוד אבטחה',
                            hintStyle:
                                TextStyle(fontSize: 12, color: Colors.black)),
                      ),
                    )
                  ],
                ),
                Container(
                  width: 80,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      border: Border.all(
                          color: const Color.fromRGBO(216, 216, 216, 1))),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: DropdownButtonHideUnderline(
                      child: ButtonTheme(
                        child: DropdownButton(
                          isExpanded: true,
                          menuMaxHeight: 300,
                          hint: endTime == null
                              ? const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'שנה',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12),
                                    maxLines: 1,
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    endTime!,
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ),
                          style: const TextStyle(color: Colors.black),
                          items: cardDate.map(
                            (val) {
                              return DropdownMenuItem<String>(
                                value: val,
                                child: Text(val),
                              );
                            },
                          ).toList(),
                          onChanged: (val) {
                            setState(
                              () {
                                endTime = val as String?;
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "תוקף כרטיס",
                      style: TextStyle(fontSize: 15),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: 80,
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                          border: Border.all(
                              color: const Color.fromRGBO(216, 216, 216, 1))),
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: DropdownButtonHideUnderline(
                          child: ButtonTheme(
                            child: DropdownButton(
                              isExpanded: true,
                              menuMaxHeight: 300,
                              hint: startingTime == null
                                  ? const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        'חודש',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 12),
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        startingTime!,
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                    ),
                              style: const TextStyle(color: Colors.black),
                              items: cardMonth.map(
                                (val) {
                                  return DropdownMenuItem<String>(
                                    value: val,
                                    child: Text(val),
                                  );
                                },
                              ).toList(),
                              onChanged: (val) {
                                setState(
                                  () {
                                    startingTime = val as String?;
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
            child: GestureDetector(
              onTap: () async {
                final SharedPreferences sharedPreferences =
                    await SharedPreferences.getInstance();
                print(
                    '????????????????????????/*/*/*/*/*/*/*/**/*/*/*/*/*/*/*/');
                //EasyLoading.show();
                cardComApi();
                setState(() {
                  isClickable = false;
                  if (saveCard) {
                    sharedPreferences.setString(
                        'cardHolder', holderController.text);
                    sharedPreferences.setString(
                        'cardNumber',
                        cardValueChange == false
                            ? temp
                            : cardNumberController.text);
                    sharedPreferences.setString(
                        'cardMonth', startingTime ?? '');
                    sharedPreferences.setString('cardYear', endTime ?? '');
                    sharedPreferences.setString('cardCvv', cvvController.text);
                    application.cardHolderProvider =
                        sharedPreferences.getString('cardHolder');
                    application.cardNumberProvider =
                        sharedPreferences.getString('cardNumber');
                    application.cardMonthProvider =
                        sharedPreferences.getString('cardMonth');
                    application.cardYearProvider =
                        sharedPreferences.getString('cardYear');
                    application.cardCvvProvider =
                        sharedPreferences.getString('cardCvv');
                  }
                });
              },
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(232, 108, 96, 1),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Center(
                  child: Text(
                    "ביצוע הזמנה",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/pciLogo.png",
                height: 35,
                width: 81,
              ),
              Image.asset(
                "assets/images/cardlogoHe.png",
                height: 35,
                width: 98,
              )
            ],
          ),
        ],
      ),
    );
  }
}
