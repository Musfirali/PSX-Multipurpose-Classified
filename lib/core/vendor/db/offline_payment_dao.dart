import 'package:sembast/sembast.dart';

import '../viewobject/offline_payment.dart';
import 'common/ps_dao.dart';

class OfflinePaymentDao extends PsDao<OfflinePayment> {
  OfflinePaymentDao._() {
    init(OfflinePayment());
  }

  static const String STORE_NAME = 'OfflinePaymentMethod';
  final String _primaryKey = 'id';
  // Singleton instance
  static final OfflinePaymentDao _singleton = OfflinePaymentDao._();

  // Singleton accessor
  static OfflinePaymentDao get instance => _singleton;

  @override
  String getStoreName() {
    return STORE_NAME;
  }

  @override
  String? getPrimaryKey(OfflinePayment? object) {
    return object!.id;
  }

  @override
  Filter getFilter(OfflinePayment? object) {
    return Filter.equals(_primaryKey, object!.id);
  }
}
