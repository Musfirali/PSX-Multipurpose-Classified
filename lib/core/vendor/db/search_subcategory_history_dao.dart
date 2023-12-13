import 'package:sembast/sembast.dart';

import '../viewobject/search_subcategory_history.dart';
import 'common/ps_dao.dart';

class SearchSubCategoryHistoryDao extends PsDao<SearchSubCategoryHistory> {
  SearchSubCategoryHistoryDao._() {
    init(SearchSubCategoryHistory());
  }
  static const String STORE_NAME = 'SearchSubCategoryHistory';
  final String _primaryKey = 'id';

  // Singleton instance
  static final SearchSubCategoryHistoryDao _singleton = SearchSubCategoryHistoryDao._();

  // Singleton accessor
  static SearchSubCategoryHistoryDao get instance => _singleton;

  @override
  String getStoreName() {
    return STORE_NAME;
  }

  @override
  String? getPrimaryKey(SearchSubCategoryHistory object) {
    return object.id;
  }

  @override
  Filter getFilter(SearchSubCategoryHistory object) {
    return Filter.equals(_primaryKey, object.id);
  }
}
