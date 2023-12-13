import '../../api/common/ps_resource.dart';
import '../../api/common/ps_status.dart';
import '../../constant/ps_constants.dart';
import '../../repository/search_category_history_repository.dart';
import '../../utils/utils.dart';
import '../../viewobject/api_status.dart';
import '../../viewobject/search_category_history.dart';
import '../common/ps_provider.dart';

class SearchCategoryHistoryProvider extends PsProvider<SearchCategoryHistory> {
  SearchCategoryHistoryProvider({required SearchCategoryHistoryRepository repo, int limit = 0})
      : super(repo, limit, subscriptionType: PsConst.LIST_OBJECT_SUBSCRIPTION) {
    _repo = repo;
  }

  PsResource<List<SearchCategoryHistory>> get searchCategoryHistory => dataList;

  PsResource<ApiStatus> _apiStatus =
      PsResource<ApiStatus>(PsStatus.NOACTION, '', null);
  PsResource<ApiStatus> get user => _apiStatus;

  late SearchCategoryHistoryRepository _repo;

  Future<dynamic> deleteSearchCategoryHistoryList(
    Map<dynamic, dynamic> jsonMap,
    String? loginUserId,
    String? languageCode
  ) async {
    isLoading = true;

    isConnectedToInternet = await Utils.checkInternetConnectivity();

    _apiStatus = await _repo.deleteSearchCategoryHistoryList(
        jsonMap, loginUserId, languageCode, isConnectedToInternet, PsStatus.PROGRESS_LOADING);

    return _apiStatus;
  }
}
