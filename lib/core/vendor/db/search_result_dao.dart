import 'package:sembast/sembast.dart';

import '../viewobject/search_result.dart';
import 'common/ps_dao.dart';

class SearchResultDao extends PsDao<SearchResult> {
  SearchResultDao._() {
    init(SearchResult());
  }

  static const String STORE_NAME = 'SearchResult';
  final String _primaryKey = 'id';
  // Singleton instance
  static final SearchResultDao _singleton = SearchResultDao._();

  // Singleton accessor
  static SearchResultDao get instance => _singleton;

  @override
  String getStoreName() {
    return STORE_NAME;
  }

  @override
  String? getPrimaryKey(SearchResult object) {
    return object.id;
  }

  @override
  Filter getFilter(SearchResult object) {
    return Filter.equals(_primaryKey, object.id);
  }
}
