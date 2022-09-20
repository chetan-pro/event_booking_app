import 'package:flutter/material.dart';


class CustomIconButton extends StatefulWidget {
  const CustomIconButton(
      {Key? key,
      this.context,
      this.color,
      required this.onpressed,
      required this.icon,
      this.iconSize,
      this.iconsSplashRadius})
      : super(key: key);
  final Function() onpressed;
  final IconData icon;
  final BuildContext? context;
  final double? iconSize;
  final double? iconsSplashRadius;
  final Color? color;
  @override
  _CustomIconButtonState createState() => _CustomIconButtonState();
}

class _CustomIconButtonState extends State<CustomIconButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: widget.onpressed,
      icon: Icon(widget.icon,
      ),
         // size: widget.iconSize ?? 15.sp, color: widget.color),
     // splashRadius: widget.iconsSplashRadius ?? splashRadius,
    );
  }
}

class HamburgerMenu extends StatelessWidget {
  const HamburgerMenu({
    required this.context,
    Key? key,
  }) : super(key: key);
  final BuildContext context;
  @override
  Widget build(BuildContext context) {
    return CustomIconButton(
        icon: Icons.menu,
        color: Theme.of(context).iconTheme.color,
        onpressed: () {
          Scaffold.of(context).openDrawer();
        });
  }
}
