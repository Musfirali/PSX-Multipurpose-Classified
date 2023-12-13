import 'package:sembast/sembast.dart';

import '../viewobject/get_in_touch.dart';
import 'common/ps_dao.dart';

class GetInTouchDao extends PsDao<GetInTouch> {
  GetInTouchDao._() {
    init(GetInTouch());
  }
  static const String STORE_NAME = 'GetInTouch';
  final String _primaryKey = 'id';

  // Singleton instance
  static final GetInTouchDao _singleton = GetInTouchDao._();

  // Singleton accessor
  static GetInTouchDao get instance => _singleton;

  @override
  String getStoreName() {
    return STORE_NAME;
  }

  @override
  String? getPrimaryKey(GetInTouch object) {
    return object.aboutEmail;
  }

  @override
  Filter getFilter(GetInTouch object) {
    return Filter.equals(_primaryKey, object.aboutEmail);
  }
}
