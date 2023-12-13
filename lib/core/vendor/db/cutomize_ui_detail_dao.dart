import 'package:sembast/sembast.dart';

import '../viewobject/customize_ui_detail.dart';
import 'common/ps_dao.dart';

class CustomizeUiDetailDao extends PsDao<CustomizeUiDetail> {
  CustomizeUiDetailDao._() {
    init(CustomizeUiDetail());
  }

  static final CustomizeUiDetailDao _singleton = CustomizeUiDetailDao._();

  static CustomizeUiDetailDao get instance => _singleton;

  static const String STORE_NAME = 'CustomizeUiDetail';
  String primaryKey = 'id';

  @override
  Filter getFilter(CustomizeUiDetail object) {
    return Filter.equals(primaryKey, object.id);
  }

  @override
  String getPrimaryKey(CustomizeUiDetail object) {
    return object.id.toString();
  }

  @override
  String getStoreName() {
    return STORE_NAME;
  }
}