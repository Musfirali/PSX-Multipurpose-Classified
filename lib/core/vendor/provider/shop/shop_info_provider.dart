import '../../api/common/ps_resource.dart';
import '../../constant/ps_constants.dart';
import '../../repository/shop_info_repository.dart';
import '../../viewobject/shop_info.dart';
import '../common/ps_provider.dart';

class ShopInfoProvider extends PsProvider<ShopInfo> {
  ShopInfoProvider({required ShopInfoRepository? repo, int limit = 0})
      : super(repo, limit,
            subscriptionType: PsConst.SINGLE_OBJECT_SUBSCRIPTION);

  PsResource<ShopInfo> get shopInfo => data;
}
