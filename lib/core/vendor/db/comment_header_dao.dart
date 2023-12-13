import 'package:sembast/sembast.dart';

import '../viewobject/comment_header.dart';
import 'common/ps_dao.dart';

class CommentHeaderDao extends PsDao<CommentHeader> {
  CommentHeaderDao._() {
    init(CommentHeader());
  }
  static const String STORE_NAME = 'CommentHeader';
  final String _primaryKey = 'id';

  // Singleton instance
  static final CommentHeaderDao _singleton = CommentHeaderDao._();

  // Singleton accessor
  static CommentHeaderDao get instance => _singleton;

  @override
  String getStoreName() {
    return STORE_NAME;
  }

  @override
  String? getPrimaryKey(CommentHeader object) {
    return object.id;
  }

  @override
  Filter getFilter(CommentHeader object) {
    return Filter.equals(_primaryKey, object.id);
  }
}
