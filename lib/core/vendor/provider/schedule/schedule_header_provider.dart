import '../../api/common/ps_resource.dart';
import '../../constant/ps_constants.dart';
import '../../repository/schedule_header_repository.dart';
import '../../viewobject/api_status.dart';
import '../../viewobject/holder/schedule_header_holder.dart';
import '../../viewobject/holder/schedule_status_update_holder.dart';
import '../../viewobject/schedule_header.dart';
import '../common/ps_provider.dart';

class ScheduleHeaderProvider extends PsProvider<ScheduleHeader> {
  ScheduleHeaderProvider(
      {required ScheduleHeaderRepository repo, int limit = 0})
      : super(repo, limit, subscriptionType: PsConst.LIST_OBJECT_SUBSCRIPTION) {
    _repo = repo;
  }

  late ScheduleHeaderRepository _repo;

  PsResource<List<ScheduleHeader>> get productCollectionHeader => dataList;

  Future<PsResource<List<ScheduleHeader>>> updateScheduleOrder(
      {required ScheduleStatusUpdateHolder holder}) async {
    return await _repo.updateScheduleOrderStatus(
        holder.toMap(), isConnectedToInternet);
  }

  Future<PsResource<ApiStatus>> deleteScheduleOrder(
      {required ScheduleHeaderMap holder}) async {
    return await _repo.deleteScheduleOrder(holder.toMap());
  }
}
