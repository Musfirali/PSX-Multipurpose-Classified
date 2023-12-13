import 'package:psxmpc/core/vendor/viewobject/user_filed.dart';
import 'package:sembast/sembast.dart';

import 'common/ps_dao.dart';

class UserFieldDao extends PsDao<UserField> {
  UserFieldDao._() {
    init(UserField());
  }

  static final UserFieldDao _singleton = UserFieldDao._();

  static UserFieldDao get instance => _singleton;

  static const String STORE_NAME = 'UserField';

  @override
  Filter getFilter(UserField object) {
    return Filter.byKey('');
  }

  @override
  String getPrimaryKey(UserField object) {
    return '';
  }

  @override
  String getStoreName() {
    return STORE_NAME;
  }
}