import 'dart:async';

import 'package:basalon/constant/login_user.dart';
import 'package:basalon/modal/get_user_activity.dart';
import 'package:basalon/screens/activity/general_screen.dart';
import 'package:basalon/services/constant.dart';
import 'package:basalon/services/my_color.dart';
import 'package:basalon/widgets/custom_buttons.dart';
import 'package:basalon/widgets/side_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../../../blocs/application_bloc.dart';
import '../../../network/my_activity_network.dart';
import '../../../widgets/custom_copy.dart';

class MyActivityScreen extends StatefulWidget {
  MyActivityScreen({Key? key}) : super(key: key);

  @override
  State<MyActivityScreen> createState() => _MyActivityScreenState();
}

class _MyActivityScreenState extends State<MyActivityScreen> {
  final GetUserActivity _getUserActivity = GetUserActivity();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // stream = getActivity();
  }

  bool sortActivity = false;
  late final application = Provider.of<ApplicationBloc>(context, listen: false);

  Stream streamController() =>
      Stream.fromFuture(_getUserActivity.getUserActivity(
          sortActivity,
          LoginUser.shared?.userId ?? application.idFromLocalProvider,
          context));

  Stream getActivity() async* {
    await Future.delayed(Duration(milliseconds: 100), () {
      return _getUserActivity.getUserActivity(sortActivity,
          LoginUser.shared?.userId ?? application.idFromLocalProvider, context);
    });
    setState(() {});
    // print(get)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      endDrawer: NavDrawer(),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new_outlined,
            )),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.black,
        title: Container(
          margin: EdgeInsets.only(top: 10),
          height: 200,
          width: 280,
          child: Image.asset(
            'assets/new-logo.png',
            fit: BoxFit.fill,
          ),
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              'הפעילויות שלי',
              style: ktextStyleLarge,
            ),
            const Divider(),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade300, width: 0.5)),
              margin: EdgeInsets.symmetric(horizontal: 9, vertical: 1),
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Text(
                    'פעילות',
                    style: ktextStyleBold,
                  ),
                  IconButton(
                      onPressed: () async {
                        setState(() {
                          sortActivity = !sortActivity;
                          getActivity();
                        });
                        _getUserActivity.getUserActivity(
                            sortActivity,
                            LoginUser.shared?.userId ??
                                application.idFromLocalProvider,
                            context);
                      },
                      icon: FaIcon(
                        FontAwesomeIcons.sort,
                        size: 14,
                      )),
                ],
              ),
            ),
            Expanded(
              child: StreamBuilder(
                  stream: streamController(),
                  builder: (context, AsyncSnapshot snapshot) {
                    print('streamasdsd');
                    print(snapshot.data);
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                          child: CircularProgressIndicator(
                        backgroundColor: Colors.grey,
                        color: MyColors.topOrange,
                      ));
                    } else if (!snapshot.hasData) {
                      return Center(child: Text('no acitivity found'));
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          print('aasdsdsafew${snapshot.data.length}');
                          return Container(
                            decoration: BoxDecoration(
                              color: index % 2 == 0
                                  ? Colors.grey.shade50
                                  : Colors.grey.shade200,
                              boxShadow: <BoxShadow>[
                                BoxShadow(blurRadius: 1.0, color: Colors.grey)
                              ],
                            ),
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    text: '${snapshot.data?[index].title}',
                                    // text: '${widget.datum[index].title}',
                                    style: TextStyle(
                                        color: Colors.blue, fontSize: 20),
                                    children: [
                                      TextSpan(
                                          text:
                                              ' - ${snapshot.data?[index].status}',
                                          style: ktextStyle),
                                    ],
                                  ),
                                ),
                                if (snapshot.data?[index].statusEvent != '')
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 5),
                                    child: Text(
                                      '${snapshot.data?[index].statusEvent}',
                                      style: TextStyle(
                                          color: MyColors.greenButton),
                                    ),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                  ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/icons/calendar.jpeg',
                                      height: 20,
                                      width: 20,
                                    ),
                                    Text(
                                        '${snapshot.data?[index].dateTime.replaceAll('@', '')}'),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Image.asset(
                                        'assets/LatestMarker60.png',
                                        width: 18,
                                      ),
                                    ),
                                    Expanded(
                                        child: Text(
                                            '${snapshot.data?[index].address}'))
                                  ],
                                ),
                                Row(
                                  children: [
                                    TextButton(
                                        onPressed: () {}, child: Text('שכפול')),
                                    TextButton(
                                        onPressed: () async {
                                          await _getUserActivity
                                              .changeActivityStatus(
                                                  snapshot.data?[index].eventId,
                                                  snapshot.data?[index]
                                                              .status ==
                                                          'פעיל'
                                                      ? 'pending'
                                                      : 'publish');
                                          setState(() {});
                                        },
                                        child: Text(
                                            snapshot.data?[index].status ==
                                                    'פעיל'
                                                ? 'השהייה'
                                                : 'הפעלה')),
                                    TextButton(
                                        onPressed: () async {
                                          await _getUserActivity
                                              .changeActivityStatus(
                                                  snapshot.data?[index].eventId,
                                                  'trash');
                                          setState(() {});
                                        },
                                        child: const Text('מחיקה')),
                                  ],
                                ),
                                Text(
                                    'לינק מיוחד לשיתוף(0% עמלה בעבור כרטיסים שימכרו דרך לינק זה):'),
                                CopiableText(
                                  '${snapshot.data?[index].specialLink ?? 'https://basalon.co.il/sd/24663'}',
                                  copyMessage: 'Address copied to clipboard',
                                  child: Text(
                                    '${snapshot.data?[index].specialLink ?? 'https://basalon.co.il/sd/24663'}',
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                CustomButton(
                                  onPressed: () async {
                                    await _getUserActivity
                                        .getUserEditActivityDetails(
                                            snapshot.data?[index].eventId,
                                            context);
                                    await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => GeneralScreen(
                                                  id: snapshot
                                                      .data?[index].eventId,
                                                )));
                                  },
                                  isOutlinedButton: false,
                                  color: MyColors.greenButton,
                                  text: 'עריכה',
                                ),
                                ListView.builder(
                                    itemCount:
                                        snapshot.data[index].sales.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, salesindex) {
                                      print(
                                          "sdsdsafj${snapshot.data[index].sales.length}");
                                      return Container(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 20),
                                        child: Column(
                                          textDirection: TextDirection.rtl,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Text(
                                              snapshot.data[index]
                                                      .sales[salesindex].date ??
                                                  '28-04-2022',
                                              style: TextStyle(
                                                  color: MyColors.topOrange,
                                                  fontSize: 16),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            RichText(
                                              text: TextSpan(
                                                  text: 'סה"כ כרטיסים',
                                                  children: [
                                                    TextSpan(
                                                        text:
                                                            ' ${snapshot.data[index].sales[salesindex].totalTicketBooking}',
                                                        style: TextStyle(
                                                            color: MyColors
                                                                .topOrange,
                                                            fontSize: 16)),
                                                  ],
                                                  style: ktextStyle),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            LinearPercentIndicator(
                                              percent: double.parse(snapshot
                                                      .data[index]
                                                      .sales[salesindex]
                                                      .percentSaleTicket
                                                      .toString()
                                                      .replaceAll('%', '')) /
                                                  100,
                                              progressColor: MyColors.topOrange,
                                              width: 150,
                                              lineHeight: 30,
                                              isRTL: true,
                                              center: Text(snapshot
                                                  .data[index]
                                                  .sales[salesindex]
                                                  .percentSaleTicket),
                                              padding: EdgeInsets.zero,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            ListView.builder(
                                                shrinkWrap: true,
                                                //  print(snapshot.data[0].sales[0].date);
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                itemCount: snapshot
                                                            .data[index]
                                                            .sales[salesindex]
                                                            .ticketList ==
                                                        null
                                                    ? 0
                                                    : snapshot
                                                        .data[index]
                                                        .sales[salesindex]
                                                        .ticketList
                                                        .length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int ticketListindex) {
                                                  print(
                                                      "jsahdkjsbdsa${snapshot.data[index].sales[salesindex].ticketList.length}");
                                                  return RichText(
                                                    text: TextSpan(
                                                        text: 'כרטיס רגיל:',
                                                        children: [
                                                          TextSpan(
                                                              text:
                                                                  '${snapshot.data[index].sales[salesindex].ticketList[ticketListindex].numberTicketSale}',
                                                              style: TextStyle(
                                                                  color: MyColors
                                                                      .topOrange,
                                                                  fontSize:
                                                                      16)),
                                                        ],
                                                        style: ktextStyle),
                                                  );
                                                })
                                          ],
                                        ),
                                      );
                                    }),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
