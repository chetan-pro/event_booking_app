import 'package:basalon/services/my_color.dart';
import 'package:flutter/material.dart';

class FilterCardWidget extends StatefulWidget {
  String text;

  double? fontsize;

  Color? color;
  FilterCardWidget({Key? key, required this.text, this.color, this.fontsize})
      : super(key: key);

  @override
  State<FilterCardWidget> createState() => _FilterCardWidgetState();
}

class _FilterCardWidgetState extends State<FilterCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 4),
      child: Text(
        widget.text,
        style: TextStyle(
          fontFamily: "Helvetica",
          fontSize: widget.fontsize ?? 14,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        maxLines: 1,
        textAlign: TextAlign.center,

        // overflow: TextOverflow.ellipsis,
      ),
      decoration: BoxDecoration(
        color: widget.color ?? MyColors.lightBlue,
        borderRadius: BorderRadius.circular(13),
      ),
      padding: EdgeInsets.symmetric(horizontal: 3, vertical: 2),
    );
  }
}
