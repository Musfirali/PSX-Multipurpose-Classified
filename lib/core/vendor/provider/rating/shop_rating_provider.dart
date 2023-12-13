import '../../api/common/ps_resource.dart';
import '../../constant/ps_constants.dart';
import '../../repository/shop_rating_repository.dart';
import '../../viewobject/shop_rating.dart';
import '../common/ps_provider.dart';

class ShopRatingProvider extends PsProvider<ShopRating> {
  ShopRatingProvider({required ShopRatingRepository repo, int limit = 0})
      : super(repo, limit, subscriptionType: PsConst.LIST_OBJECT_SUBSCRIPTION);

  PsResource<List<ShopRating>> get shopRating => dataList;
}
