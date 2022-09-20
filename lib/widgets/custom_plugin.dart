// library multiselect;

// import 'package:flutter/material.dart';
// import 'package:states_rebuilder/states_rebuilder.dart';

// class _TheState {}

// var _theState = RM.inject(() => _TheState());

// class _SelectRow extends StatelessWidget {
//   final Function(bool) onChange;
//   final bool selected;
//   final String text;

//   const _SelectRow(
//       {Key? key,
//       required this.onChange,
//       required this.selected,
//       required this.text})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             Text(text),
//             Checkbox(
//                 value: selected,
//                 onChanged: (x) {
//                   onChange(x!);
//                   _theState.notify();
//                   print('uuuuuu$x');
//                 }),
//           ],
//         ),
//       ],
//     );
//   }
// }

// ///
// /// A Dropdown multiselect menu
// ///
// ///
// class CustomMultiSelectDropdown extends StatefulWidget {
//   /// The options form which a user can select
//   final List<String> options;

//   /// Selected Values
//   final List<String> selectedValues;

//   /// This function is called whenever a value changes
//   final Function(List<String>) onChanged;

//   /// defines whether the field is dense
//   final bool isDense;

//   /// defines whether the widget is enabled;
//   final bool enabled;

//   /// Input decoration
//   final InputDecoration? decoration;

//   /// this text is shown when there is no selection
//   final String? whenEmpty;

//   /// a function to build custom childern
//   final Widget Function(List<String> selectedValues)? childBuilder;

//   /// a function to build custom menu items
//   final Widget Function(String option)? menuItembuilder;

//   const CustomMultiSelectDropdown({
//     Key? key,
//     required this.options,
//     required this.selectedValues,
//     required this.onChanged,
//     required this.whenEmpty,
//     this.childBuilder,
//     this.menuItembuilder,
//     this.isDense = false,
//     this.enabled = true,
//     this.decoration,
//   }) : super(key: key);

//   @override
//   _CustomMultiSelectDropdownState createState() =>
//       _CustomMultiSelectDropdownState();
// }

// class _CustomMultiSelectDropdownState extends State<CustomMultiSelectDropdown> {
//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Container(
//         height: 50,
//         child: Stack(
//           children: [
//             _theState.rebuilder(() => widget.childBuilder != null
//                 ? widget.childBuilder!(widget.selectedValues)
//                 : Align(
//                     child: Padding(
//                         padding: EdgeInsets.symmetric(
//                           vertical: 15,
//                         ),
//                         child: Text(
//                           widget.selectedValues.length > 0
//                               ? widget.selectedValues
//                                   .reduce((a, b) => a + ' , ' + b)
//                               : widget.whenEmpty ?? '',
//                           style: TextStyle(color: Colors.white),
//                         )),
//                     alignment: Alignment.centerRight,
//                   )),
//             Align(
//               alignment: Alignment.centerLeft,
//               child: Container(
//                 margin: EdgeInsets.symmetric(horizontal: 10),
//                 child: DropdownButtonFormField<String>(
//                   decoration: widget.decoration != null
//                       ? widget.decoration
//                       : InputDecoration(
//                           border: OutlineInputBorder(),
//                           isDense: true,
//                           contentPadding: EdgeInsets.symmetric(
//                             vertical: 15,
//                           ),
//                         ),
//                   isDense: true,
//                   onChanged: widget.enabled ? (x) {} : null,
//                   value: null,
//                   selectedItemBuilder: (context) {
//                     return widget.options
//                         .map((e) => DropdownMenuItem(
//                               child: Container(),
//                             ))
//                         .toList();
//                   },
//                   items: widget.options
//                       .map((x) => DropdownMenuItem(
//                             child: _theState.rebuilder(
//                               () {
//                                 return widget.menuItembuilder != null
//                                     ? widget.menuItembuilder!(x)
//                                     : _SelectRow(
//                                         selected:
//                                             widget.selectedValues.contains(x),
//                                         text: x,
//                                         onChange: (isSelected) {
//                                           if (isSelected) {
//                                             var ns = widget.selectedValues;
//                                             ns.add(x);
//                                             widget.onChanged(ns);
//                                           } else {
//                                             var ns = widget.selectedValues;
//                                             ns.remove(x);
//                                             widget.onChanged(ns);
//                                           }
//                                         },
//                                       );
//                               },
//                             ),
//                             value: x,
//                             onTap: () {
//                               if (widget.selectedValues.contains(x)) {
//                                 var ns = widget.selectedValues;
//                                 ns.remove(x);
//                                 widget.onChanged(ns);
//                               } else {
//                                 var ns = widget.selectedValues;
//                                 ns.add(x);
//                                 widget.onChanged(ns);
//                               }
//                             },
//                           ))
//                       .toList(),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
