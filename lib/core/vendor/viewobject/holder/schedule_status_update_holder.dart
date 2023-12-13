import '../common/ps_holder.dart';

class ScheduleStatusUpdateHolder extends PsHolder<ScheduleStatusUpdateHolder> {
  ScheduleStatusUpdateHolder({
    this.scheduleHeaderId,
    this.scheduleStatus,
  });

  String? scheduleStatus;
  String? scheduleHeaderId;
  @override
  ScheduleStatusUpdateHolder fromMap(dynamic dynamicData) {
    return ScheduleStatusUpdateHolder(
        scheduleHeaderId: dynamicData['id'],
        scheduleStatus: dynamicData['schedule_status']);
  }

  @override
  String getParamKey() {
    return scheduleHeaderId.toString();
  }

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = scheduleHeaderId;
    map['schedule_status'] = scheduleStatus;
    return map;
  }
}
