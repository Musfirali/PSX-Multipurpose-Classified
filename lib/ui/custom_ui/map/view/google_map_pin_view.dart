import 'package:flutter/material.dart';

import '../../../vendor_ui/map/view/google_map_pin_view.dart';

class CustomGoogleMapPinView extends StatefulWidget {
  const CustomGoogleMapPinView(
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

class _MapPinViewState extends State<CustomGoogleMapPinView> {
  @override
  Widget build(BuildContext context) {
    return GoogleMapPinView(
        flag: widget.flag, maplat: widget.maplat, maplng: widget.maplng,
        ///itemEntryProvider:widget.itemEntryProvider,
         );
  }
}
