import 'package:sembast/sembast.dart';

import '../viewobject/promotion_transaction.dart';
import 'common/ps_dao.dart';

class PromotionTransactionDao extends PsDao<PromotionTransaction> {
  PromotionTransactionDao._() {
    init(PromotionTransaction());
  }
  static const String STORE_NAME = 'PromotionTransaction';
  final String _primaryKey = 'id';

  // Singleton instance
  static final PromotionTransactionDao _singleton = PromotionTransactionDao._();

  // Singleton accessor
  static PromotionTransactionDao get instance => _singleton;

  @override
  String getStoreName() {
    return STORE_NAME;
  }

  @override
  String? getPrimaryKey(PromotionTransaction object) {
    return object.id;
  }

  @override
  Filter getFilter(PromotionTransaction object) {
    return Filter.equals(_primaryKey, object.id);
  }
}
