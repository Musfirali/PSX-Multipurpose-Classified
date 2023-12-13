import '../../api/common/ps_resource.dart';
import '../../constant/ps_constants.dart';
import '../../repository/schedule_detail_repository.dart';
import '../../viewobject/schedule_detail.dart';
import '../common/ps_provider.dart';

class ScheduleDetailProvider extends PsProvider<ScheduleDetail> {
  ScheduleDetailProvider(
      {required ScheduleDetailRepository repo, int limit = 0})
      : super(repo, limit, subscriptionType: PsConst.LIST_OBJECT_SUBSCRIPTION);

  PsResource<List<ScheduleDetail>> get scheduleDetail => dataList;
}
