import '../../api/common/ps_resource.dart';
import '../../constant/ps_constants.dart';
import '../../repository/product_by_collection_id_repository.dart';
import '../../viewobject/product.dart';
import '../common/ps_provider.dart';

class ProductByCollectionIdProvider extends PsProvider<Product>{
 ProductByCollectionIdProvider(
      {required ProductByCollectionIdRepository repo, int limit = 0})
      : super(repo, limit, subscriptionType: PsConst.LIST_OBJECT_SUBSCRIPTION);

  PsResource<List<Product>> get productCollectionList => dataList;

}