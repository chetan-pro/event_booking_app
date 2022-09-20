import 'package:basalon/network/package_network.dart';
import 'package:basalon/services/constant.dart';
import 'package:basalon/services/my_color.dart';
import 'package:basalon/widgets/custom_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';

import '../../blocs/application_bloc.dart';
import '../../constant/login_user.dart';
import '../../widgets/side_drawer.dart';

class PackageScreen extends StatefulWidget {
  PackageScreen({Key? key, this.packID}) : super(key: key);

  dynamic packID;

  @override
  State<PackageScreen> createState() => _PackageScreenState();
}

class _PackageScreenState extends State<PackageScreen> {
  DateTime date = DateTime.now();
  PackageNetwork packageNetwork = PackageNetwork();
  late final application = Provider.of<ApplicationBloc>(context, listen: false);
  bool isNormal = false;
  bool isCuliniary = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('packageNetwork.packageModel?.data?.userActivePackage?.iD');
    print(widget.packID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: NavDrawer(
        packageID: widget.packID,
      ),
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              // textDirection: TextDirection.rtl,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  'יצירת פעילות חדשה',
                  style: ktextStyleLarge,
                  textAlign: TextAlign.center,
                ),
                Divider(),
                SizedBox(
                  height: 20,
                ),
                if (application.packageModel != null)
                  for (var item
                      in application.packageModel!.data!.packages!.reversed)
                    PackageCustomContainer(
                      text: item.title,
                      features: item.features,
                      color:
                          !isNormal == true ? MyColors.topOrange : Colors.grey,
                      onPressed: () async {
                        print('object');

                        await packageNetwork.renewPackage(
                            LoginUser.shared?.userId! ??
                                application.idFromLocalProvider,
                            context,
                            item.id);
                        setState(() {
                          isNormal = true;
                          isCuliniary = false;
                        });
                      },
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PackageCustomContainer extends StatelessWidget {
  PackageCustomContainer(
      {Key? key, this.onPressed, this.color, this.text, this.features})
      : super(key: key);

  dynamic onPressed;
  dynamic color;
  String? text;
  dynamic features;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 10),
      // height: 300,
      color: Colors.white,
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Html(
            data: text,
            defaultTextStyle: ktextStyleLarge,
            customTextAlign: (_) => TextAlign.center,
          ),
          SizedBox(
            height: 20,
          ),
          if (features != null)
            Html(
              data: features,
              defaultTextStyle: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
              customTextAlign: (_) => TextAlign.center,
            ),
          // Padding(
          //   padding: const EdgeInsets.all(28.0),
          //   child: Text(
          //     text ?? 'מסלול קולינרי',
          //     style: ktextStyleLarge,
          //     softWrap: true,
          //     textAlign: TextAlign.center,
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Text(
          //     '15% עמלה – עבור כרטיסים שאנו משווקים ומוכרים עבורכם',
          //     style: ktextStyle,
          //     softWrap: true,
          //     textAlign: TextAlign.center,
          //   ),
          // ),
          // Divider(),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Text(
          //     '0% עמלה – עבור כרטיסים שתוכלו למכור בעצמכם דרך לינק מיוחד שניתן לכם',
          //     style: ktextStyle,
          //     softWrap: true,
          //     textAlign: TextAlign.center,
          //   ),
          // ),
          // Divider(),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Text(
          //     'כפתור ייעודי בעמוד הפעילות שלכם שיאפשר גם הזמנה של קבוצות פרטיות(חברות וארגונים למשל)',
          //     style: ktextStyle,
          //     softWrap: true,
          //     textAlign: TextAlign.center,
          //   ),
          // ),
          // Divider(),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Text(
          //     'ללא דמי הרשמה וללא תשלומים קבועים',
          //     style: ktextStyle,
          //     softWrap: true,
          //     textAlign: TextAlign.center,
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: CustomButton(
                onPressed: onPressed,
                width: 150,
                height: 50,
                color: color,
                text: 'בחר/י מסלול'),
          ),
        ],
      ),
    );
  }
}
