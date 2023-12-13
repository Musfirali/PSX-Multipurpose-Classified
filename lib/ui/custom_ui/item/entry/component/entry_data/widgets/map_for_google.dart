import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as googlemap;
import 'package:latlong2/latlong.dart';
import 'package:psxmpc/ui/vendor_ui/item/entry/component/entry_data/widgets/map_for_google.dart';

class CustomMapForGoogle extends StatelessWidget {
  const CustomMapForGoogle(
      {required this.updateMapController,
      required this.googleMapController,
      required this.latLng,
      required this.userInputAddress,
      required this.updateGoogleMap,
      required this.zoom,
      required this.currentPosition,
      required this.addressCurrentLocation,
      //required this.itemEntryProvider
      });
  final Function? updateMapController;
  final googlemap.GoogleMapController? googleMapController;
  final LatLng latLng;
  final TextEditingController userInputAddress;
  final Function updateGoogleMap;
  final double zoom;
  final Position? currentPosition;
  final String? addressCurrentLocation;
  //final ItemEntryProvider? itemEntryProvider;
  @override
  Widget build(BuildContext context) {
    return MapForGoogle(
        updateMapController: updateMapController,
        googleMapController: googleMapController,
        latLng: latLng,
        userInputAddress: userInputAddress,
        updateGoogleMap: updateGoogleMap,
        zoom: zoom,
        addressCurrentLocation: addressCurrentLocation,
       // itemEntryProvider: itemEntryProvider,
        currentPosition: currentPosition,);
  }
}
