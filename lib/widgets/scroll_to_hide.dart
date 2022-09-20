import 'package:flutter/material.dart';

class ScrollToHide extends StatefulWidget {
  ScrollToHide(
      {required this.child,
      this.duration = const Duration(milliseconds: 500),
      required this.scrollViewController});

  final ScrollController scrollViewController;
  final Duration duration;
  final Widget child;

  @override
  _ScrollToHideState createState() => _ScrollToHideState();
}

class _ScrollToHideState extends State<ScrollToHide> {
  bool isVisible = false;

  @override
  void initState() {
    widget.scrollViewController.addListener(listen);
    super.initState();
  }

  @override
  void dispose() {
    widget.scrollViewController.removeListener(listen);

    // TODO: implement dispose
    super.dispose();
  }

  void listen() {
    final direction = widget.scrollViewController.position.userScrollDirection;
    if (widget.scrollViewController.offset > 400) {
      setState(() {
        isVisible = true;
      });
    } else {
      setState(() {
        isVisible = false;
      });
    }
  }

  void show() {
    if (!isVisible) {
      setState(() {
        isVisible = true;
      });
    }
  }

  void hide() {
    if (!isVisible) {
      setState(() {
        isVisible = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: AnimatedContainer(
        height: isVisible ? 120 : 0,
        duration: widget.duration,
        child: Wrap(
          runAlignment: WrapAlignment.end,
          children: [widget.child],
        ),
      ),
    );
  }
}
