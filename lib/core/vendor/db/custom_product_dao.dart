import 'package:sembast/sembast.dart';

import '../viewobject/custom_product.dart';
import 'common/ps_dao.dart';

class CProductDao extends PsDao<CProduct> {
  CProductDao._() {
    init(CProduct());
  }

  static final CProductDao _singleton = CProductDao._();

  static CProductDao get instance => _singleton;

  static const String STORE_NAME = 'CProduct';
  String primaryKey = 'id';

  @override
  Filter getFilter(CProduct object) {
    return Filter.equals(primaryKey, object.id);
  }

  @override
  String getPrimaryKey(CProduct object) {
    return object.id.toString();
  }

  @override
  String getStoreName() {
    return STORE_NAME;
  }
}
