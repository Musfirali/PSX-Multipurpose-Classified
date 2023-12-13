import '../common/ps_holder.dart';

class ScheduleHeaderMap extends PsHolder<ScheduleHeaderMap> {
  ScheduleHeaderMap({this.scheduleHeadId});

  final String? scheduleHeadId;

  @override
  ScheduleHeaderMap fromMap(dynamic dynamicData) {
    return ScheduleHeaderMap(scheduleHeadId: dynamicData['id']);
  }

  @override
  String getParamKey() {
    return scheduleHeadId.toString();
  }

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{};

    map['id'] = scheduleHeadId;

    return map;
  }
}
