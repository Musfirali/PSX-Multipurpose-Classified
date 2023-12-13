import 'package:sembast/sembast.dart';

import '../viewobject/mobile_color.dart';
import 'common/ps_dao.dart';


class MobileColorDao extends PsDao<MobileColor>{
  MobileColorDao._() {
    init(MobileColor());
  }

  static const String STORE_NAME = 'MobileColor';
  final String _primaryKey = '';
  // Singleton instance
  static final MobileColorDao _singleton = MobileColorDao._();

  // Singleton accessor
  static MobileColorDao get instance => _singleton;

  @override
  String getStoreName() {
    return STORE_NAME;
  }

  @override
  String? getPrimaryKey(MobileColor object) {
    return '';
  }

  @override
  Filter getFilter(MobileColor object) {
    return Filter.equals(_primaryKey, '');
  }
}
