
import '../../api/common/ps_resource.dart';
import '../../constant/ps_constants.dart';
import '../../repository/offer_repository.dart';
import '../../viewobject/offer.dart';
import '../common/ps_provider.dart';

class OfferListProvider extends PsProvider<Offer> {
  OfferListProvider({
    required OfferRepository? repo,
    int limit = 0,
  }) : super(repo, limit, subscriptionType: PsConst.LIST_OBJECT_SUBSCRIPTION);

  PsResource<List<Offer>> get offerList => super.dataList;
}
