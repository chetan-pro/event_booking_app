import 'package:basalon/services/my_color.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../blocs/application_bloc.dart';

// ignore: must_be_immutable
class DropButtonByTime extends StatefulWidget {
  String? text1;
  String? text2;
  dynamic onChanged;
  dynamic onTap;

  DropButtonByTime(
      {Key? key,
      required this.text1,
      required this.text2,
      this.onChanged,
      this.onTap})
      : super(key: key);

  @override
  State<DropButtonByTime> createState() => _DropButtonByTimeState();
}

class _DropButtonByTimeState extends State<DropButtonByTime> {
  late final application = Provider.of<ApplicationBloc>(context, listen: false);

  // String val = 'ב-7 ימים הקרובים';
  bool checkboxToggle = false;
  String? realValue;

  @override
  Widget build(BuildContext context) {
    print('bottom drpoop');
    print(application.realValueTime);
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: MyColors.dropdownColor,
        // border: Border(right: BorderSide(color: Colors.grey))
        // borderRadius: BorderRadius.circular(10),
      ),
      // width: MediaQuery.of(context).size.width *0.15,
      // width: 200,
      // margin: const EdgeInsets.only(left: 10.0, right: 25.0),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: DropdownButtonHideUnderline(
          child: ButtonTheme(
            alignedDropdown: false,
            child: DropdownButton2(
              dropdownPadding: const EdgeInsets.only(bottom: 60),
              dropdownElevation: 10,
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
                ].map<Widget>(
                  (String item) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: Text(
                            widget.text1!,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(right: 0.0),
                            alignment: Alignment.center,
                            width: double.infinity,
                            child: Text(
                              item,
                              // textAlign: TextAlign.end,
                              style: const TextStyle(
                                // fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Colors.white,
                              ),
                              maxLines: 1,
                              textDirection: TextDirection.rtl,
                              // softWrap: true,
                              // overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ).toList();
              },
              isExpanded: true,
              hint: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    widget.text1!,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    widget.text2!,
                    style: const TextStyle(
                      // fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Colors.white,
                    ),
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
                var checkBoxColor = (item == application.realValueTime)
                    ? checkboxToggle = true
                    : checkboxToggle = false;
                return DropdownMenuItem<String>(
                  value: item,
                  alignment: AlignmentDirectional.topEnd,
                  child: Container(
                    height: 50,
                    padding: EdgeInsets.only(top: 5, right: 10),
                    // margin: EdgeInsets.only(bottom: 50),
                    width: double.infinity,
                    color: backgroundColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Text(
                            item,
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 14,
                              // fontWeight: FontWeight.bold,
                              color: textColor,
                              // backgroundColor: backgroundColor,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
              value: application.realValueTime,
              onChanged: (value) {
                setState(() {
                  // ignore: avoid_print
                  print(value);
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
              },
              // onTap: () {
              //   widget.onTap;
              // },
              icon: const Icon(
                Icons.arrow_drop_down,
              ),
              iconEnabledColor: Colors.white,
              itemHeight: 40,
              itemPadding: EdgeInsets.all(0),
              dropdownDecoration: BoxDecoration(color: Colors.transparent),
            ),
          ),
        ),
      ),
    );
  }
}
