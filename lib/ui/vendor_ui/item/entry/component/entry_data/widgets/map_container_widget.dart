import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as googlemap;
import 'package:latlong2/latlong.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/core/vendor/constant/ps_dimens.dart';
import 'package:psxmpc/core/vendor/provider/entry/item_entry_provider.dart';
import 'package:psxmpc/ui/custom_ui/item/entry/component/entry_data/widgets/map_for_flutter.dart';
import 'package:psxmpc/ui/custom_ui/item/entry/component/entry_data/widgets/map_for_google.dart';

import '../../../../../../../core/vendor/utils/utils.dart';

class MapContainerWiget extends StatefulWidget {
  const MapContainerWiget(
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
  State<StatefulWidget> createState() => _MapContainerWigetState();
}

class _MapContainerWigetState extends State<MapContainerWiget> {
  @override
  void initState() {
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.lowest,
            forceAndroidLocationManager: true)
        .then((Position position) async {
      final List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      final Placemark place = placemarks[0];      
      widget.updateMap(position.latitude, position.longitude, '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}');
      // if (widget.isUseGoogleMap) {
      //   await widget.googleMapController!.animateCamera(
      //       googlemap.CameraUpdate.newCameraPosition(googlemap.CameraPosition(
      //           target: googlemap.LatLng(position.latitude, position.longitude),
      //           zoom: widget.zoom)));
      // } else {
      //   widget.flutterMapController
      //       .move(LatLng(position.latitude, position.longitude), widget.zoom);
      // }
    }).catchError((Object e) {
      print(e);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /**
     * UI SECTION
     */
    return Container(
      height: 260,
      margin: const EdgeInsets.all(PsDimens.space16),
      decoration: BoxDecoration(
        color: PsColors.achromatic800,
        borderRadius: BorderRadius.circular(PsDimens.space4),
        border: Border.all(color: Utils.isLightMode(context) ? PsColors.achromatic800 : PsColors.achromatic50),
      ),
      child: widget.isUseGoogleMap
          ? CustomMapForGoogle(
              updateMapController: widget.updateMapController,
              googleMapController: widget.googleMapController,
              latLng: widget.latLng,
              userInputAddress: widget.userInputAddress,
              updateGoogleMap: widget.updateMap,
              zoom: widget.zoom,
              addressCurrentLocation: widget.addressCurrentLocation,
              currentPosition: widget.currentPosition,
            )
          : CustomMapForFlutter(
              flutterMapController: widget.flutterMapController,
              latLng: widget.latLng,
              updateFlutterMap: widget.updateMap,
              zoom: widget.zoom,
              addressCurrentLocation: widget.addressCurrentLocation,
              currentPosition: widget.currentPosition,
            ),
    );
  }
}
