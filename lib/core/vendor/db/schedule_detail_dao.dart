import 'package:sembast/sembast.dart';

import '../viewobject/schedule_detail.dart';
import 'common/ps_dao.dart';

class ScheduleDetailDao extends PsDao<ScheduleDetail> {
  ScheduleDetailDao._() {
    init(ScheduleDetail());
  }

  static const String STORENAME = 'ScheduleDetail';
  final String _primary = 'id';

  static final ScheduleDetailDao _singleton = ScheduleDetailDao._();
  static ScheduleDetailDao get instance => _singleton;

  @override
  Filter getFilter(ScheduleDetail object) {
    return Filter.equals(_primary, object.id);
  }

  @override
  String? getPrimaryKey(ScheduleDetail object) {
    return object.id;
  }

  @override
  String getStoreName() {
    return STORENAME;
  }
}
