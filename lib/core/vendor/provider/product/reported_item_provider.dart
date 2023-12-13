import '../../api/common/ps_resource.dart';
import '../../constant/ps_constants.dart';
import '../../repository/reported_item_repository.dart';
import '../../viewobject/common/ps_value_holder.dart';
import '../../viewobject/reported_item.dart';
import '../common/ps_provider.dart';

class ReportedItemProvider extends PsProvider<ReportedItem> {
  ReportedItemProvider({
    required ReportedItemRepository? repo,
    this.valueHolder,
    int limit = 0,
  }) : super(repo, limit, subscriptionType: PsConst.LIST_OBJECT_SUBSCRIPTION);

  PsValueHolder? valueHolder;

  PsResource<List<ReportedItem>> get reportedItem => super.dataList;

  String categoryId = '';
}
