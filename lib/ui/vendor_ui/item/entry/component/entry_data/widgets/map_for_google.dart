import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as googlemap;
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/route/route_paths.dart';
import 'package:psxmpc/core/vendor/constant/ps_constants.dart';
import 'package:psxmpc/core/vendor/viewobject/common/ps_value_holder.dart';
import 'package:psxmpc/core/vendor/viewobject/holder/intent_holder/google_map_pin_call_back_holder.dart';
import 'package:psxmpc/core/vendor/viewobject/holder/intent_holder/map_pin_intent_holder.dart';

import '../../../../../../../config/ps_colors.dart';
import '../../../../../../../core/vendor/provider/entry/item_entry_provider.dart';

class MapForGoogle extends StatefulWidget {
  const MapForGoogle({
    required this.updateMapController,
    required this.googleMapController,
    required this.latLng,
    required this.userInputAddress,
    required this.updateGoogleMap,
    required this.zoom,
    required this.currentPosition,
    required this.addressCurrentLocation,
    // required this.itemEntryProvider
  });
  final Function? updateMapController;
  final googlemap.GoogleMapController? googleMapController;
  final LatLng latLng;
  final TextEditingController userInputAddress;
  final Function updateGoogleMap;
  final double zoom;
  final Position? currentPosition;
  final String? addressCurrentLocation;
  // final ItemEntryProvider? itemEntryProvider;

  @override
  State<MapForGoogle> createState() => _MapForGoogleState();
}

class _MapForGoogleState extends State<MapForGoogle> {
  LatLng? _defaultLatLng;
  googlemap.GoogleMapController? _map;
  late ItemEntryProvider provider;

  @override
  Widget build(BuildContext context) {
    final PsValueHolder valueHolder =
        Provider.of<PsValueHolder>(context, listen: false);
    _defaultLatLng = LatLng(double.parse(valueHolder.locationLat!),
        double.parse(valueHolder.locationLng!));
    provider = Provider.of<ItemEntryProvider>(context);    

    final googlemap.CameraPosition kGooglePlex = googlemap.CameraPosition(
      target: googlemap.LatLng(widget.latLng.latitude, widget.latLng.longitude),
      zoom: widget.zoom,
    );
    return googlemap.GoogleMap(
        onMapCreated: (googlemap.GoogleMapController updateGoogleMap) {
          widget.updateMapController!(updateGoogleMap);
          _map = updateGoogleMap;
        } ,
        initialCameraPosition: kGooglePlex,
        circles: <googlemap.Circle>{}..add(googlemap.Circle(
            circleId: googlemap.CircleId(widget.userInputAddress.toString()),
            center: _defaultLatLng == LatLng(0.000000, 0.000000)
                ? googlemap.LatLng(
                    double.parse(valueHolder.defaultlocationLat!),
                    double.parse(valueHolder.defaultlocationLng!))
                : googlemap.LatLng(
                    widget.latLng.latitude, widget.latLng.longitude),
            radius: 50,
            fillColor: PsColors.info500.withOpacity(0.7),
            strokeWidth: 3,
            strokeColor: PsColors.accent500,
          )),
        onTap: (googlemap.LatLng latLngr) async {
          FocusScope.of(context).requestFocus(FocusNode());
          final dynamic result =
              await Navigator.pushNamed(context, RoutePaths.googleMapPin,
                  arguments: MapPinIntentHolder(
                    flag: PsConst.PIN_MAP,
                    mapLat: provider.latlng.latitude.toString(),
                    mapLng: provider.latlng.longitude.toString(),
                  ));
          if (result != null && result is GoogleMapPinCallBackHolder) {
            // setState(() {
              _map!.animateCamera(
                  googlemap.CameraUpdate.newCameraPosition(
                      googlemap.CameraPosition(
                target: googlemap.LatLng(
                    result.latLng!.latitude, result.latLng!.longitude),
                zoom: widget.zoom,
              )));
            // });

            widget.updateGoogleMap(result.latLng!.latitude,
                result.latLng!.longitude, result.address);
          }
        });
  }
}
