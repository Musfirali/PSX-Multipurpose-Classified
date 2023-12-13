import '../../api/common/ps_resource.dart';
import '../../constant/ps_constants.dart';
import '../../repository/category_repository.dart';
import '../../viewobject/category.dart';
import '../../viewobject/common/ps_value_holder.dart';
import '../common/ps_provider.dart';

class TrendingCategoryProvider extends PsProvider<Category> {
  TrendingCategoryProvider({
    required CategoryRepository repo,
    required this.psValueHolder,
    int limit = 0,
   
  }) : super(repo, limit,subscriptionType: PsConst.LIST_OBJECT_SUBSCRIPTION);


  PsValueHolder psValueHolder;
  PsResource<List<Category>> get categoryList => super.dataList;

}
