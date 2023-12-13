import '../../api/common/ps_resource.dart';
import '../../constant/ps_constants.dart';
import '../../repository/product_collection_repository.dart';
import '../../viewobject/product_collection_header.dart';
import '../common/ps_provider.dart';

class ProductCollectionProvider extends PsProvider<ProductCollectionHeader> {
  ProductCollectionProvider(
      {required ProductCollectionRepository repo, int limit = 0})
      : super(repo, limit, subscriptionType: PsConst.LIST_OBJECT_SUBSCRIPTION);

  PsResource<List<ProductCollectionHeader>> get productCollectionHeader => dataList;
}
