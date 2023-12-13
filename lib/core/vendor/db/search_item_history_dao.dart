import 'package:sembast/sembast.dart';

import '../viewobject/search_item_history.dart';
import 'common/ps_dao.dart';

class SearchItemHistoryDao extends PsDao<SearchItemHistory> {
  SearchItemHistoryDao._() {
    init(SearchItemHistory());
  }
  static const String STORE_NAME = 'SearchItemHistory';
  final String _primaryKey = 'id';

  // Singleton instance
  static final SearchItemHistoryDao _singleton = SearchItemHistoryDao._();

  // Singleton accessor
  static SearchItemHistoryDao get instance => _singleton;

  @override
  String getStoreName() {
    return STORE_NAME;
  }

  @override
  String? getPrimaryKey(SearchItemHistory object) {
    return object.id;
  }

  @override
  Filter getFilter(SearchItemHistory object) {
    return Filter.equals(_primaryKey, object.id);
  }
}
