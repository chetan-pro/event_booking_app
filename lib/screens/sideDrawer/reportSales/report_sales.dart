import 'package:basalon/constant/login_user.dart';
import 'package:basalon/network/report_sales_network.dart';
import 'package:basalon/screens/activity/receiving_activity_screen.dart';
import 'package:basalon/services/constant.dart';
import 'package:basalon/services/my_color.dart';
import 'package:basalon/widgets/custom_buttons.dart';
import 'package:basalon/widgets/report_sale_chart.dart';
import 'package:basalon/widgets/side_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../blocs/application_bloc.dart';
import '../../../widgets/date_helper.dart';

class ReportSalesScreen extends StatefulWidget {
  const ReportSalesScreen({Key? key}) : super(key: key);

  @override
  State<ReportSalesScreen> createState() => _ReportSalesScreenState();
}

class _ReportSalesScreenState extends State<ReportSalesScreen> {
  ReportSalesNetwork reportSalesNetwork = ReportSalesNetwork();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  DateTime date = DateTime.now();
  late String time = "${date.day}/${date.month}/${date.year}";
  late final application = Provider.of<ApplicationBloc>(context, listen: false);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    reportSalesNetwork.getReportSales(
        '7_day', LoginUser.shared?.userId ?? application.idFromLocalProvider);
    endDateController.text = time;
    startDateController.text = time;
    setState(() {});
    Future.delayed(Duration(seconds: 2), () {
      setState(() {});
    });
  }

  bool isMonth = false;
  bool isLastMonth = false;
  bool isYear = false;
  bool isWeek = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      endDrawer: NavDrawer(),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new_outlined,
            )),
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
      body: reportSalesNetwork.reportModel?.data?.chart == null
          ? Center(
              child: CircularProgressIndicator(
              color: MyColors.topOrange,
            ))
          : SingleChildScrollView(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'כללי',
                      style: ktextStyleLarge,
                    ),
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(10),
                      height: 300,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'דו"ח מכירות',
                            style: ktextStyleLarge,
                          ),
                          Wrap(
                            children: [
                              OutlinedButton(
                                  onPressed: () async {
                                    await reportSalesNetwork.getReportSales(
                                        'year',
                                        LoginUser.shared?.userId ??
                                            application.idFromLocalProvider);
                                    setState(() {
                                      isYear = true;
                                      isMonth = false;
                                      isLastMonth = false;
                                      isWeek = false;
                                    });
                                  },
                                  child: Text(
                                    'year',
                                    style: isYear == true
                                        ? TextStyle(color: MyColors.topOrange)
                                        : ktextStyle,
                                  )),
                              SizedBox(
                                width: 8,
                              ),
                              OutlinedButton(
                                  onPressed: () async {
                                    await reportSalesNetwork.getReportSales(
                                        '7_day',
                                        LoginUser.shared?.userId ??
                                            application.idFromLocalProvider);
                                    setState(() {
                                      isWeek = true;
                                      isMonth = false;
                                      isLastMonth = false;
                                      isYear = false;
                                    });
                                  },
                                  child: Text(
                                    'Last 7 days',
                                    style: isWeek == true
                                        ? TextStyle(color: MyColors.topOrange)
                                        : ktextStyle,
                                  )),
                              SizedBox(
                                width: 8,
                              ),
                              OutlinedButton(
                                  onPressed: () async {
                                    await reportSalesNetwork.getReportSales(
                                        'last_month',
                                        LoginUser.shared?.userId ??
                                            application.idFromLocalProvider);
                                    setState(() {
                                      isLastMonth = true;
                                      isWeek = false;
                                      isMonth = false;
                                      isYear = false;
                                    });
                                  },
                                  child: Text(
                                    'Last Month',
                                    style: isLastMonth == true
                                        ? TextStyle(color: MyColors.topOrange)
                                        : ktextStyle,
                                  )),
                              SizedBox(
                                width: 8,
                              ),
                              OutlinedButton(
                                  onPressed: () async {
                                    await reportSalesNetwork.getReportSales(
                                        'month',
                                        LoginUser.shared?.userId ??
                                            application.idFromLocalProvider);
                                    setState(() {
                                      isMonth = true;
                                      isWeek = false;
                                      isLastMonth = false;
                                      isYear = false;
                                    });
                                  },
                                  child: Text(
                                    'This Month',
                                    style: isMonth == true
                                        ? TextStyle(color: MyColors.topOrange)
                                        : ktextStyle,
                                  )),
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey.shade300)),
                            margin: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  'Custom:',
                                  style: ktextStyle,
                                ),
                                Row(
                                  children: [
                                    ReceivingPaymentFields(
                                      isBorder: false,
                                      width: 100,
                                      obscureText: false,
                                      controller: startDateController,
                                      onTap: () async {
                                        var date = await selectDate(
                                            isDob: true, context: context);
                                        if (date != "null") {
                                          setState(() {
                                            startDateController.text =
                                                convertSingleDate(date);
                                          });
                                        }
                                      },
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    ReceivingPaymentFields(
                                      isBorder: false,
                                      width: 100,
                                      obscureText: false,
                                      controller: endDateController,
                                      onTap: () async {
                                        var date = await selectDate(
                                            isDob: true, context: context);
                                        if (date != "null") {
                                          setState(() {
                                            endDateController.text =
                                                convertSingleDate(date);
                                          });
                                        }
                                      },
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 20, right: 10),
                                      child: CustomButton(
                                          color: MyColors.greenButton,
                                          text: 'Go',
                                          onPressed: () async {
                                            await reportSalesNetwork
                                                .getReportSales(
                                                    'custom',
                                                    LoginUser
                                                            .shared?.userId ??
                                                        application
                                                            .idFromLocalProvider);
                                            setState(() {});
                                          }),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.grey,
                      height: 400,
                      child: PointsLineChart.withSampleData(
                          reportSalesNetwork.reportModel?.data?.chart),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
