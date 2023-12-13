import '../../api/common/ps_resource.dart';
import '../../api/common/ps_status.dart';
import '../../constant/ps_constants.dart';
import '../../repository/search_item_history_repository.dart';
import '../../utils/utils.dart';
import '../../viewobject/api_status.dart';
import '../../viewobject/search_item_history.dart';
import '../common/ps_provider.dart';

class SearchItemHistoryProvider extends PsProvider<SearchItemHistory> {
  SearchItemHistoryProvider({required SearchItemHistoryRepository repo, int limit = 0})
      : super(repo, limit, subscriptionType: PsConst.LIST_OBJECT_SUBSCRIPTION) {
    _repo = repo;
  }

  PsResource<List<SearchItemHistory>> get searchItemHistory => dataList;

  PsResource<ApiStatus> _apiStatus =
      PsResource<ApiStatus>(PsStatus.NOACTION, '', null);
  PsResource<ApiStatus> get user => _apiStatus;

  late SearchItemHistoryRepository _repo;

  Future<dynamic> deleteSearchItemHistoryList(
    Map<dynamic, dynamic> jsonMap,
    String? loginUserId,
    String? languageCode
  ) async {
    isLoading = true;

    isConnectedToInternet = await Utils.checkInternetConnectivity();

    _apiStatus = await _repo.deleteSearchItemHistoryList(
        jsonMap, loginUserId, languageCode, isConnectedToInternet, PsStatus.PROGRESS_LOADING);

    return _apiStatus;
  }
}
