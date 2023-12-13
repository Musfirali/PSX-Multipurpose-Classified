



import 'package:psxmpc/core/vendor/provider/entry/item_entry_provider.dart';

class MapPinIntentHolder {
  const MapPinIntentHolder({
    required this.flag,
    required this.mapLat,
    required this.mapLng,
    this.itemEntryProvider
  });
  final String flag;
  final String? mapLat;
  final String? mapLng;
 final ItemEntryProvider? itemEntryProvider;
}
