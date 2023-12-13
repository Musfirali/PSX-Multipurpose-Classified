import 'package:sembast/sembast.dart';

import '../viewobject/all_search_result.dart';
import 'common/ps_dao.dart';

class AllSearchResultDao extends PsDao<AllSearchResult> {
  AllSearchResultDao._() {
    init(AllSearchResult());
  }

  static const String STORE_NAME = 'AllSearchResult';
  final String _primaryKey = 'id';
  // Singleton instance
  static final AllSearchResultDao _singleton = AllSearchResultDao._();

  // Singleton accessor
  static AllSearchResultDao get instance => _singleton;

  @override
  String getStoreName() {
    return STORE_NAME;
  }

  @override
  String? getPrimaryKey(AllSearchResult object) {
    return object.id;
  }

  @override
  Filter getFilter(AllSearchResult object) {
    return Filter.equals(_primaryKey, object.id);
  }
}
