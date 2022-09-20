// import 'package:basalon/network/get_events_network.dart';
// import 'package:basalon/screens/home_page.dart';
// import 'package:basalon/services/my_color.dart';
// import 'package:basalon/widgets/demo_dropdown.dart';
// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_multiselect/flutter_multiselect.dart';
// import 'package:get/get.dart';
// import 'package:multi_select_flutter/dialog/mult_select_dialog.dart';
// import 'package:multi_select_flutter/multi_select_flutter.dart';
// import 'package:multi_select_flutter/util/multi_select_item.dart';
// import 'package:multiselect/multiselect.dart';

// import '../modal/event_category_model.dart';

// class Animal {
//   final int? id;
//   final String? name;

//   Animal({
//     this.id,
//     this.name,
//   });
// }

// class DropdownCategories extends StatefulWidget {
//   String? text1;
//   String? text2;
//   dynamic onChanged;
//   dynamic onTap;

//   dynamic categories;

//   DropdownCategories({
//     Key? key,
//     required this.text1,
//     required this.text2,
//     this.onChanged,
//     this.onTap,
//     required this.categories,
//   }) : super(key: key);

//   @override
//   State<DropdownCategories> createState() => _DropdownCategoriesState();
// }

// class _DropdownCategoriesState extends State<DropdownCategories> {
//   String? val;
//   String? realValue;

//   bool checkboxToggle = false;

//   dynamic newValue;

//   late final FetchEventData _fetchEventData = FetchEventData(
//     filterByCategory: val,
//   );

//   //
//   // static List dropItems = [
//   //   'בכל מקום',
//   //   'לידי',
//   //   'עיר מסויימת',
//   //   'אונליין / זום',
//   //   'food',
//   //   'body-mind',
//   //   'workshop',
//   //   'kids',
//   // ];

//   late List<Datum> catList = widget.categories;

//   // static List<Animal> _animals = [
//   //   Animal(id: 1, name: "Lion"),
//   //   Animal(id: 2, name: "Flamingo"),
//   //   Animal(id: 3, name: "Hippo"),
//   //   Animal(id: 4, name: "Horse"),
//   //   Animal(id: 5, name: "Tiger"),
//   //   Animal(id: 6, name: "Penguin"),
//   //   Animal(id: 7, name: "Spider"),
//   //   Animal(id: 8, name: "Snake"),
//   //
//   // ];
//   late final _items = catList
//       .map((animal) => MultiSelectItem(animal.termId, animal.slug!))
//       .toList();

//   Rx<List<String>> selectedOption = Rx<List<String>>([]);
//   var selectedValue = ''.obs;
//   List<String> selected = [];

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     // _fetchEventData.getEventData(1, context);
//   }

//   final _selectedValues = [];

//   List<MultiSelectItem<int>> multiItem = [];
//   final valuestopopulate = {
//     1: "אירוח קולינרי",
//     2: "הופעה/מופע",
//     3: "הרצאה",
//     4: "מפגש חברתי",
//     5: "סדנת בישול/אפיה",
//     6: "סדנת גוף/נפש",
//     7: "סדנת יצירה",
//     8: "פעילות לילדים",
//   };

//   // late final valuestopopulate = catList.map((e) => e.termId);

//   void populateMultiselect() {
//     for (int v in valuestopopulate.keys) {
//       multiItem.add(MultiSelectItem(v, valuestopopulate[v]!));
//     }
//   }

//   void _showMultiSelectAlert(BuildContext context) async {
//     multiItem = [];
//     populateMultiselect();
//     final items = multiItem;

//     final selectedValues = await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Directionality(
//           textDirection: TextDirection.rtl,
//           child: MultiSelectDialog(
//             separateSelectedItems: false,
//             title: Text(
//               'ניתן לבחור יותר מקטגוריה אחת',
//               style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
//               textAlign: TextAlign.center,
//             ),
//             cancelText: Text(''),
//             confirmText: Text(
//               'סיימתי לבחור',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                   // background: Paint()..color = MyColors.dropdownColor
//                   //   ..strokeWidth = 17
//                   //   ..style = PaintingStyle.stroke,
//                   fontSize: 18),
//             ),
//             selectedColor: MyColors.topOrange,
//             height: MediaQuery.of(context).size.height / 2,
//             items: items,

//             initialValue: [],
//             onConfirm: (v) {
//               print(v.first);
//               print('confirm chala');
//             },
//           ),
//         );
//       },
//     );

//     getvaluefromkey(selectedValues!);
//   }

//   void getvaluefromkey(Set selection) {
//     if (selection != null) {
//       for (int x in selection.toList()) {
//         print('confirm chala uuuuuuuuuuuuuuuuuuuuuuu');

//         print(valuestopopulate[x]);
//       }
//     }
//   }

//   void _onCancelTap() {
//     Navigator.pop(context);
//   }

//   void _onSubmitTap() {
//     Navigator.pop(context, _selectedValues);
//   }

//   @override
//   Widget build(BuildContext context) {
//     print('dropdown dropdown dropdowndropdown');
//     return
//         DemoDropdown();
// // TodoPage();
//     //     GestureDetector(
//     //   onTap: () {
//     //     _showMultiSelectAlert(context);
//     //   },
//     //   child: Container(
//     //     margin: const EdgeInsets.symmetric(horizontal: 20),
//     //     padding: EdgeInsets.symmetric(horizontal: 10),
//     //     height: 50,
//     //     color: MyColors.dropdownColor,
//     //     child: Row(
//     //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     //       children: [
//     //         Icon(
//     //           Icons.arrow_drop_down,
//     //           color: Colors.white,
//     //         ),
//     //         Text(
//     //           '${widget.text1}\n${widget.text2}',
//     //           style: TextStyle(color: Colors.white),
//     //           textDirection: TextDirection.rtl,
//     //         )
//     //       ],
//     //     ),
//     //   ),
//     // );
//   }
// }

// class MultiSelectDialogItem<V> {
//   const MultiSelectDialogItem(this.value, this.label);

//   final V? value;
//   final String? label;
// }

// ///////////////////////////////////////////////////////////////////
// // return Directionality(
// // textDirection: TextDirection.rtl,
// // child: Container(
// // // height: 50,
// // decoration: BoxDecoration(
// // color: MyColors.dropdownColor,
// // ),
// // margin: const EdgeInsets.symmetric(horizontal: 20),
// // padding: EdgeInsets.symmetric(horizontal: 10),
// // child: DropDownMultiSelect(
// // enabled: false,
// //
// // decoration: InputDecoration(
// //
// // // suffixIcon: Icon(Icons.arrow_drop_down,color: Colors.white,),
// // iconColor: Colors.white,
// //
// // hintText: '${widget.text1}\n${widget.text2}',
// // hintStyle: TextStyle(color: Colors.white),
// // fillColor: Colors.white,
// // focusColor: Colors.white,
// // suffixIconColor: Colors.white,
// // hoverColor: Colors.white,
// // prefixStyle: TextStyle(color: Colors.white),
// // suffixStyle: TextStyle(color: Colors.white),
// // border: InputBorder.none),
// // onChanged: (List<String> x) {
// // setState(() {
// // selected = x;
// // });
// // },
// // options: dropItems,
// // selectedValues: selected,
// // whenEmpty: '',
// // ),
// //
// // ),
// // );

// // return Container(
// //   decoration: BoxDecoration(
// //     color: MyColors.dropdownColor,
// //   ),
// //   // width: MediaQuery.of(context).size.width *0.15,
// //
// //   margin: const EdgeInsets.symmetric(horizontal: 20),
// //   padding: EdgeInsets.symmetric(horizontal: 10),
// //   child: Directionality(
// //     textDirection: TextDirection.rtl,
// //     child: Column(
// //       children: [
// //         DropdownButtonHideUnderline(
// //           child: DropdownButton2(
// //             style: const TextStyle(
// //               color: Colors.white,
// //             ),
// //             selectedItemBuilder: (BuildContext context) {
// //               return dropItems.map<Widget>((String item) {
// //                 return Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   mainAxisAlignment: MainAxisAlignment.center,
// //                   children: [
// //                     Text(
// //                       widget.text1!,
// //                       style: const TextStyle(
// //                         fontSize: 12,
// //                         color: Colors.white,
// //                       ),
// //                       overflow: TextOverflow.ellipsis,
// //                     ),
// //                     Container(
// //                         padding: const EdgeInsets.only(right: 0.0),
// //                         alignment: Alignment.centerRight,
// //                         child: Text(
// //                           item,
// //                           textAlign: TextAlign.end,
// //                           style: const TextStyle(
// //                             fontWeight: FontWeight.w100,
// //                             color: Colors.white,
// //                             fontSize: 16,
// //                           ),
// //                         ))
// //                   ],
// //                 );
// //               }).toList();
// //             },
// //
// //             isExpanded: true,
// //             hint: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               mainAxisAlignment: MainAxisAlignment.center,
// //               children: [
// //                 Text(
// //                   widget.text1!,
// //                   style: const TextStyle(
// //                     fontSize: 12,
// //                     color: Colors.white,
// //                   ),
// //                   overflow: TextOverflow.ellipsis,
// //                 ),
// //                 Text(
// //                   widget.text2!,
// //                   style: const TextStyle(
// //                     fontWeight: FontWeight.w100,
// //                     color: Colors.white,
// //                     fontSize: 16,
// //                   ),
// //                   overflow: TextOverflow.ellipsis,
// //                 )
// //               ],
// //             ),
// //             items: dropItems.map((item) {
// //               var backgroundColor =
// //                   (item == val) ? MyColors.topOrange : Colors.white;
// //               var textColor = (item == val) ? Colors.white : Colors.black;
// //               var checkBoxColor = (item == val)
// //                   ? checkboxToggle = true
// //                   : checkboxToggle = false;
// //
// //               return DropdownMenuItem<String>(
// //                 enabled: true,
// //                 value: item,
// //                 alignment: AlignmentDirectional.topEnd,
// //                 child: Container(
// //                   margin: EdgeInsets.all(0),
// //                   height: 40,
// //                   padding: const EdgeInsets.only(top: 10.0, right: 10),
// //                   width: double.infinity,
// //                   color: backgroundColor,
// //                   child: Row(
// //                     mainAxisAlignment: MainAxisAlignment.end,
// //                     children: [
// //                       Text(
// //                         item,
// //                         textAlign: TextAlign.right,
// //                         style: TextStyle(
// //                           fontSize: 16,
// //                           // fontWeight: FontWeight.bold,
// //                           color: textColor,
// //                           // backgroundColor: backgroundColor,
// //                         ),
// //                         overflow: TextOverflow.ellipsis,
// //                       ),
// //                       Checkbox(
// //                           side: BorderSide(width: 1, color: Colors.grey),
// //                           hoverColor: Colors.transparent,
// //                           focusColor: Colors.transparent,
// //                           activeColor: Colors.transparent,
// //                           value: checkBoxColor,
// //                           onChanged: (ch) {
// //                             setState(() {
// //                               ch = !checkboxToggle;
// //                             });
// //                           })
// //                     ],
// //                   ),
// //                 ),
// //               );
// //             }).toList(),
// //
// //             value: val,
// //             onChanged: (value) {
// //               setState(() {
// //                 val = value.toString();
// //
// //                 if (value == 'בכל מקום') {
// //                   setState(() {
// //                     realValue = 'food';
// //                   });
// //                 } else {
// //                   realValue = "";
// //                 }
// //               });
// //               widget.onChanged(realValue);
// //               print(value);
// //             },
// //             // onTap:widget.onTap,
// //             icon: Icon(Icons.arrow_drop_down),
// //             iconEnabledColor: Colors.white,
// //             dropdownPadding: const EdgeInsets.all(0),
// //             itemPadding: EdgeInsets.all(0),
// //           ),
// //         ),
// //       ],
// //     ),
// //   ),
// // );
// // return MultiSelectDialogField(
// //   onSaved: (v){
// //     print(v);
// //     print('pppppppppppppppppppppppppp');
// //   },
// //     onSelectionChanged: (v){
// //     print(v);
// //     print('zzzzzzzzzzzzzzzzzzz');
// //
// //     },
// //   title: Text(''),
// //     items: _items,
// //     onConfirm: (result) {
// //       print('erererer${result.map((e) => e)}');
// //     });
