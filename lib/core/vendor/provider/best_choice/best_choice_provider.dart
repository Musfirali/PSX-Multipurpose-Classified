import '../../api/common/ps_resource.dart';
import '../../constant/ps_constants.dart';
import '../../repository/best_choice_repository.dart';
import '../../viewobject/best_choice.dart';
import '../common/ps_provider.dart';

class BestChoiceProvider extends PsProvider<BestChoice> {
  BestChoiceProvider({required BestChoiceRepository repo, int limit = 0})
      : super(repo, limit, subscriptionType: PsConst.LIST_OBJECT_SUBSCRIPTION);

  PsResource<List<BestChoice>> get bestChoiceList => dataList;
}
