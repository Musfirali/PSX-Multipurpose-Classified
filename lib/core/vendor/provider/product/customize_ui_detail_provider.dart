import '../../api/common/ps_resource.dart';
import '../../constant/ps_constants.dart';
import '../../repository/customize_ui_detail_repository.dart';
import '../../viewobject/customize_ui_detail.dart';
import '../common/ps_provider.dart';

class CustomizeUiDetailProvider extends PsProvider<CustomizeUiDetail> {
  CustomizeUiDetailProvider(
      {required CustomizeUiDetailRepository repo, int limit = 0})
      : super(repo, limit, subscriptionType: PsConst.LIST_OBJECT_SUBSCRIPTION);

  PsResource<List<CustomizeUiDetail>> get customizeUiDetails => dataList;
}