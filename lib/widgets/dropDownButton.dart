import 'package:basalon/services/my_color.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/dialog/mult_select_dialog.dart';

// ignore: must_be_immutable
class DropButton extends StatefulWidget {
  String? text1;
  String? text2;
  dynamic onChanged;

  DropButton(
      {Key? key, required this.text1, required this.text2, this.onChanged})
      : super(key: key);

  @override
  State<DropButton> createState() => _DropButtonState();
}

class _DropButtonState extends State<DropButton> {
  String? val;
  bool checkboxToggle = false;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        // height: 60,
        decoration: BoxDecoration(
          color: MyColors.dropdownColor,
        ),
        // width: MediaQuery.of(context).size.width *0.15,
        // width: 200,
        margin: const EdgeInsets.only(left: 10.0, right: 25.0),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: DropdownButtonHideUnderline(
            child: DropdownButton2(
              dropdownOverButton: true,
              buttonHeight: 50,
              style: const TextStyle(
                color: Colors.white,
              ),
              selectedItemBuilder: (BuildContext context) {
                return <String>[
                  'מפגש חברתי',
                  'הרצאה',
                  'הופעה/מופע',
                  'סדנת יצירה',
                  'סדנת בישול/אפיה',
                  'סדנת גוף/נפש',
                  'סדנת יצירה',
                  'פעילות לילדים',
                ].map<Widget>(
                  (String item) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.text1!,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(right: 0.0),
                            alignment: Alignment.centerRight,
                            width: double.infinity,
                            child: Text(
                              item,
                              textAlign: TextAlign.end,
                              style: const TextStyle(
                                // fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Colors.white,
                              ),
                              maxLines: 1,
                              textDirection: TextDirection.rtl,
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
                crossAxisAlignment: CrossAxisAlignment.start,
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
                'group',
                'lecture',
                'show',
                'workshop',
                'body-mind',
                'food',
                'meals',
                'kids',
              ].map((item) {
                var backgroundColor =
                    (item == val) ? MyColors.topOrange : Colors.white;
                var textColor = (item == val) ? Colors.white : Colors.black;
                var checkBoxColor = (item == val)
                    ? checkboxToggle = true
                    : checkboxToggle = false;
                return DropdownMenuItem<String>(
                  value: item,
                  alignment: AlignmentDirectional.topEnd,
                  child: Container(
                    height: 30,
                    padding: EdgeInsets.only(top: 5, right: 10),
                    margin: EdgeInsets.all(0),
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
                        Expanded(
                            child: Checkbox(
                                side: BorderSide(width: 1, color: Colors.grey),
                                hoverColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                activeColor: Colors.transparent,
                                value: checkBoxColor,
                                onChanged: (ch) {
                                  setState(() {
                                    ch = !checkboxToggle;
                                  });
                                }))
                      ],
                    ),
                  ),
                );
              }).toList(),
              value: val,
              onChanged: (value) {
                setState(() {
                  // ignore: avoid_print
                  print(value);
                  val = value.toString();
                });
                widget.onChanged(value);
              },
              icon: const Icon(
                Icons.arrow_drop_down,
              ),
              iconEnabledColor: Colors.white,
              itemHeight: 40,
              dropdownPadding: const EdgeInsets.all(0),
              itemPadding: EdgeInsets.all(0),
            ),
          ),
        ),
      ),
    );
  }
}
