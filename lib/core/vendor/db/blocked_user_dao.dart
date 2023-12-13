

import 'package:sembast/sembast.dart';

import '../viewobject/blocked_user.dart';
import 'common/ps_dao.dart';

class BlockedUserDao extends PsDao<BlockedUser> {
  BlockedUserDao._() {
    init(BlockedUser());
  }
  static const String STORE_NAME = 'BlockedUser';
  final String _primaryKey = 'id';

  // Singleton instance
  static final BlockedUserDao _singleton = BlockedUserDao._();

  // Singleton accessor
  static BlockedUserDao get instance => _singleton;

  @override
  String getStoreName() {
    return STORE_NAME;
  }

  @override
  String? getPrimaryKey(BlockedUser object) {
    return object.userId;
  }

  @override
  Filter getFilter(BlockedUser object) {
    return Filter.equals(_primaryKey, object.userId);
  }
}
