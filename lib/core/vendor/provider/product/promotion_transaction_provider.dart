import '../../api/common/ps_resource.dart';
import '../../api/common/ps_status.dart';
import '../../constant/ps_constants.dart';
import '../../repository/promotion_transaction_repository.dart';
import '../../utils/utils.dart';
import '../../viewobject/api_status.dart';
import '../../viewobject/common/ps_value_holder.dart';
import '../../viewobject/promotion_transaction.dart';
import '../common/ps_provider.dart';

class PromotionTranscationHistoryProvider
    extends PsProvider<PromotionTransaction> {
  PromotionTranscationHistoryProvider({
    required PromotionTranscationRepository? repo,
    required this.psValueHolder,
    int limit = 0,
  }) : super(repo, limit, subscriptionType: PsConst.LIST_OBJECT_SUBSCRIPTION) {
    _repo = repo;
  }

  PsValueHolder? psValueHolder;
  PromotionTranscationRepository? _repo;

  PsResource<List<PromotionTransaction>> get transactionList => super.dataList;

  Future<PsResource<ApiStatus>> deletePromotionHistoryList(
    Map<dynamic, dynamic> jsonMap,
    String? loginUserId,String languageCode,
  ) async {
    isLoading = true;

    isConnectedToInternet = await Utils.checkInternetConnectivity();

    return await _repo!.deletePromotionHistoryList(
        jsonMap, isConnectedToInternet, loginUserId, PsStatus.PROGRESS_LOADING,languageCode);
  }
}
