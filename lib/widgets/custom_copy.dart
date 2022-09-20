import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CopiableText extends StatelessWidget {
  final String text;
  final String copyMessage;
  final Widget child;

  CopiableText(this.text, {required this.copyMessage, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(this.copyMessage),
          ));
          Clipboard.setData(new ClipboardData(text: this.text));
        },
        child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
            child: this.child
          ),
        ),
      ),
    );
  }
}