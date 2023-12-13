import '../../api/common/ps_resource.dart';
import '../../constant/ps_constants.dart';
import '../../repository/item_location_repository.dart';
import '../../viewobject/common/ps_value_holder.dart';
import '../../viewobject/holder/location_parameter_holder.dart';
import '../../viewobject/item_location.dart';
import '../common/ps_provider.dart';

class ItemLocationProvider extends PsProvider<ItemLocation> {
  ItemLocationProvider({
    required ItemLocationRepository? repo,
    required this.psValueHolder,
    int limit = 0,
  }) : super(repo, limit, subscriptionType: PsConst.LIST_OBJECT_SUBSCRIPTION);

  String? itemLocationId = '';
  String? itemLocationName = '';
  String? itemLocationLat = '';
  String? itemLocationLng = '';
  String? itemLocationTownshipId = '';
  String? itemLocationTownshipName = '';
  String? itemLocationTownshipLat = '';
  String? itemLocationTownshipLng = '';

  String selectedCityId = '';
  String selectedCityName = '';
  String selectedTownshipId = '';
  String selectedTownshipName = '';

  PsValueHolder? psValueHolder;
  LocationParameterHolder latestLocationParameterHolder =
      LocationParameterHolder().getDefaultParameterHolder();

  PsResource<List<ItemLocation>> get itemLocationList => super.dataList;

  String getCityIdWithName(String name) {
    if (itemLocationList.data == null) {
      return '';
    }

    String cityId = '';
    for (ItemLocation item in itemLocationList.data ?? <ItemLocation>[]) {
      if (name == item.name) {
        cityId = item.id;
      }
    }

    return cityId;
  }
}
