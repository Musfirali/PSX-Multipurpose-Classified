import 'package:flutter/material.dart';

import '../../../vendor_ui/map/view/map_pin_view.dart';

class CustomMapPinView extends StatefulWidget {
  const CustomMapPinView(
      {required this.flag, required this.maplat, required this.maplng,
      //this.itemEntryProvider
      });

  final String flag;
  final String? maplat;
  final String? maplng;
 // final ItemEntryProvider? itemEntryProvider;


  @override
  _MapPinViewState createState() => _MapPinViewState();
}

class _MapPinViewState extends State<CustomMapPinView> {
  @override
  Widget build(BuildContext context) {
    return MapPinView(
        flag: widget.flag, maplat: widget.maplat, maplng: widget.maplng, 
        //itemEntryProvider: widget.itemEntryProvider,
        );
  }
}
