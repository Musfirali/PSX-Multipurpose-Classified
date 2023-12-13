import '../../api/common/ps_resource.dart';
import '../../constant/ps_constants.dart';
import '../../repository/delivery_cost_repository.dart';
import '../../viewobject/delivery_cost.dart';
import '../common/ps_provider.dart';

class DeliveryCostProvider extends PsProvider<DeliveryCost> {
  DeliveryCostProvider({required DeliveryCostRepository repo, int limit = 0})
      : super(repo, limit, subscriptionType: PsConst.SINGLE_OBJECT_SUBSCRIPTION);

  PsResource<DeliveryCost> get deliveryCost => data;
}
