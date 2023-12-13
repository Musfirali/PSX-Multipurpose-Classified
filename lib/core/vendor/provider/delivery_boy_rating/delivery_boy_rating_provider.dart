import '../../constant/ps_constants.dart';
import '../../repository/delivery_boy_rating_repository.dart';
import '../../viewobject/delivery_boy_rating.dart';
import '../common/ps_provider.dart';

class DeliveryBoyRatingProvider extends PsProvider<DeliveryBoyRating> {
  DeliveryBoyRatingProvider(
      {required DeliveryBoyRatingRepository repo, int limit = 0})
      : super(repo, limit, subscriptionType: PsConst.NO_SUBSCRIPTION);
      
}
