/// A widget based custom info window for google_maps_flutter package.
library custom_info_windows;

import 'dart:io';
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

/// Controller to add, update and control the custom info window.
class CustomInfoWindowsController {
  /// Add custom [Widget] and [Marker]'s [LatLng] to [CustomInfoWindows] and make it visible.
  Function(Widget, LatLng)? addInfoWindow;

  /// Notifies [CustomInfoWindows] to redraw as per change in position.
  VoidCallback? onCameraMove;

  /// Hides [CustomInfoWindows].
  VoidCallback? hideInfoWindow;

  /// Holds [GoogleMapController] for calculating [CustomInfoWindows] position.
  GoogleMapController? googleMapController;

  void dispose() {
    addInfoWindow = null;
    onCameraMove = null;
    hideInfoWindow = null;
    googleMapController = null;
  }
}

/// A stateful widget responsible to create widget based custom info window.
class CustomInfoWindows extends StatefulWidget {
  /// A [CustomInfoWindowsController] to manipulate [CustomInfoWindows] state.
  final CustomInfoWindowsController controller;

  /// Offset to maintain space between [Marker] and [CustomInfoWindows].
  final double offset;

  /// Height of [CustomInfoWindows].
  final double height;

  /// Width of [CustomInfoWindows].
  final double width;

  const CustomInfoWindows({
    required this.controller,
    this.offset = 50,
    this.height = 50,
    this.width = 100,
  })  : assert(controller != null),
        assert(offset != null),
        assert(offset >= 0),
        assert(height != null),
        assert(height >= 0),
        assert(width != null),
        assert(width >= 0);

  @override
  _CustomInfoWindowsState createState() => _CustomInfoWindowsState();
}

class _CustomInfoWindowsState extends State<CustomInfoWindows> {
  bool _showNow = false;
  double _leftMargin = 0;
  double _topMargin = 0;
  Widget? _child;
  LatLng? _latLng;

  @override
  void initState() {
    super.initState();
    widget.controller.addInfoWindow = _addInfoWindow;
    widget.controller.onCameraMove = _onCameraMove;
    widget.controller.hideInfoWindow = _hideInfoWindow;
  }

  /// Calculate the position on [CustomInfoWindows] and redraw on screen.
  void _updateInfoWindow() async {
    if (_latLng == null ||
        _child == null ||
        widget.controller.googleMapController == null) {
      return;
    }
    ScreenCoordinate screenCoordinate = await widget
        .controller.googleMapController!
        .getScreenCoordinate(_latLng!);
    double devicePixelRatio =
    Platform.isAndroid ? MediaQuery.of(context).devicePixelRatio : 1.0;
    double left =
        (screenCoordinate.x.toDouble() / devicePixelRatio) - (widget.width / 2);
    double top = (screenCoordinate.y.toDouble() / devicePixelRatio) -
        (widget.offset + widget.height);
    setState(() {
      _showNow = true;
      _leftMargin = left;
      _topMargin = top;
    });
  }

  /// Assign the [Widget] and [Marker]'s [LatLng].
  void _addInfoWindow(Widget child, LatLng latLng) {
    assert(child != null);
    assert(latLng != null);
    _child = child;
    _latLng = latLng;
    _updateInfoWindow();
  }

  /// Notifies camera movements on [GoogleMap].
  void _onCameraMove() {
    if (!_showNow) return;
    _updateInfoWindow();
  }

  /// Disables [CustomInfoWindows] visibility.
  void _hideInfoWindow() {
    setState(() {
      _showNow = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: (_showNow == false ||
          (_leftMargin == 0 && _topMargin == 0) ||
          _child == null ||
          _latLng == null)
          ? false
          : true,
      child: Center(
        heightFactor: 1,
        child: Container(
          child: _child,
          // height: widget.height,
          width: widget.width,
        ),
      ),
    );
  }
}