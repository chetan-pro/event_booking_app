import 'package:basalon/constant/login_user.dart';
import 'package:basalon/modal/get_event_detail_data.dart';
import 'package:basalon/modal/get_user_data.dart';
import 'package:basalon/network/place_order_network.dart';
import 'package:basalon/screens/join_events/checkout_page.dart';
import 'package:basalon/services/my_color.dart';
import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dotted_line/dotted_line.dart';
// import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../blocs/application_bloc.dart';
import '../../constant/login_user.dart';
import '../../services/constant.dart';
import '../../utils/utils.dart';
import '../../widgets/side_drawer.dart';

class BookEventPage extends StatefulWidget {
  BookEventPage({
    this.title,
    this.id,
    required this.date,
    this.mapAdress,
    this.thumbnailImage,
    this.noOfTicket,
  });

  String? thumbnailImage;
  String? title;
  BookingDate? date;
  String? mapAdress;
  List? noOfTicket;
  dynamic id;

  @override
  State<BookEventPage> createState() => _BookEventPageState();
}

class _BookEventPageState extends State<BookEventPage> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final phoneNoController = TextEditingController();
  final descriptionController = TextEditingController();
  final couponController = TextEditingController();

  bool checkBoxValue = true;
  bool showDiscountField = false;
  GetUserData? getUserData;
  late final application = Provider.of<ApplicationBloc>(context, listen: false);
  final PlaceOrderNetwork _placeOrderNetwork = PlaceOrderNetwork();
  dynamic username;
  dynamic authorImage;
  dynamic username2;
  dynamic email;
  dynamic mobileNumber;
  late List<int> ticketCount = [];
  List<int> finalPrice = [];

  bool showtitle = true;

  void getProfileData() async {
    try {
      Response response;
      var dio = Dio();
      response = await dio.post(
        'https://basalon.co.il/wp-json/wp/v2/get_user_profile',
        data: FormData.fromMap({
          'user_id':
              '${LoginUser.shared?.userId! ?? application.idFromLocalProvider}'
        }),
        options: Options(headers: {
          "Client-Service": "basalon-client-t1T83YHm60J8yNG5",
          "Auth-Key": "XkCRn9Y4PPmspuqYKolqbyhcDFhID7kl"
        }),
      );
      // print('LoginUser.shared?.userId ${LoginUser.shared?.userId}');
      if (response.data['success'] == 401) {
        // errorAlertMessage('No Data Found', 'Error!');
        print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
      } else {
        getUserData = GetUserData.fromJson(response.data);
        print(getUserData?.data?.displayName);
        print(getUserData?.data?.authorImage);
        print('bbbbbbbbbbbbbbbbbbbbbbbbbbbbbb');
        setState(() {
          authorImage = getUserData?.data?.authorImage;
          username = getUserData?.data?.firstName;
          username2 = getUserData?.data?.lastName;
          email = getUserData?.data?.authorEmail;
          mobileNumber = getUserData?.data?.userPhone;
        });
      }
    } catch (error) {
      print('ccccccccccccccccccccccccccccc');

      EasyLoading.dismiss();
      // errorAlertMessage('Something went wrong!', 'Error!');
    }
  }

  @override
  void initState() {
    super.initState();
    addCounts();
    print('uuuuuuuu');
    print(LoginUser.shared?.userId);
    print(username);
    // firstnameController.text = '';
    // lastnameController.text = '';
    // emailController.text = '';
    // phoneNoController.text = '';
    getProfileData();

    Future.delayed(Duration(seconds: 2), () {
      firstnameController.text = username ?? firstnameController.text;
      lastnameController.text = username2 ?? lastnameController.text;
      emailController.text = email ?? emailController.text;
      phoneNoController.text = mobileNumber ?? phoneNoController.text;
    });

    print(
        'didChangeDependencies didChangeDependencies didChangeDependencies didChangeDependencies ');
  }

  var registeredID;
  // static final facebookAppEvents = FacebookAppEvents();

  Future registerData() async {
    try {
      Response response;
      var dio = Dio();

      response = await dio.post(
        'https://basalon.co.il/wp-json/wp/v2/user_register',
        data: FormData.fromMap(
          {
            'first_name': firstnameController.text,
            'last_name': lastnameController.text,
            'email': emailController.text,
          },
        ),
        options: Options(headers: {
          "Client-Service": "basalon-client-t1T83YHm60J8yNG5",
          "Auth-Key": "XkCRn9Y4PPmspuqYKolqbyhcDFhID7kl"
        }),
      );
      print(response);
      EasyLoading.dismiss();
      if (response.data['success'] == 200) {
        // ignore: avoid_print
        print('response.data  user_id user_id');
        print(response.data['data']['user_id']);
        registeredID = response.data['data']['user_id'];
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setInt('loginId', registeredID!);

        isUserLogin(true);
        LoginUser.shared?.userId = sharedPreferences.getInt('loginId');
        print('pppppppppppppppppppppppppppppppppppppppppppp');
        application.isUserLogin = true;
        print(sharedPreferences.getInt('loginId'));

        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Success'),
            content: const Text('Registration is completed !!'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context, 'OK');
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else {
        print('Invalid Invalid Invalid');
        errorAlertMessage('Invalid Credential!');
      }
    } catch (error) {
      print('error error error error');
      print(error);
      EasyLoading.dismiss();
      errorAlertMessage('Something went wrong!');
    }
  }

  dynamic discountAmount;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  bool isDiscount = false;
  List<int> price = [];

  addCounts() {
    for (int i = 0; i < widget.noOfTicket!.length; i++) {
      ticketCount.add(0);
      finalPrice.add(0);
      if (widget.noOfTicket![i].priceTicket != "")
        price.add(int.parse(widget.noOfTicket![i].priceTicket!));
    }
  }

  late var totalPrice = finalPrice.fold(
      0, (int previousValue, element) => previousValue + element);

  addPrice() {
    for (int i = 0; i < widget.noOfTicket!.length; i++) {
      print('wwwwwwwwwwwwwwwwwwwww');
      print(i);
      totalPrice =
          (int.parse(widget.noOfTicket![i].priceTicket!) * ticketCount[i]) +
              (int.parse(widget.noOfTicket![i].priceTicket!) * ticketCount[i]) -
              int.parse(discountAmount ?? '0');
    }
  }

  add() {}

  @override
  Widget build(BuildContext context) {
    LoginUser.shared?.userId!;
    print('noOfTicket');
    print(widget.noOfTicket![0].priceTicket);
    print('noOfTicket');
    String bookingText =
        "${widget.date?.date1} , ${widget.date?.date2} (${widget.date?.startTime}- ${widget.date?.endTime})";
    print('widget.date');
    // print(finalPrice);
    // print(finalPrice.fold(
    //     0,
    //     (previousValue, element) => widget.noOfTicket![0].priceTicket == null
    //         ? previousValue.toString() + element.toString()
    //         : int.tryParse(previousValue.toString())! + element));
    var finalTotal = widget.noOfTicket![0].priceTicket == ""
        ? 0
        : finalPrice.fold(
            widget.noOfTicket![0].priceTicket ?? 0,
            (previousValue, element) => widget.noOfTicket![0].priceTicket == ""
                ? previousValue.toString() + element.toString()
                : int.tryParse(previousValue.toString())! + element);
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
        //         application.getUserDataProfileProvider?.data?.authorImage !=
        //             null)
        //     ? Padding(
        //         padding: const EdgeInsets.all(8.0),
        //         child: CircleAvatar(
        //           backgroundImage:
        //               // AssetImage(
        //               //     'assets/images/dummy_user.png'),

        //               NetworkImage(
        //             application.getUserDataProfileProvider?.data
        //                         ?.authorImage !=
        //                     ''
        //                 ? application
        //                     .getUserDataProfileProvider?.data?.authorImage
        //                 : application.imageFromFacebook ??
        //                     'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png',
        //           ),
        //           backgroundColor: Colors.grey.shade600,
        //         ),
        //       )
        //     : const SizedBox(),
        title: Image.asset(
          kLogoImage,
          fit: BoxFit.fill,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width / 1.5,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        opacity: 0.5,
                        image: Image.network(
                          '${widget.thumbnailImage}',
                        ).image),
                  ),
                ),
                Column(
                  children: [
                    SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.only(right: 0),
                      child: Text(
                        '${widget.title}',
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                            shadows: <Shadow>[
                              Shadow(
                                offset: Offset(2.0, 2.0),
                                blurRadius: 3.0,
                              )
                            ],
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 20, top: 10),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          "${widget.mapAdress}",
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            shadows: <Shadow>[
                              Shadow(
                                offset: Offset(2.0, 2.0),
                                blurRadius: 3.0,
                              )
                            ],
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          bookingText,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            shadows: <Shadow>[
                              Shadow(
                                offset: Offset(2.0, 2.0),
                                blurRadius: 3.0,
                              )
                            ],
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),

            Padding(
              padding:
                  EdgeInsets.only(left: 50, right: 30, top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "כמות",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 85, 85, 85),
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "מחיר כרטיס",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 85, 85, 85),
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "סוג כרטיס",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 85, 85, 85),
                      fontSize: 16,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Divider(color: Colors.grey, thickness: 2),
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(
            //     horizontal: 20,
            //   ),
            //   child: Container(
            //     width: MediaQuery.of(context).size.width,
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.start,
            //       children: [
            //         Text(
            //           ticketCount >= 10
            //               ? "Max number ticket is \n \t \t \t \t \t \t 10"
            //               : ticketCount < 1
            //                   ? "Min number ticket is \n \t \t \t \t \t \t 1"
            //                   : '',
            //           style: TextStyle(
            //               fontSize: 13,
            //               fontWeight: FontWeight.w400,
            //               color: Colors.redAccent,
            //               fontStyle: FontStyle.italic),
            //         )
            //       ],
            //     ),
            //   ),
            // ),
            for (int i = 0; i < widget.noOfTicket!.length; i++)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)),
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              print("add");
                              setState(() {
                                if (ticketCount[i] < 10) ticketCount[i]++;
                              });
                              // addPrice();
                              setState(() {
                                finalPrice[i] = price[i] * ticketCount[i];
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 3),
                              height: 40,
                              width: 30,
                              // decoration: BoxDecoration(color: Colors.blue),
                              child: Center(child: Icon(Icons.add)),
                            ),
                          ),
                          const VerticalDivider(
                            color: Colors.black,
                            width: 2,
                          ),
                          Container(
                              height: 40,
                              width: 30,
                              // decoration: BoxDecoration(color: Colors.blue),
                              child: Center(
                                child: i == 0
                                    ? Text("${ticketCount[i] + 1}")
                                    : Text("${ticketCount[i] }"),
                              )),
                          const VerticalDivider(color: Colors.black, width: 2),
                          InkWell(
                            onTap: () {
                              print("minus");
                              setState(() {
                                if (ticketCount[i] > 0) {
                                  ticketCount[i]--;
                                }
                              });
                              // addPrice();
                              setState(() {
                                finalPrice[i] = price[i] * ticketCount[i];
                              });

                              print(finalTotal);
                              print('finalTotal');
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 3),
                              height: 40,
                              width: 30,
                              // decoration: BoxDecoration(color: Colors.blue),
                              child: Center(child: const Icon(Icons.remove)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          const Icon(
                            Icons.close,
                            size: 17,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                          Container(
                              margin: EdgeInsets.only(right: 60),
                              child: Text(
                                  "₪${widget.noOfTicket?[i].priceTicket == "" ? 0 : widget.noOfTicket?[i].priceTicket}")),
                          Text(
                            "${widget.noOfTicket?[i].nameTicket ?? 'כרטיס רגיל'}",
                            textAlign: TextAlign.end,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              margin: EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Text(
                    " פרטי בעל הכרטיס ",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Divider(thickness: 5),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            "שם פרטי",
                            style: TextStyle(
                                color: Color.fromARGB(255, 117, 117, 117),
                                fontWeight: FontWeight.w300),
                            textAlign: TextAlign.end,
                          ),
                          TextFormField(
                            controller: firstnameController,
                            textDirection: TextDirection.rtl,
                            cursorColor: Colors.black,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintTextDirection: TextDirection.rtl),
                          )
                        ],
                      ),
                    ),
                    const Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            "שם משפחה",
                            style: TextStyle(
                              color: Color.fromARGB(255, 117, 117, 117),
                              fontWeight: FontWeight.w300,
                            ),
                            textAlign: TextAlign.end,
                          ),
                          Container(
                            child: TextFormField(
                              controller: lastnameController,
                              textDirection: TextDirection.rtl,
                              cursorColor: Colors.black,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintTextDirection: TextDirection.rtl),
                            ),
                          )
                        ],
                      ),
                    ),
                    const Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            "אימייל",
                            style: TextStyle(
                                color: Color.fromARGB(255, 117, 117, 117),
                                fontWeight: FontWeight.w300),
                            textAlign: TextAlign.end,
                          ),
                          Container(
                            child: TextFormField(
                              controller: emailController,
                              textDirection: TextDirection.rtl,
                              cursorColor: Colors.black,
                              decoration: const InputDecoration(
                                hintTextDirection: TextDirection.rtl,
                                border: InputBorder.none,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            "טלפון נייד",
                            style: TextStyle(
                                color: Color.fromARGB(255, 117, 117, 117),
                                fontWeight: FontWeight.w300),
                            textAlign: TextAlign.end,
                          ),
                          TextFormField(
                            controller: phoneNoController,
                            textDirection: TextDirection.rtl,
                            cursorColor: Colors.black,
                            // initialValue: "9876543210",
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                          )
                        ],
                      ),
                    ),

                    if (!isUserLogin(application.isUserLogin))
                      const Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                    if (!isUserLogin(application.isUserLogin))
                      CheckboxListTile(
                        dense: true,
                        visualDensity: VisualDensity.lerp(
                            VisualDensity.compact, VisualDensity.compact, 0.0),
                        title: Transform.translate(
                          offset: Offset(10, 0),
                          child: Text(
                            "צרו חשבון על מנת לנהל בקלות את הרכישות שלכם",
                            style: TextStyle(color: Colors.black),
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
                    // Container(
                    //   height: 40,
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //     children: [
                    //       Text(
                    //         "צרו חשבון על מנת לנהל בקלות את הרכישות שלכם",
                    //         style: TextStyle(color: Colors.black),
                    //       ),
                    //       Checkbox(
                    //         visualDensity: VisualDensity.compact,
                    //         shape: RoundedRectangleBorder(
                    //             borderRadius: BorderRadius.circular(5)),
                    //         value: checkBoxValue,
                    //         onChanged: (Value) {
                    //           setState(() {
                    //             if (checkBoxValue) {
                    //               checkBoxValue = false;
                    //             } else {
                    //               checkBoxValue = true;
                    //             }
                    //           });
                    //         },
                    //       ),
                    //     ],
                    //   ),
                    // )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              margin: EdgeInsets.only(right: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    " קבלת תשלום ",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Divider(
                thickness: 5,
                height: 0,
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  border: Border(
                      left: BorderSide(color: Colors.grey),
                      right: BorderSide(color: Colors.grey)),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "פרטי הזמנה",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                      Divider(thickness: 3),
                      SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "כמות",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(255, 77, 77, 77)),
                          ),
                          Text(
                            "סוג כרטיס",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(255, 77, 77, 77)),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      DottedLine(
                        dashColor: Colors.grey,
                        lineThickness: 1,
                      ),
                      SizedBox(height: 20),
                      for (int i = 0; i < widget.noOfTicket!.length; i++)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            i == 0
                                ? Text("${ticketCount[i] + 1}")
                                : Text("${ticketCount[i]}"),
                            Text(
                                "₪${widget.noOfTicket?[i].priceTicket} ${widget.noOfTicket?[i].nameTicket ?? 'כרטיס רגיל'}")
                          ],
                        ),
                      SizedBox(height: 20),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                decoration:
                    BoxDecoration(color: Color.fromRGBO(102, 102, 102, 1)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "₪${finalTotal}",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      Text(
                        'סה"כ',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            showDiscountField ? discountField() : DiscountButton(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: GestureDetector(
                onTap: () async {
                  // await facebookAppEvents.setAdvertiserTracking(enabled: true);
                  // await facebookAppEvents.setUserData(
                  //   email: emailController.text,
                  //   firstName: firstnameController.text,
                  //   lastName: lastnameController.text,
                  //   phone: phoneNoController.text,
                  // );
                  // await facebookAppEvents.logEvent(
                  //   name: 'button_clicked',
                  //   parameters: {
                  //     'button_id': 'the_clickme_button',
                  //   },
                  // );
                  // print('----------${facebookAppEvents.logEvent(
                  //   name: 'button_clicked',
                  //   parameters: {
                  //     'button_id': 'the_clickme_button',
                  //   },
                  // )}');

                  if (firstnameController.text.isEmpty) {
                    errorAlertMessage("Please enter firstname!");
                    validate();
                  } else if (emailController.text.isEmpty) {
                    errorAlertMessage("Please enter email!");
                  } else if (phoneNoController.text.isEmpty) {
                    errorAlertMessage('Please enter mobile number!');
                  } else {
                    if (checkBoxValue &&
                        !isUserLogin(application.isUserLogin)) {
                      await registerData();
                    }
                    print(finalTotal);

                    if (finalTotal == 0) {
                      print('objecttttttttttttttttt');

                      print(phoneNoController.text);
                      // print(LoginUser.shared?.userId!);
                      print(emailController.text);
                      print(firstnameController.text);
                      print(lastnameController.text);
                      print(widget.noOfTicket);
                      print(ticketCount);
                      print(int.parse(widget.id));
                      print(widget.date?.eventDate);
                      print('emailController');
                      await PlaceOrderNetwork.placeOrders(
                        context,
                        true,
                        fname: firstnameController.text,
                        lname: lastnameController.text,
                        userPhone: phoneNoController.text,
                        userId: LoginUser.shared?.userId!,
                        userEmail: emailController.text,
                        ticketId: widget.noOfTicket,
                        numOfTicket: ticketCount,
                        productId: int.parse(widget.id),
                        couponCode: 'coupen',
                        formatDate: widget.date?.eventDate,
                        totalAmount: [0],
                      );

                      // PlaceOrderNetwork(
                      //   userPhone: phoneNoController.text,
                      //   userId: 1319,
                      //   //  LoginUser.shared?.userId! ??
                      //   //     application.idFromLocalProvider ??
                      //   //     registeredID,
                      //   userEmail: emailController.text,
                      //   userFullname: firstnameController.text +
                      //       ' ' +
                      //       lastnameController.text,
                      //   ticketId: widget.noOfTicket,
                      //   totalAmount: [0],
                      //   numOfTicket: ticketCount,
                      //   productId: int.parse(widget.id),
                      //   couponCode: 'coupen',
                      //   formatDate: widget.date?.eventDate,
                      // );

                      // PlaceOrderNetwork().placeOrder(context, showtitle);
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CheckoutPage(
                            initialPrice: widget.noOfTicket![0].priceTicket,
                            totalAmount: finalPrice, // for price static 0
                            // email: getUserData != n
                            //     ? getUserData!.data.authorEmail.toString()
                            //     : 'email',
                            email: emailController.text,
                            eventDate: bookingText,
                            eventTitle: widget.title.toString(),
                            // fullName: getUserData != null
                            //     ? getUserData!.data.displayName.toString()
                            //     : 'fullname',
                            fullName: firstnameController.text +
                                ' ' +
                                lastnameController.text,
                            // mobileNumber: getUserData != null
                            //     ? getUserData!.data.userPhone.toString()
                            //     : '9876543210',
                            mobileNumber: phoneNoController.text,
                            nOofTicketInstance: widget.noOfTicket,
                            numOfTicket: ticketCount,
                            userId: LoginUser.shared?.userId! ??
                                application.idFromLocalProvider ??
                                registeredID,
                            eventID: int.parse(widget.id),
                            couponCode: couponController.text,

                            // ticketCount: ticketCount,
                            formattedDate: widget.date?.eventDate ?? '',
                          ),
                        ),
                      );
                    }
                  }
                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration:
                      BoxDecoration(color: Color.fromRGBO(232, 108, 96, 1)),
                  child: Center(
                    child: Text(
                      "המשך",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget DiscountButton() {
    return InkWell(
      onTap: () {
        showDiscountField = true;
        setState(() {});
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: DottedBorder(
          strokeWidth: 1,
          dashPattern: [8, 4],
          color: Colors.grey,
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Text(
                "קוד קופון",
              ),
            ),
          ),
        ),
      ),
    );
  }

  void errorAlertMessage(String errorMessage) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Error'),
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

  void validate() {
    if (formkey.currentState!.validate()) {
      print('VALIDATED');

      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => TicketScreen()));
    } else {
      print('Not Valid');
    }
  }

  Widget discountField() {
    return Container(
      margin: EdgeInsets.only(top: 10, right: 10, left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  // await _placeOrderNetwork.checkDiscount(
                  //     couponController.text, widget.id);
                  await _placeOrderNetwork.checkDiscount(
                      couponController.text, 27878);

                  setState(() {
                    discountAmount =
                        _placeOrderNetwork.discountModel?.data?.discountNumber;
                    isDiscount = true;
                  });
                  print(
                      '${_placeOrderNetwork.discountModel?.data?.discountNumber}------------------------');
                },
                style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(144, 186, 62, 1),
                    shape:
                        RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                    padding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 12)),
                child: Center(
                  child: Text("אישור"),
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: TextFormField(
                    controller: couponController,
                    textAlign: TextAlign.right,
                    //  maxLines: 2,
                    decoration: const InputDecoration(
                        hintText: 'קוד קופון',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.zero)),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  showDiscountField = false;
                  setState(() {});
                },
                child: Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: Icon(
                      Icons.close,
                      size: 22,
                    )),
              )
            ],
          ),
          if (_placeOrderNetwork.discountModel?.data?.discountNumber == null &&
              isDiscount)
            Padding(
              padding: const EdgeInsets.only(right: 50.0),
              child: Text(
                'Invalid Discount Code',
                style: TextStyle(color: Colors.red),
                textAlign: TextAlign.right,
              ),
            ),
        ],
      ),
    );
  }
}
