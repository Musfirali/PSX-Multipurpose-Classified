import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
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

class MapFilterView extends StatefulWidget {
  const MapFilterView({required this.productParameterHolder});

  final ProductParameterHolder productParameterHolder;

  @override
  _MapFilterViewState createState() => _MapFilterViewState();
}

class _MapFilterViewState extends State<MapFilterView>
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
  LatLng latlng = LatLng(0.0, 0.0);
  final double zoom = 10;
  double radius = -1;
  double defaultRadius = 3000;
  bool isRemoveCircle = false;
  String address = '';
  bool isFirst = true;
  late PsValueHolder valueHolder;

  double _value = 0.3;
  String kmValue = '5';

  int findTheIndexOfTheValue(String? value) {
    int index = 0;

    for (int i = 0; i < seekBarValues.length - 1; i++) {
      if (!(value == 'All')) {
        if (Utils.getMilesFromKilometer(seekBarValues[i]) == value) {
          index = i;
          break;
        }
      } else {
        index = seekBarValues.length - 1;
      }
    }

    return index;
  }

  @override
  void initState() {
    super.initState();
    if (widget.productParameterHolder.lat! != '')
      latlng = LatLng(double.parse(widget.productParameterHolder.lat!),
          double.parse(widget.productParameterHolder.lng!));
  }

  @override
  Widget build(BuildContext context) {
    valueHolder = Provider.of<PsValueHolder>(context, listen: false);

    //  latlng = LatLng(51.5, -0.09);

    if (widget.productParameterHolder.mile != '' && isFirst) {
      final int _index =
          findTheIndexOfTheValue(widget.productParameterHolder.mile);
      kmValue = seekBarValues[_index];
      final double _val =
          double.parse(Utils.getMilesFromKilometer(kmValue)) * 1000;
      radius = _val;
      defaultRadius = radius;
      _value = _index / 10;
      isFirst = false;
    }

    final double scale = defaultRadius / 300; //radius/20
    final double value = 16 - log(scale) / log(2);
    // loadAddress();

    print('value $value');

    final List<CircleMarker> circleMarkers = <CircleMarker>[
      CircleMarker(
          point: latlng, //LatLng(51.5, -0.09),
          color: PsColors.info500.withOpacity(0.7),
          borderColor: Utils.isLightMode(context)
              ? PsColors.primary500
              : PsColors.primary50,
          borderStrokeWidth: 2,
          useRadiusInMeter: true,
          radius: isRemoveCircle == true
              ? 0.0
              : radius <= 0.0
                  ? defaultRadius
                  : radius //2000 // 2000 meters | 2 km//radius

          ),
    ];

    return PsWidgetWithAppBarWithNoProvider(
        appBarTitle: 'map_filter__title'.tr,
        child: Scaffold(
          body: Column(
            children: <Widget>[
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(PsDimens.space16),
                    child: FlutterMap(
                      options: MapOptions(
                          center:
                              latlng, //LatLng(51.5, -0.09), //LatLng(45.5231, -122.6765),
                          zoom: zoom, //10.0,
                          onTap: _handleTap),
                      children: <Widget>[
                        TileLayer(
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        ),
                        CircleLayer(circles: circleMarkers),
                        MarkerLayer(markers: <Marker>[
                          Marker(
                            width: 80.0,
                            height: 80.0,
                            point: latlng,
                            builder: (BuildContext ctx) => Container(
                              child: IconButton(
                                icon: const Icon(
                                  Icons.location_on,),
                                iconSize: 45,
                                onPressed: () {},
                              ),
                            ),
                          )
                        ])
                      ],
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 22,
                  right: 22,
                  top: PsDimens.space8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              const SizedBox(
                height: 12,
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
                  left: 22,
                  right: 22,
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
                          .bodySmall!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'map_filter__all'.tr,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(PsDimens.space16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CustomResetButton(resetCallBack: reset),
                    const SizedBox(
                      width: 16,
                    ),
                    CustomApplyButton(
                      kmValue: kmValue,
                      productParameterHolder: widget.productParameterHolder,
                      lat: latlng.latitude.toString(),
                      lng: latlng.longitude.toString(),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
            ],
          ),
        ));
  }

  void _handleTap(dynamic tapPosition, LatLng latlng) {
    setState(() {
      this.latlng = latlng;
    });
  }

  void reset() {
    setState(() {
      isRemoveCircle = true;
      _value = 1.0;
    });
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
}
