import 'package:flutter/material.dart';

AnimatedContainer CustomButton(
    {Color? color,
    String? text,
    double? radius,
    bool isloader = false,
    Widget? loader,
    double? width,
    Color? outlineColor,
    double? height,
    void Function()? onEnd,
    bool isOutlinedButton = false,
    TextStyle? textStyle,
    dynamic iconColor,
    dynamic icon,
    void Function()? onPressed}) {
  return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      onEnd: onEnd,
      width: width,
      height: height,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(radius ?? 30)),
      child: isOutlinedButton
          ? isloader
              ? loader
              : OutlinedButton(
                  style: ButtonStyle(
                    //  backgroundColor: getMaterialColor(color: color),
                    side: MaterialStateProperty.all<BorderSide>(BorderSide(
                        width: 2.0, color: outlineColor ?? Colors.white)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(radius ?? 5),
                    )),
                  ),
                  onPressed: onPressed ?? () {},
                  child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: isloader
                          ? loader
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  text ?? '',
                                  style: textStyle,
                                ),
                                if (icon != null)
                                  Expanded(
                                    child: Icon(
                                      icon,
                                      color: iconColor,
                                    ),
                                  )
                              ],
                            )))
          : isloader
              ? loader
              : ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: color,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      )
                      //backgroundColor: getMaterialColor(color: color)
                      ),
                  onPressed: onPressed ?? () {},
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: isloader
                        ? loader
                        : Text(
                            text ?? '',
                            style: textStyle,
                          ),
                  )));
}
