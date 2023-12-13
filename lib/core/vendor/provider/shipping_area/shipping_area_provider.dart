import '../../api/common/ps_resource.dart';
import '../../constant/ps_constants.dart';
import '../../repository/shipping_area_repository.dart';
import '../../viewobject/shipping_area.dart';
import '../common/ps_provider.dart';

class ShippingAreaProvider extends PsProvider<ShippingArea> {
  ShippingAreaProvider({required ShippingAreaRepository repo, int limit = 0})
      : super(repo, limit, subscriptionType: PsConst.LIST_OBJECT_SUBSCRIPTION);

  PsResource<List<ShippingArea>> get shippingArea => dataList;
}
