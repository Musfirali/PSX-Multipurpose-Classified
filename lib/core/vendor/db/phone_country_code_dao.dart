import 'package:sembast/sembast.dart';

import '../viewobject/phone_country_code.dart';
import 'common/ps_dao.dart';

class PhoneCountryCodeDao extends PsDao<PhoneCountryCode> {
  PhoneCountryCodeDao._() {
    init(PhoneCountryCode());
  }

  static const String STORE_NAME = 'PhoneCountryCodeDao';
  final String _primaryKey = 'id';

  // Singleton instance
  static final PhoneCountryCodeDao _singleton = PhoneCountryCodeDao._();

  // Singleton accessor
  static PhoneCountryCodeDao get instance => _singleton;

  @override
  String? getPrimaryKey(PhoneCountryCode? object) {
    return object!.id;
  }

  @override
  String getStoreName() {
    return STORE_NAME;
  }

  @override
  Filter getFilter(PhoneCountryCode? object) {
    return Filter.equals(_primaryKey, object!.id);
  }
}
