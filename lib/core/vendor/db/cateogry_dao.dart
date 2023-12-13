

import 'package:sembast/sembast.dart';

import '../viewobject/category.dart';
import 'common/ps_dao.dart';

class CategoryDao extends PsDao<Category> {
  CategoryDao() {
    init(Category());
  }
  static const String STORE_NAME = 'Category';
  final String _primaryKey = 'id';

  @override
  String getStoreName() {
    return STORE_NAME;
  }

  @override
  String? getPrimaryKey(Category object) {
    return object.catId;
  }

  @override
  Filter getFilter(Category object) {
    return Filter.equals(_primaryKey, object.catId);
  }
}
