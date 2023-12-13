import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../../../core/vendor/constant/ps_dimens.dart';

class UseCurrentLocationWidget extends StatefulWidget {
  const UseCurrentLocationWidget({
    Key? key,

    /// If set, enable the FusedLocationProvider on Android
    required this.androidFusedLocation,
    required this.updateMap,
  }) : super(key: key);

  final bool androidFusedLocation;
  final Function updateMap;

  @override
  UseCurrentLocationWidgetState<UseCurrentLocationWidget> createState() =>
      UseCurrentLocationWidgetState<UseCurrentLocationWidget>();
}

class UseCurrentLocationWidgetState<T extends UseCurrentLocationWidget>
    extends State<UseCurrentLocationWidget> {
  String address = '';
  Position? _currentPosition;
  final MapController mapController = MapController();

  @override
  void initState() {
    super.initState();

    //  _initCurrentLocation();
  }

  Future<void> loadAddress() async {
    if (_currentPosition != null) {
      // if (widget.textEditingController!.text == '') {
      await placemarkFromCoordinates(
        _currentPosition!.latitude,
        _currentPosition!.longitude,
      ).then((List<Placemark> placemarks) {
        final Placemark place = placemarks[0];
        setState(() {
          address =
              '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
          widget.updateMap(
              _currentPosition!.latitude, _currentPosition!.longitude, address);

        });
      }).catchError((dynamic e) {
        print(e);
      });
      // } else {
      //   address = widget.textEditingController!.text;
      // }
    }
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  dynamic _initCurrentLocation() {
    Geolocator.checkPermission().then((LocationPermission permission) {
      if (permission == LocationPermission.denied) {
        Geolocator.requestPermission().then((LocationPermission permission) {
          if (permission == LocationPermission.denied) {
          } else {
            Geolocator
                    //..forceAndroidLocationManager = !widget.androidFusedLocation
                    .getCurrentPosition(
                        desiredAccuracy: LocationAccuracy.medium,
                        forceAndroidLocationManager: false)
                .then((Position position) {
              print(position);
              //     if (mounted) {
              //  setState(() {
              _currentPosition = position;
              loadAddress();
              //    });
              // _currentPosition = position;

              //    }
            }).catchError((Object e) {
              print(e);
            });
          }
        });
      } else {
        Geolocator
                //..forceAndroidLocationManager = !widget.androidFusedLocation
                .getCurrentPosition(
                    desiredAccuracy: LocationAccuracy.medium,
                    forceAndroidLocationManager: !widget.androidFusedLocation)
            .then((Position position) {
          //    if (mounted) {
          setState(() {
            _currentPosition = position;
            loadAddress();
          });
          //    }
        }).catchError((Object e) {
          print(e);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _initCurrentLocation();
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
            horizontal: PsDimens.space12, vertical: PsDimens.space12),
        child: Row(
          children: <Widget>[
            const Icon(
              Icons.location_on_outlined,
              size: 20,
            ),
            const SizedBox(
              width: PsDimens.space12,
            ),
            Text(
              'item_entry__use_current_location'.tr,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).primaryColor, fontWeight: FontWeight.normal),
            )
          ],
        ),
      ),
    );
  }
}
