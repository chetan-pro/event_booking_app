import 'package:basalon/network/get_events_network.dart';
import 'package:basalon/services/my_color.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../blocs/application_bloc.dart';

class DropButton1 extends StatefulWidget {
  String? text1;
  String? text2;
  dynamic onChanged;

  DropButton1(
      {Key? key, required this.text1, required this.text2, this.onChanged})
      : super(key: key);

  @override
  State<DropButton1> createState() => _DropButton1State();
}

class _DropButton1State extends State<DropButton1> {
  late final application = Provider.of<ApplicationBloc>(context, listen: false);

  // String val ='ב-7 ימים הקרובים';
  String? realValue;

  late final FetchEventData _fetchEventData = FetchEventData(
    filterByCategory: application.realValueTime,
  );

  //
  // late HomePage _homePage = HomePage(
  //   categoryFilter: val,
  // );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _fetchEventData.getEventData(1, context);
  }

  @override
  Widget build(BuildContext context) {
    // late HomePage _homePage = HomePage(
    //   categoryFilter: val,
    // );
    return Container(
      decoration: BoxDecoration(
        color: MyColors.dropdownColor,
      ),
      // width: MediaQuery.of(context).size.width *0.15,

      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: DropdownButtonHideUnderline(
          child: DropdownButton2(
            // alignment: AlignmentDirectional.centerEnd,
            style: const TextStyle(
              color: Colors.white,
            ),
            selectedItemBuilder: (BuildContext context) {
              return <String>[
                'ב-7 ימים הקרובים',
                'היום',
                'מחר',
                'סוף השבוע',
                'בשבוע הבא',
                'תאריך מסויים',
              ].map<Widget>((String item) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.text1!,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Container(
                        padding: const EdgeInsets.only(right: 0.0),
                        alignment: Alignment.centerRight,
                        child: Text(
                          item,
                          textAlign: TextAlign.end,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ))
                  ],
                );
              }).toList();
            },
            isExpanded: true,
            hint: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.text1!,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  widget.text2!,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
            items: <String>[
              'ב-7 ימים הקרובים',
              'היום',
              'מחר',
              'סוף השבוע',
              'בשבוע הבא',
              'תאריך מסויים',
            ].map((item) {
              var backgroundColor = (item == application.realValueTime)
                  ? MyColors.topOrange
                  : Colors.white;
              var textColor = (item == application.realValueTime)
                  ? Colors.white
                  : Colors.black;

              return DropdownMenuItem<String>(
                value: item,
                alignment: AlignmentDirectional.topEnd,
                child: Container(
                  margin: EdgeInsets.all(0),
                  height: 50,
                  padding: const EdgeInsets.only(top: 10.0, right: 10),
                  width: double.infinity,
                  color: backgroundColor,
                  child: Text(
                    item,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 16,
                      // fontWeight: FontWeight.bold,
                      color: textColor,
                      // backgroundColor: backgroundColor,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              );
            }).toList(),
            value: application.realValueTime,
            onChanged: (value) {
              setState(() {
                application.realValueTime = value.toString();
                realValue = application.realValueTime
                    .replaceAll('ב-7 ימים הקרובים', 'this_week')
                    .replaceAll('היום', 'today')
                    .replaceAll('מחר', 'tomorrow')
                    .replaceAll('סוף השבוע', 'this_week_end')
                    .replaceAll('בשבוע הבא', 'next_week')
                    .replaceFirst('תאריך מסויים', 'specific_date');
              });
              widget.onChanged(realValue);
              _fetchEventData.getEventData(
                  1, '', realValue, '', '', '', '', '', '', context);
              print("qwerty$realValue");
              print('okokokkokkokkokokokokokokok');
            },
            icon: Icon(Icons.arrow_drop_down),
            iconEnabledColor: Colors.white,
            dropdownPadding: const EdgeInsets.all(0),
            itemPadding: EdgeInsets.all(0),
          ),
        ),
      ),
    );
  }
}
