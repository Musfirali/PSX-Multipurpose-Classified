import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

import '../../../../../../../config/route/route_paths.dart';
import '../../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../../core/vendor/viewobject/holder/intent_holder/google_map_pin_call_back_holder.dart';
import '../../../../../../../core/vendor/viewobject/holder/intent_holder/map_pin_call_back_holder.dart';
import '../../../../../../../core/vendor/viewobject/holder/intent_holder/map_pin_intent_holder.dart';

class PickOnMapWidget extends StatelessWidget {
  const PickOnMapWidget({required this.latLng, required this.updateMap});
  final LatLng latLng;
  final Function updateMap;
  @override
  Widget build(BuildContext context) {
    final PsValueHolder psValueHolder = Provider.of<PsValueHolder>(context);
    return InkWell(
      onTap: () {
        _handleTap(context, latLng, psValueHolder.isUseGoogleMap!);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
            horizontal: PsDimens.space12, vertical: PsDimens.space12),
        child: Row(
          children: <Widget>[
            const Icon(
              Icons.add,
              size: 20,
            ),
            const SizedBox(
              width: PsDimens.space12,
            ),
            Text(
              'item_entry__pick_on_map'.tr,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).primaryColor, fontWeight: FontWeight.normal),
            )
          ],
        ),
      ),
    );
  }

  dynamic _handleTap(
      BuildContext context, LatLng? latLng, bool isUseGoogleMap) async {
    dynamic result;
    if (isUseGoogleMap) {
      result = await Navigator.pushNamed(context, RoutePaths.googleMapPin,
          arguments: MapPinIntentHolder(
              flag: PsConst.PIN_MAP,
              mapLat: latLng!.latitude.toString(),
              mapLng: latLng.longitude.toString()));
    } else {
      result = await Navigator.pushNamed(context, RoutePaths.mapPin,
          arguments: MapPinIntentHolder(
              flag: PsConst.PIN_MAP,
              mapLat: latLng!.latitude.toString(),
              mapLng: latLng.longitude.toString()));
    }

    if (result != null &&
        (result is MapPinCallBackHolder ||
            result is GoogleMapPinCallBackHolder)) {
      updateMap(
          result.latLng!.latitude, result.latLng!.longitude, result.address);
    }
  }
}
