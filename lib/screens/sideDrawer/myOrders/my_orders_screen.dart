import 'dart:async';
import 'dart:io'; // for File

import 'package:basalon/network/my_orders_network.dart';
import 'package:basalon/services/constant.dart';
import 'package:basalon/services/my_color.dart';
import 'package:basalon/widgets/side_drawer.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../../../blocs/application_bloc.dart';
import '../../../constant/login_user.dart';
import '../../../widgets/custom_buttons.dart';

class MyOrderScreen extends StatefulWidget {
  MyOrderScreen({Key? key}) : super(key: key);

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  GetMyOrders _getMyOrders = GetMyOrders();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // stream = getActivity();
  }

  bool sortActivity = false;
  late final application = Provider.of<ApplicationBloc>(context, listen: false);

  // late Stream stream;
  // StreamController streamController = StreamController();
  Stream streamController() => Stream.fromFuture(_getMyOrders.getMyOrders(
      LoginUser.shared?.userId ?? application.idFromLocalProvider,
      indexTicket));

  Stream getActivity() async* {
    await Future.delayed(Duration(milliseconds: 100), () {
      return _getMyOrders.getMyOrders(
          LoginUser.shared?.userId ?? application.idFromLocalProvider,
          indexTicket);
    });
    setState(() {});
  }

  int? indexTicket;

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
        child: Padding(
          padding: const EdgeInsets.only(right: 10, left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                'ההזמנות שלי',
                style: ktextStyleLarge,
              ),
              const Divider(),
              Expanded(
                child: StreamBuilder(
                    stream: streamController(),
                    builder: (context, AsyncSnapshot snapshot) {
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
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                color: index % 2 == 0
                                    ? Colors.grey.shade50
                                    : Colors.grey.shade200,
                                boxShadow: <BoxShadow>[
                                  BoxShadow(blurRadius: 1.0, color: Colors.grey)
                                ],
                              ),
                              padding: EdgeInsets.all(10),
                              child: Column(
                                textDirection: TextDirection.rtl,
                                children: [
                                  Row(
                                    textDirection: TextDirection.rtl,
                                    children: [
                                      Text(
                                        'ID',
                                        style: ktextStyleBold,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        '${snapshot.data.data[index].id}',
                                        style: ktextStyle,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'פעילות',
                                        style: ktextStyleBold,
                                      ),
                                      Text(
                                        '${snapshot.data.data[index].title}',
                                        style: TextStyle(
                                            color: Colors.blue, fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'תאריך הפעילות',
                                        style: ktextStyleBold,
                                      ),
                                      Text(
                                        '${snapshot.data.data[index].dateCal}',
                                        style: ktextStyle,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'סה"כ',
                                        style: ktextStyleBold,
                                      ),
                                      Text(
                                        '${snapshot.data.data[index].totalAfterTax}',
                                        style: ktextStyle,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'תאריך ההזמנה',
                                        style: ktextStyleBold,
                                      ),
                                      Text(
                                        '${snapshot.data.data[index].createdDate}',
                                        style: ktextStyle,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'סטטוס',
                                        style: ktextStyleBold,
                                      ),
                                      Text(
                                        '${snapshot.data.data[index].status}',
                                        style: ktextStyle,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      CustomButton(
                                          onPressed: () async {
                                            print('email email email');
                                            await _getMyOrders.userTicketEmail(
                                                snapshot.data.data[index].id);
                                          },
                                          // width: 100.0,
                                          color: MyColors.greenButton,
                                          text: 'שליחת כרטיס למייל'),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      CustomButton(
                                          onPressed: () {
                                            print(index);
                                            setState(() {
                                              indexTicket = index;
                                            });
                                            openFile(
                                              url: "${_getMyOrders.ticketLink}",
                                              fileName: 'ticket_basalon.pdf',
                                            );
                                            // showDialog(
                                            //   context: context,
                                            //   builder: (context) => const DownloadingDialog(),
                                            // );
                                          },
                                          // width: 100.0,
                                          color: MyColors.greenButton,
                                          text: 'הצגת הכרטיס'),
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                          itemCount: snapshot.data.data.length,
                        );
                      }
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<File?> openFile({required String url, String? fileName}) async {
    print('paaaaaaa');
    final file = await downloadFile(url, fileName!);
    if (file != null) return null;
    print('paaaaaaaaaaaaattttthhhh:${file?.path}');
  }

  Future<File?> downloadFile(String url, String name) async {
    var appStorage = await getExternalStorageDirectory();
    final fileName =
        "${DateTime.now().millisecondsSinceEpoch}${url.split('/').last}";
    final file = File('${appStorage!.path}/$fileName');
    try {
      final response = await Dio().download(url, file.path,
          onReceiveProgress: (received, total) {
        setState(() {
          var progress = ((received / total) * 100).floor();
          print(progress);
        });
      });
      OpenFile.open(file.path)
          .then((value) => print("$value"))
          .catchError((onError) {});
    } catch (e) {
      print('nhi hui download!!!!!!!!!!!!!!!!!!!!!!!');
      print(e);
      return null;
    }
  }
}
