import '../../../provider/app_info/app_info_provider.dart';
import '../../../provider/promotion/item_promotion_provider.dart';
import '../../../provider/user/user_provider.dart';
import '../../product.dart';

class PromotePaymentIntentHolder {
  const PromotePaymentIntentHolder(
      {required this.date, required this.product,required this.day,required this.amount,required this.time,required this.appInfoProvider,required this.itemPaidHistoryProvider,required this.userProvider});
  final String date;
  final DateTime time;
  final String amount;
  final String day;

final Product product;
final AppInfoProvider? appInfoProvider;
final ItemPromotionProvider itemPaidHistoryProvider;
final UserProvider? userProvider;
}
