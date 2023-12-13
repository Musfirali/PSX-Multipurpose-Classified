

import 'package:sembast/sembast.dart';

import '../viewobject/common/language.dart';
import 'common/ps_dao.dart';

class LanguageDao extends PsDao<Language> {
  LanguageDao._() {
    init(Language());
  }

  static const String STORE_NAME = 'Language';
  final String _primaryKey = 'id';
  // Singleton instance
  static final LanguageDao _singleton = LanguageDao._();

  // Singleton accessor
  static LanguageDao get instance => _singleton;

  @override
  String getStoreName() {
    return STORE_NAME;
  }

  @override
  String? getPrimaryKey(Language object) {
    return object.id;
  }

  @override
  Filter getFilter(Language object) {
    return Filter.equals(_primaryKey, object.id);
  }
}
