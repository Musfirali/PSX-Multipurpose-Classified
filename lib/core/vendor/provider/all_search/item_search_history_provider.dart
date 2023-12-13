import '../../api/common/ps_resource.dart';
import '../../api/common/ps_status.dart';
import '../../constant/ps_constants.dart';
import '../../repository/search_history_repository.dart';
import '../../utils/utils.dart';
import '../../viewobject/api_status.dart';
import '../../viewobject/search_history.dart';
import '../common/ps_provider.dart';

class ItemSearchHistoryProvider extends PsProvider<SearchHistory> {
  ItemSearchHistoryProvider({required SearchHistoryRepository repo, int limit = 0})
      : super(repo, limit,
            subscriptionType: PsConst.LIST_OBJECT_SUBSCRIPTION){
              _repo = repo;
            }

  PsResource<List<SearchHistory>> get searchHistory => dataList;

    PsResource<ApiStatus> _apiStatus =
      PsResource<ApiStatus>(PsStatus.NOACTION, '', null);
  PsResource<ApiStatus> get user => _apiStatus;

 late SearchHistoryRepository _repo;

 
   Future<dynamic> deleteSearchHistoryList(
    Map<dynamic, dynamic> jsonMap,
    String? loginUserId,
    String? languageCode,
  ) async {
    isLoading = true;

    isConnectedToInternet = await Utils.checkInternetConnectivity();

    _apiStatus = await _repo.deleteSearchHistoryList(
        jsonMap, loginUserId, languageCode, isConnectedToInternet, PsStatus.PROGRESS_LOADING);

    return _apiStatus;
  }
}
