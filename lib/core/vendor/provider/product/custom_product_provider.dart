import '../../api/common/ps_resource.dart';
import '../../constant/ps_constants.dart';
import '../../repository/custom_product_repository.dart';
import '../../viewobject/custom_product.dart';
import '../common/ps_provider.dart';

class CProductProvider extends PsProvider<CProduct> {
  CProductProvider({required CProductRepository repo, int limit = 0})
      : super(repo, limit, subscriptionType: PsConst.LIST_OBJECT_SUBSCRIPTION);

  PsResource<List<CProduct>> get products => dataList;
}