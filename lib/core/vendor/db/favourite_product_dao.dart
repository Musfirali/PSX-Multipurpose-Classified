

import 'package:sembast/sembast.dart';

import '../viewobject/favourite_product.dart';
import 'common/ps_dao.dart';

class FavouriteProductDao extends PsDao<FavouriteProduct> {
  FavouriteProductDao._() {
    init(FavouriteProduct());
  }
  static const String STORE_NAME = 'FavouriteProduct';
  final String _primaryKey = 'id';

  // Singleton instance
  static final FavouriteProductDao _singleton = FavouriteProductDao._();

  // Singleton accessor
  static FavouriteProductDao get instance => _singleton;

  @override
  String getStoreName() {
    return STORE_NAME;
  }

  @override
  String? getPrimaryKey(FavouriteProduct object) {
    return object.id;
  }

  @override
  Filter getFilter(FavouriteProduct object) {
    return Filter.equals(_primaryKey, object.id);
  }
}
