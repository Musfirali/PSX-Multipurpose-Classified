import 'package:sembast/sembast.dart';

import '../viewobject/product_entry_field.dart';
import 'common/ps_dao.dart';

class ItemEntryFieldDao extends PsDao<ItemEntryField> {
  ItemEntryFieldDao._() {
    init(ItemEntryField());
  }

  static final ItemEntryFieldDao _singleton = ItemEntryFieldDao._();

  static ItemEntryFieldDao get instance => _singleton;

  static const String STORE_NAME = 'ItemEntry';

  @override
  Filter getFilter(ItemEntryField object) {
    return Filter.byKey('');
  }

  @override
  String getPrimaryKey(ItemEntryField object) {
    return '';
  }

  @override
  String getStoreName() {
    return STORE_NAME;
  }
}