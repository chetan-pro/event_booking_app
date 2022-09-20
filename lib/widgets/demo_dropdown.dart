// import 'package:basalon/widgets/custom_plugin.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:getwidget/components/dropdown/gf_dropdown.dart';
// import 'package:getwidget/components/dropdown/gf_multiselect.dart';
// import 'package:getwidget/types/gf_checkbox_type.dart';
// import 'package:multiselect/multiselect.dart';

// import '../services/my_color.dart';

// class DemoDropdown extends StatefulWidget {
//   const DemoDropdown({Key? key}) : super(key: key);

//   @override
//   State<DemoDropdown> createState() => _DemoDropdownState();
// }

// class _DemoDropdownState extends State<DemoDropdown> {
//   String? dropdown;
//   dynamic dropdownValue;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 20),
//       padding: EdgeInsets.symmetric(horizontal: 10),
//       // height: 50,
//       color: MyColors.dropdownColor,
//       child: CustomMultiSelectDropdown(
//         isDense: true,
//         decoration: InputDecoration(
//           // prefixIcon: Icon(Icons.add),
//           // contentPadding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
//           fillColor: Colors.red,
//           // hintText: '\nmmmmmm',
//           hintTextDirection: TextDirection.rtl,
//           focusColor: Colors.green,
//           border: InputBorder.none,
//         ),
//         onChanged: (List<String> x) {
//           List<TextEditingController> name = [];
//           for (int i = 0; i < x.length; i++) {
//             name.add(TextEditingController());
//             name[i].text = x[i].toString();
//           }
//           print(x.map((e) => e));
//         },
//         childBuilder: (List list) {
//           return Text('datascasdas');
//         },
//         options: ['1', '2', '3', '4', '5', '6', 'Submit'],
//         selectedValues: [],
//         whenEmpty: 'askjasnkj',

//         // childBuilder: (List ){},
//       ),
//     );

//     // Stack(
//     //   children: [
//     //     GFMultiSelect(
//     //       items: ['1', '2', '3'],
//     //       onSelect: (value) {
//     //         print('selected $value ');
//     //       },
//     //       dropdownTitleTileText: 'UI, API, Apps ',
//     //       dropdownTitleTileColor: Colors.grey[200],
//     //       dropdownTitleTileMargin:
//     //           EdgeInsets.only(top: 22, left: 18, right: 18, bottom: 5),
//     //       dropdownTitleTilePadding: EdgeInsets.all(10),
//     //       dropdownUnderlineBorder:
//     //           const BorderSide(color: Colors.transparent, width: 2),
//     //       dropdownTitleTileBorder: Border.all(color: Colors.grey, width: 1),
//     //       dropdownTitleTileBorderRadius: BorderRadius.circular(5),
//     //       expandedIcon: const Icon(
//     //         Icons.keyboard_arrow_down,
//     //         color: Colors.black54,
//     //       ),
//     //       collapsedIcon: const Icon(
//     //         Icons.keyboard_arrow_down,
//     //         color: Colors.black54,
//     //       ),
//     //       submitButton: Text('OK'),
//     //       dropdownTitleTileTextStyle:
//     //           const TextStyle(fontSize: 14, color: Colors.black54),
//     //       padding: const EdgeInsets.all(6),
//     //       margin: const EdgeInsets.all(6),
//     //       type: GFCheckboxType.basic,
//     //       activeBgColor: Colors.green.withOpacity(0.5),
//     //       inactiveBorderColor: Colors.grey,
//     //     ),
//     //   ],
//     // );
//   }
// }

// //
// // import 'package:states_rebuilder/states_rebuilder.dart';
// //
// //
// //
// // import 'package:flutter/material.dart';
// //
// // class _TheState {}
// //
// // var _theState = RM.inject(() => _TheState());
// //
// // class TodoPage extends StatefulWidget {
// //   TodoPage({Key? key}) : super(key: key);
// //
// //   @override
// //   _TodoPageState createState() => _TodoPageState();
// // }
// //
// // class _TodoPageState extends State<TodoPage> {
// //   late String selectedValue; // **FOR DEFAULT VALUE**
// //   late String selectedValue2;
// //   List<String> dropDownItemValue = ['123', '2', '4', 'Create'];
// //   List<String> dropDownItemValue2 = ['xx', '2', '4'];
// //
// //   late final dropDownKey2;
// //
// //   final FocusNode dropDownFocus = FocusNode();
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //
// //     ///selected value must be contain at dropDownItemValue
// //     selectedValue = dropDownItemValue[0];
// //     selectedValue2 = dropDownItemValue2[0];
// //   }
// //
// //   bool showCheckbox = false;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return GestureDetector(
// //       onTap: () {
// //         setState(() {
// //           showCheckbox = true;
// //         });
// //         print('gesture dba');
// //       },
// //       child: Container(
// //         color: Colors.pink,
// //         // height: 50,
// //         child: GestureDetector(
// //           onTap: (){
// //             setState(() {
// //               showCheckbox = true;
// //             });
// //             print('gesture dba');
// //           },
// //           child: Column(
// //             // mainAxisAlignment: MainAxisAlignment.center,
// //             crossAxisAlignment: CrossAxisAlignment.end,
// //             children: [
// //               // MyTabBar(),
// //
// //               // DropdownButtonHideUnderline(
// //               //   child: DropdownButton<String>(
// //               //     value: selectedValue, // CANT SET THE DEFAULT VALUE**
// //               //     isExpanded: true,
// //               //     // icon: Image.asset('assets/down-list-arrow.png'),
// //               //     iconSize: 10,
// //               //     elevation: 16,
// //               //     onChanged: (newValue) {
// //               //       print(newValue);
// //               //       setState(() {
// //               //         selectedValue = newValue!; //   SET THE DEFAULT VALUE**
// //               //       });
// //               //     },
// //               //
// //               //     /// dont assing same value on multiple widget
// //               //     items: List.generate(
// //               //       dropDownItemValue.length,
// //               //           (index) => DropdownMenuItem(
// //               //           child: Text('${dropDownItemValue[index]}'),
// //               //           value: '${dropDownItemValue[index]}'),
// //               //     ),
// //               //   ),
// //               // ),
// //               DropdownButtonHideUnderline(
// //                 child: DropdownButton<String>(
// //                   focusNode: dropDownFocus,
// //                   value: selectedValue2,
// //                   // CANT SET THE DEFAULT VALUE**
// //                   isExpanded: true,
// //                   // icon: Icon(Icons.arrow_drop_down,size: 20,),
// //                   iconSize: 10,
// //                   elevation: 16,
// //                   onChanged: (newValue) {
// //                     print(newValue == null);
// //                     // if value doesnt contain just close the dropDown
// //                     if (newValue == null) {
// //                       dropDownFocus.unfocus();
// //                     } else
// //                       setState(() {
// //                         selectedValue2 = newValue; //   SET THE DEFAULT VALUE**
// //                       });
// //                   },
// //
// //                   /// dont assing same value on multiple widget
// //                   items: List.generate(
// //                     dropDownItemValue2.length + 1,
// //                     (index) => index < dropDownItemValue2.length
// //                         ? DropdownMenuItem(
// //                             child: Stack(
// //                               children: [
// //                                 Row(
// //                                   mainAxisAlignment: MainAxisAlignment.end,
// //                                   children: [
// //                                     Text('${dropDownItemValue2[index]}'),
// //                                     // if (showCheckbox == true)
// //                                       Checkbox(
// //                                           value: showCheckbox,
// //                                           onChanged: (x) {
// //                                             setState(() {
// //                                               showCheckbox = x!;
// //                                             });
// //                                             // widget.onChange(x!);
// //                                             _theState.notify();
// //                                             print('uuuuuu$x');
// //                                           }),
// //                                   ],
// //                                 ),
// //                               ],
// //                             ), // Text('${dropDownItemValue2[index]}'),
// //                             value: '${dropDownItemValue2[index]}')
// //                         : DropdownMenuItem(
// //                             child: Center(
// //                               child: ElevatedButton(
// //                                 child: Text('Create'),
// //                                 onPressed: () {},
// //                               ),
// //                             ),
// //                           ),
// //                   ),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
// // class _SelectRow extends StatefulWidget {
// //   final Function(bool) onChange;
// //   final bool selected;
// //   final String text;
// //
// //   const _SelectRow(
// //       {Key? key,
// //       required this.onChange,
// //       required this.selected,
// //       required this.text})
// //       : super(key: key);
// //
// //   @override
// //   State<_SelectRow> createState() => _SelectRowState();
// // }
// //
// // class _SelectRowState extends State<_SelectRow> {
// //   bool showCheckbox = false;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Stack(
// //       children: [
// //         Row(
// //           mainAxisAlignment: MainAxisAlignment.end,
// //           children: [
// //             Text(widget.text),
// //             if (showCheckbox == true)
// //               Checkbox(
// //                   value: widget.selected,
// //                   onChanged: (x) {
// //                     widget.onChange(x!);
// //                     // _theState.notify();
// //                     print('uuuuuu$x');
// //                   }),
// //           ],
// //         ),
// //       ],
// //     );
// //   }
// // }
