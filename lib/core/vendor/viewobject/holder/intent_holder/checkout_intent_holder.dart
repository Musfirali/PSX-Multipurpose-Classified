
import '../../../provider/shop/shop_info_provider.dart';
import '../../basket.dart';

class CheckoutIntentHolder {
  const CheckoutIntentHolder({
    required this.basketList,
    this.shopInfoProvider,
  });
  final List<Basket>? basketList;
  final ShopInfoProvider ?shopInfoProvider;
}
