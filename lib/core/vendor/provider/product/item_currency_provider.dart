import '../../api/common/ps_resource.dart';
import '../../constant/ps_constants.dart';
import '../../repository/item_currency_repository.dart';
import '../../viewobject/item_currency.dart';
import '../common/ps_provider.dart';

class ItemCurrencyProvider extends PsProvider<ItemCurrency> {
  ItemCurrencyProvider({
    required ItemCurrencyRepository? repo,
    int limit = 0,
  }) : super(repo, limit, subscriptionType: PsConst.LIST_OBJECT_SUBSCRIPTION);

  PsResource<List<ItemCurrency>> get itemCurrencyList => super.dataList;

  String categoryId = '';
}
