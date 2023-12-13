import '../../constant/ps_constants.dart';
import '../../repository/item_paid_history_repository.dart';
import '../../viewobject/item_paid_history.dart';
import '../common/ps_provider.dart';

class ItemPromotionProvider extends PsProvider<ItemPaidHistory> {
  ItemPromotionProvider({
    required ItemPaidHistoryRepository? itemPaidHistoryRepository,
    int limit = 0,
    
  }) : super(itemPaidHistoryRepository, limit,subscriptionType: PsConst.NO_SUBSCRIPTION);

  String? selectedDate;
  DateTime? selectedDateTime;

  String amount = '0';
  String howManyDay  = '0';

}
