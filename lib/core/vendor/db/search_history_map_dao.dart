

import 'package:sembast/sembast.dart';

import '../viewobject/search_history_map.dart';
import 'common/ps_dao.dart';

class SearchHistoryMapDao extends PsDao<SearchHistoryMap> {
  SearchHistoryMapDao._() {
    init(SearchHistoryMap());
  }
  static const String STORE_NAME = 'SearchHistoryMap';
  final String _primaryKey = 'id';

  // Singleton instance
  static final SearchHistoryMapDao _singleton = SearchHistoryMapDao._();

  // Singleton accessor
  static SearchHistoryMapDao get instance => _singleton;

  @override
  String getStoreName() {
    return STORE_NAME;
  }

  @override
  String? getPrimaryKey(SearchHistoryMap object) {
    return object.id;
  }

  @override
  Filter getFilter(SearchHistoryMap object) {
    return Filter.equals(_primaryKey, object.id);
  }
}
