import 'package:basalon/services/my_color.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../blocs/application_bloc.dart';

// ignore: must_be_immutable
class DropButtonByAnywhere extends StatefulWidget {
  String? text1;
  String? text2;
  dynamic onChanged;

  DropButtonByAnywhere(
      {Key? key, required this.text1, required this.text2, this.onChanged})
      : super(key: key);

  @override
  State<DropButtonByAnywhere> createState() => _DropButtonByAnywhereState();
}

class _DropButtonByAnywhereState extends State<DropButtonByAnywhere> {
  // String val = 'בכל מקום';
  bool checkboxToggle = false;
  late final application = Provider.of<ApplicationBloc>(context, listen: false);

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
        // margin: const EdgeInsets.only(left: 10.0, right: 25.0),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: DropdownButtonHideUnderline(
            child: DropdownButton2(
              dropdownDecoration: (BoxDecoration(color: Colors.transparent)),
              dropdownElevation: 10,
              dropdownOverButton: true,
              offset: const Offset(0, 100),
              style: const TextStyle(
                color: Colors.white,
              ),
              selectedItemBuilder: (BuildContext context) {
                return <String>[
                  'בכל מקום',
                  'קרוב אליי',
                  'עיר מסויימת',
                  'אונליין / זום',
                ].map<Widget>(
                  (String item) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          widget.text1!,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(right: 0.0),
                            alignment: Alignment.center,
                            width: double.infinity,
                            child: Text(
                              item,
                              textAlign: TextAlign.center,
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
                'בכל מקום',
                'קרוב אליי',
                'עיר מסויימת',
                'אונליין / זום',
              ].map((item) {
                var backgroundColor = (item == application.val)
                    ? MyColors.topOrange
                    : Colors.white;
                var textColor =
                    (item == application.val) ? Colors.white : Colors.black;
                var checkBoxColor = (item == application.val)
                    ? checkboxToggle = true
                    : checkboxToggle = false;
                return DropdownMenuItem<String>(
                  value: item,
                  alignment: AlignmentDirectional.topEnd,
                  child: Container(
                    height: 50,
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
                      ],
                    ),
                  ),
                );
              }).toList(),
              value: application.val,
              onChanged: (value) {
                setState(() {
                  // ignore: avoid_print
                  print(value);
                  widget.onChanged(value);
                  application.val = value.toString();
                });
              },
              icon: const Icon(
                Icons.arrow_drop_down,
              ),
              iconEnabledColor: Colors.white,
              itemHeight: 40,
              dropdownPadding: const EdgeInsets.only(bottom: 60),
              itemPadding: EdgeInsets.all(0),
            ),
          ),
        ),
      ),
    );
  }
}
