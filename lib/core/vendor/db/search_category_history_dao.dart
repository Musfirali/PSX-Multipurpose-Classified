import 'package:sembast/sembast.dart';

import '../viewobject/search_category_history.dart';
import 'common/ps_dao.dart';

class SearchCategoryHistoryDao extends PsDao<SearchCategoryHistory> {
  SearchCategoryHistoryDao._() {
    init(SearchCategoryHistory());
  }
  static const String STORE_NAME = 'SearchCategoryHistory';
  final String _primaryKey = 'id';

  // Singleton instance
  static final SearchCategoryHistoryDao _singleton = SearchCategoryHistoryDao._();

  // Singleton accessor
  static SearchCategoryHistoryDao get instance => _singleton;

  @override
  String getStoreName() {
    return STORE_NAME;
  }

  @override
  String? getPrimaryKey(SearchCategoryHistory object) {
    return object.id;
  }

  @override
  Filter getFilter(SearchCategoryHistory object) {
    return Filter.equals(_primaryKey, object.id);
  }
}
