import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextFieldValidate extends StatelessWidget {
  CustomTextFieldValidate({
    this.label,
    this.hintText,
    required this.obscureText,
    this.prefixIcon,
    this.height,
    this.controller,
  });

  final String? label;
  int? height;
  final TextEditingController? controller;
  final String? hintText;
  final bool obscureText;
  final Widget? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(label!),
          SizedBox(
            height: 5,
          ),
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return '*field is required';
              } else {
                return null;
              }
            },
            obscureText: obscureText,
            maxLines: 1,
            textAlignVertical: TextAlignVertical.top,
            textAlign: TextAlign.end,
            controller: controller,
            style: TextStyle(fontSize: 15),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left: 10, right: 10),
              hintText: hintText,
              prefixIcon: prefixIcon,
            ),
          ),
        ],
      ),
    );
  }
}
