import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/core/vendor/constant/ps_dimens.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';
import 'package:psxmpc/core/vendor/viewobject/common/ps_value_holder.dart';

import '../../../../core/vendor/constant/ps_constants.dart';
import '../../../../core/vendor/viewobject/holder/intent_holder/map_pin_call_back_holder.dart';
import '../../common/base/ps_widget_with_appbar_with_no_provider.dart';
import '../../common/ps_button_widget_with_round_corner.dart';

class MapPinView extends StatefulWidget {
  const MapPinView({
    required this.flag,
    required this.maplat,
    required this.maplng,
    //this.itemEntryProvider
  });

  final String flag;
  final String? maplat;
  final String? maplng;
  // final ItemEntryProvider? itemEntryProvider;

  @override
  _MapPinViewState createState() => _MapPinViewState();
}

class _MapPinViewState extends State<MapPinView> with TickerProviderStateMixin {
  LatLng? latlng;
  double defaultRadius = 3000;
  final MapController mapController = MapController();
  final double zoomLevel = 17;
  Position? _currentPosition;
  double zoom = 16.0;
  String address = '';
  String addressCurrentLocation = '';

  Future<void> loadAddress() async {
    await placemarkFromCoordinates(latlng!.latitude, latlng!.longitude)
        .then((List<Placemark> placemarks) {
      final Placemark place = placemarks[0];
      setState(() {
        address =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      });
    }).catchError((dynamic e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    latlng ??=
        LatLng(double.parse(widget.maplat!), double.parse(widget.maplng!));

    const double value = 16.0;
    loadAddress();
    //loadAddressCurrentLocation();
    // final ItemEntryProvider itemEntryProvider = Provider.of<ItemEntryProvider>(context,listen: false);
    final PsValueHolder valueHolder =
        Provider.of<PsValueHolder>(context, listen: false);

    final Widget mapPickLocationWidget = Positioned(
      bottom: 2,
      child: Container(
        alignment: Alignment.bottomCenter,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: PSButtonWidgetRoundCorner(
          colorData: Theme.of(context).primaryColor,
          hasShadow: false,
          titleText: 'PICK LOCATION'.tr,
          onPressed: () {
            valueHolder.isPickUpOnMap = true;
            // widget.itemEntryProvider!.isPickUpOnMap = true;
            Navigator.pop(
                context,
                MapPinCallBackHolder(
                  address: address,
                  latLng: latlng,
                ));
          },
        ),
      ),
    );

    print('value $value');

    return PsWidgetWithAppBarWithNoProvider(
        appBarTitle: 'location_tile__title'.tr,
        actions: widget.flag == PsConst.PIN_MAP
            ? <Widget>[
                InkWell(
                  child: Ink(
                    child: Center(
                      child: Text(
                        'item_entry__use_current_location'.tr,
                        textAlign: TextAlign.justify,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontWeight: FontWeight.bold)
                            .copyWith(color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                  onTap: () {
                    Geolocator.getCurrentPosition(
                            desiredAccuracy: LocationAccuracy.medium,
                            forceAndroidLocationManager: true)
                        .then((Position position) async {
                      _currentPosition = position;
                      final List<Placemark> placemarks =
                          await placemarkFromCoordinates(
                              _currentPosition!.latitude,
                              _currentPosition!.longitude);
                      final Placemark place = placemarks[0];

                      addressCurrentLocation =
                          '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}'; //here you can used place.country and other things also
                      print(addressCurrentLocation);

                      Navigator.pop(
                          context,
                          MapPinCallBackHolder(
                            address: addressCurrentLocation,
                            latLng: LatLng(_currentPosition!.latitude,
                                _currentPosition!.longitude),
                          ));
                    }).catchError((Object e) {
                      print(e);
                    });
                  },
                ),
                const SizedBox(
                  width: PsDimens.space16,
                ),
              ]
            : <Widget>[],
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              // Flexible(
              //   child:
              FlutterMap(
                options: MapOptions(
                    center:
                        latlng, //LatLng(51.5, -0.09), //LatLng(45.5231, -122.6765),
                    zoom: value, //10.0,
                    onTap: widget.flag == PsConst.PIN_MAP
                        ? _handleTap
                        : _doNothingTap),
                children: <Widget>[
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  ),
                  CircleLayer(
                    circles: <CircleMarker>[
                      CircleMarker(
                          point: latlng!,
                          color: PsColors.info500.withOpacity(0.7),
                          borderStrokeWidth: 2,
                          useRadiusInMeter: true,
                          radius: 200),
                    ],
                  ),
                ],
              ),
              if (widget.flag == PsConst.PIN_MAP) mapPickLocationWidget
            ],
          ),
        ));
  }

  void _handleTap(dynamic tapPosition, LatLng latlng) {
    setState(() {
      this.latlng = latlng;
    });
  }

  void _doNothingTap(dynamic tapPosition, LatLng latlng) {}
}
