import 'package:flutter/material.dart';



class DropdownWidget extends StatefulWidget {
 //String? _dropDownValue;
  String? dropdownValue;
//  Function onchanged; 
 List<String> ? items;
   DropdownWidget({ Key? key , required hintText, required this.items}) : super(key: key);

  @override
  State<DropdownWidget> createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  String? hintText;

  @override
  Widget build(BuildContext context) {
    return     Container(
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                          border: Border.all(
                              color: const Color.fromRGBO(216, 216, 216, 1))),
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: DropdownButtonHideUnderline(
                          child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButton(
                              isExpanded: true,
                              menuMaxHeight: 100,
                              hint: widget.dropdownValue == null
                                  ?  Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                       hintText!,
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        widget.dropdownValue!,
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                    ),
                              iconSize: 30.0,
                              style: const TextStyle(color: Colors.black),
                              items: widget.items!.map(
                                (val) {
                                  return DropdownMenuItem<String>(
                                    value: val,
                                    child: Text(val),
                                  );
                                },
                              ).toList(),
                              onChanged: (val) {
                              //  onchanged;
                                setState(
                                  () {
                                    widget.dropdownValue = val as String?;
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    );
                
                
  }
}