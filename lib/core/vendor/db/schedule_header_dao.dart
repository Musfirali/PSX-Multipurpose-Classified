import 'package:sembast/sembast.dart';

import '../viewobject/schedule_header.dart';
import 'common/ps_dao.dart';

class ScheduleHeaderDao extends PsDao<ScheduleHeader> {
  ScheduleHeaderDao._() {
    init(ScheduleHeader());
  }
  // Singleton Instance
  static final ScheduleHeaderDao _singleton = ScheduleHeaderDao._();
  // Singleton Accessor
  static ScheduleHeaderDao get instance => _singleton;

  static const String STORE_NAME = 'ScheduleHeader';
  final String _primaryKey = 'id';

  @override
  Filter getFilter(ScheduleHeader object) {
    return Filter.equals(_primaryKey, object.id);
  }

  @override
  String? getPrimaryKey(ScheduleHeader object) {
    return object.id;
  }

  @override
  String getStoreName() {
    return STORE_NAME;
  }
}
