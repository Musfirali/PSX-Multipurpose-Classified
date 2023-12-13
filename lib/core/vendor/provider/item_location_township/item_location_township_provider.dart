import '../../api/common/ps_resource.dart';
import '../../constant/ps_constants.dart';
import '../../repository/item_location_township_repository.dart';
import '../../viewobject/common/ps_value_holder.dart';
import '../../viewobject/holder/location_township_parameter_holder.dart';
import '../../viewobject/item_location_township.dart';
import '../common/ps_provider.dart';

class ItemLocationTownshipProvider extends PsProvider<ItemLocationTownship> {
  ItemLocationTownshipProvider({
    required ItemLocationTownshipRepository? repo,
    required this.psValueHolder,
    int limit = 0,
  }) : super(repo, limit, subscriptionType: PsConst.LIST_OBJECT_SUBSCRIPTION) {
    if (ItemLocationTownship()
        .isListEqual(super.dataList.data!, dataList.data!)) {
      dataList.status = dataList.status;
      dataList.message = dataList.message;
    } else {
      dataList = dataList;
    }
  }

  // String selectedTownshipId = '';
  // String selectedTownshipName = '';
  String itemLocationTownshipId = '';
  String itemLocationTownshipName = '';
  String itemLocationTownshipLat = '';
  String itemLocationTownshipLng = '';
  PsValueHolder? psValueHolder;
  LocationTownshipParameterHolder latestLocationParameterHolder =
      LocationTownshipParameterHolder().getDefaultParameterHolder();

  PsResource<List<ItemLocationTownship>> get itemLocationTownshipList =>
      super.dataList;

  List<String> getLocationTownshipList() {
    final List<String> dataList = <String>[];

    if (itemLocationTownshipList.data != null) {
      for (ItemLocationTownship item
          in itemLocationTownshipList.data ?? <ItemLocationTownship>[]) {
        final String name = item.townshipName ?? '';
        if (name != '') {
          dataList.add(name);
        }
      }
    }

    return dataList;
  }

  //   String getTownshipIdWithName(String name) {
  //   if (itemLocationTownshipList.data == null) {
  //     return '';
  //   }

  //   String cityId = '';
  //   for (ItemLocationTownship item in itemLocationTownshipList.data ?? <ItemLocationTownship>[]) {
  //     if (name == item.townshipName) {
  //       cityId = item.id!;
  //     }
  //   }

  //   return cityId;
  // }
}
