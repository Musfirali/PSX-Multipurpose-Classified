import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../core/vendor/utils/utils.dart';
import '../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../core/vendor/viewobject/holder/product_parameter_holder.dart';
import '../../../custom_ui/map/component/filter/apply_button.dart';
import '../../../custom_ui/map/component/filter/reset_button.dart';
import '../../../custom_ui/map/component/filter/slider.dart';
import '../../common/base/ps_widget_with_appbar_with_no_provider.dart';

class GoogleMapFilterView extends StatefulWidget {
  const GoogleMapFilterView({required this.productParameterHolder});

  final ProductParameterHolder productParameterHolder;

  @override
  _GoogleMapFilterViewState createState() => _GoogleMapFilterViewState();
}

class _GoogleMapFilterViewState extends State<GoogleMapFilterView>
    with TickerProviderStateMixin {
  List<String> seekBarValues = <String>[
    '0.5',
    '1',
    '2.5',
    '5',
    '10',
    '25',
    '50',
    '100',
    '200',
    '500',
    'All'
  ];
  LatLng latlng = const LatLng(0.0, 0.0);
  final double zoom = 10;
  double radius = -1;
  double defaultRadius = 3000;
  bool isRemoveCircle = false;
  String address = '';
  bool isFirst = true;
  late CameraPosition kGooglePlex;
  GoogleMapController? mapController;
  late PsValueHolder valueHolder;

  Future<void> loadAddress() async {
    await placemarkFromCoordinates(latlng.latitude, latlng.longitude)
        .then((List<Placemark> placemarks) {
      final Placemark place = placemarks[0];
      setState(() {
        address =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      });
    }).catchError((dynamic e) {
      debugPrint(e);
    });
  }

  double _value = 0.3;
  String kmValue = '5';

  int findTheIndexOfTheValue(String? value) {
    int index = 0;

    for (int i = 0; i < seekBarValues.length - 1; i++) {
      if (!(value == 'All')) {
        if (getMiles(seekBarValues[i]) == value) {
          index = i;
          break;
        }
      } else {
        index = seekBarValues.length - 1;
      }
    }

    return index;
  }

  String getMiles(String kmValue) {
    final double _km = double.parse(kmValue);
    return (_km * 0.621371).toStringAsFixed(3);
  }

  @override
  Widget build(BuildContext context) {
    valueHolder = Provider.of<PsValueHolder>(context, listen: false);
    if (widget.productParameterHolder.lat! != '')
      latlng = LatLng(double.parse(widget.productParameterHolder.lat!),
          double.parse(widget.productParameterHolder.lng!));

    if (widget.productParameterHolder.mile != '' && isFirst) {
      final int _index =
          findTheIndexOfTheValue(widget.productParameterHolder.mile);
      kmValue = seekBarValues[_index];
      final double _val = double.parse(getMiles(kmValue)) * 1000;
      radius = _val;
      defaultRadius = radius;
      _value = _index / 10;
      isFirst = false;
    }

    final double scale = defaultRadius / 300; //radius/20
    final double value = 16 - log(scale) / log(2);
    loadAddress();

    kGooglePlex = CameraPosition(
      target: latlng,
      zoom: value,
    );

    print('value $value');

    return PsWidgetWithAppBarWithNoProvider(
        appBarTitle: 'map_filter__title'.tr,
        child: Scaffold(
          body: Column(
            children: <Widget>[
              Flexible(
                child: GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: kGooglePlex,
                    circles: <Circle>{}..add(Circle(
                        circleId: CircleId(address),
                        center: latlng,
                        radius: isRemoveCircle == true
                            ? 0.0
                            : radius <= 0.0
                                ? defaultRadius
                                : radius,
                        fillColor: PsColors.info500.withOpacity(0.7),
                        strokeWidth: 3,
                        strokeColor: Utils.isLightMode(context)
                            ? PsColors.primary500
                            : PsColors.primary50,
                      )),
                    onTap: _handleTap),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: PsDimens.space8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      'map_filter__browsing'.tr,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      _value == 1
                          ? seekBarValues[(_value * 10).toInt()]
                          : seekBarValues[(_value * 10).toInt()] +
                              'map_filter__km'.tr,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              CustomKMSlider(
                  value: _value,
                  onChanged: onSliderChanged,
                  label: _value == 1
                      ? seekBarValues[(_value * 10).toInt()]
                      : seekBarValues[(_value * 10).toInt()] +
                          'map_filter__km'.tr),
              Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  bottom: PsDimens.space8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'map_filter__lowest_km'.tr,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'map_filter__all'.tr,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(PsDimens.space16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    CustomResetButton(resetCallBack: reset),
                    const SizedBox(
                      width: 16,
                    ),
                    CustomApplyButton(
                        kmValue: kmValue,
                        productParameterHolder: widget.productParameterHolder,
                        lat: latlng.latitude.toString(),
                        lng: latlng.longitude.toString()),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  void onSliderChanged(double newValue) {
    setState(() {
      _value = newValue;
      kmValue = seekBarValues[(_value * 10).toInt()];
      if (kmValue == 'All') {
        isRemoveCircle = true;
      } else {
        radius = double.parse(Utils.getMilesFromKilometer(kmValue)) *
            1000; //_value * 10000;
      }
      _value == 1 ? isRemoveCircle = true : isRemoveCircle = false;
      defaultRadius != 0 ? defaultRadius = 500 : defaultRadius = 500;
    });
  }

  void reset() {
    setState(() {
      isRemoveCircle = true;
      _value = 1.0;
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _handleTap(LatLng latlng) {
    setState(() {
      this.latlng = latlng;
    });
  }
}
