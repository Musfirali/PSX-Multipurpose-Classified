import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as googlemap;
import 'package:latlong2/latlong.dart';
import 'package:psxmpc/core/vendor/provider/entry/item_entry_provider.dart';
import 'package:psxmpc/ui/vendor_ui/item/entry/component/entry_data/widgets/map_container_widget.dart';

class CustomMapContainerWiget extends StatelessWidget {
  const CustomMapContainerWiget(
      {Key? key,
      required this.latitudeController,
      required this.longitudeController,
      required this.flutterMapController,
      required this.zoom,
      required this.updateMap,
      required this.latLng,
      required this.updateMapController,
      required this.googleMapController,
      required this.userInputAddress,
      required this.currentPosition,
      required this.addressCurrentLocation,
      required this.itemEntryProvider,
      required this.isUseGoogleMap})
      : super(key: key);

  final TextEditingController latitudeController;
  final TextEditingController longitudeController;
  final MapController flutterMapController;
  final double zoom;
  final Function updateMap;
  final LatLng latLng;
  final Function? updateMapController;
  final googlemap.GoogleMapController? googleMapController;
  final TextEditingController userInputAddress;
  final Position? currentPosition;
  final String? addressCurrentLocation;
  final ItemEntryProvider? itemEntryProvider;
  final bool isUseGoogleMap;
  
  @override
  Widget build(BuildContext context) {
    return MapContainerWiget(
        latitudeController: latitudeController,
        longitudeController: longitudeController,
        flutterMapController: flutterMapController,
        zoom: zoom,
        updateMap: updateMap,
        latLng: latLng,
        updateMapController: updateMapController,
        googleMapController: googleMapController,
        userInputAddress: userInputAddress,
        currentPosition: currentPosition,
        addressCurrentLocation: addressCurrentLocation,
        itemEntryProvider: itemEntryProvider,
        isUseGoogleMap: isUseGoogleMap,);
  }
}
