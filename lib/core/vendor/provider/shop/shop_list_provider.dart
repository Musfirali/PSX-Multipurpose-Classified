import '../../api/common/ps_resource.dart';
import '../../constant/ps_constants.dart';
import '../../repository/shop_repository.dart';
import '../../viewobject/shop.dart';
import '../common/ps_provider.dart';

class ShopProvider extends PsProvider<Shop> {
  ShopProvider({required ShopRepository? repo, int limit = 0})
      : super(repo, limit, subscriptionType: PsConst.LIST_OBJECT_SUBSCRIPTION);

  PsResource<List<Shop>> get shopList => dataList;
}
