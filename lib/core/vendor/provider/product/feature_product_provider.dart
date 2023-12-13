import '../../api/common/ps_resource.dart';
import '../../constant/ps_constants.dart';
import '../../repository/product_repository.dart';
import '../../viewobject/product.dart';
import '../common/ps_provider.dart';

class FeaturedProductProvider extends PsProvider<Product> {
  FeaturedProductProvider({
    required ProductRepository repo,
    int limit = 0,
  }) : super(repo, limit, subscriptionType: PsConst.LIST_OBJECT_SUBSCRIPTION) {
    super.dataList.data = Product().checkDuplicate(dataList.data!);
    notifyListeners();
  }

  PsResource<List<Product>> get productList => super.dataList;
}
