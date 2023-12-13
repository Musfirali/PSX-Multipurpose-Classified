import 'package:sembast/sembast.dart';

import '../../vendor/db/common/ps_dao.dart';
import '../viewobject/user.dart';

class CUserDao extends PsDao<CUser> {
  CUserDao() {
    init(CUser());
  }

  static const String STORE_NAME = 'CUser';
  final String _primaryKey = 'user_id';

  // Singleton instance
  static final CUserDao _singleton = CUserDao();

  // Singleton accessor
  static CUserDao get instance => _singleton;

  @override
  String? getPrimaryKey(CUser? object) {
    return object!.userId;
  }

  @override
  String getStoreName() {
    return STORE_NAME;
  }

  @override
  Filter getFilter(CUser? object) {
    return Filter.equals(_primaryKey, object!.userId);
  }
}
