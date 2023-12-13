import '../../constant/ps_constants.dart';
import '../../repository/coupon_discount_repository.dart';
import '../../viewobject/coupon_discount.dart';
import '../common/ps_provider.dart';

class CouponDiscountProvider extends PsProvider<CouponDiscount> {
  CouponDiscountProvider(
      {required CouponDiscountRepository repo, int limit = 0})
      : super(repo, limit, subscriptionType: PsConst.SINGLE_OBJECT_SUBSCRIPTION);

  String couponDiscount = '0.0';
  
}
