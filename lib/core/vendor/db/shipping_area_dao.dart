import 'package:sembast/sembast.dart';
import '../viewobject/shipping_area.dart';
import 'common/ps_dao.dart';

class ShippingAreaDao extends PsDao<ShippingArea> {
  ShippingAreaDao._() {
    init(ShippingArea());
  }
  static const String STORE_NAME = 'ShippingArea';
  final String _primaryKey = 'id';

  // Singleton instance
  static final ShippingAreaDao _singleton = ShippingAreaDao._();

  // Singleton accessor
  static ShippingAreaDao get instance => _singleton;

  @override
  String getStoreName() {
    return STORE_NAME;
  }

  @override
  String? getPrimaryKey(ShippingArea object) {
    return object.id;
  }

  @override
  Filter getFilter(ShippingArea object) {
    return Filter.equals(_primaryKey, object.id);
  }
}
