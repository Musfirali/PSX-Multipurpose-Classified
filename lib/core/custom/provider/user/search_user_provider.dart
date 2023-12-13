import 'dart:async';

import '../../../vendor/api/common/ps_resource.dart';
import '../../../vendor/api/common/ps_status.dart';
import '../../../vendor/constant/ps_constants.dart';
import '../../../vendor/provider/common/ps_provider.dart';
import '../../../vendor/utils/utils.dart';
import '../../../vendor/viewobject/api_status.dart';
import '../../../vendor/viewobject/common/ps_value_holder.dart';
import '../../repository/search_user_repository.dart';
import '../../viewobject/holder/c_search_user_parameter_holder.dart';
import '../../viewobject/user.dart';

class SearchUserProvider extends PsProvider<CUser> {
  SearchUserProvider({
    required SearchUserRepository? repo,
    required this.psValueHolder,
    int limit = 0,
    
  }) : super(repo, limit,subscriptionType: PsConst.LIST_OBJECT_SUBSCRIPTION) {
    if (limit != 0) {
      super.limit = limit;
    }

    _repo = repo;

    print('SearchUser Provider: $hashCode');

    Utils.checkInternetConnectivity().then((bool onValue) {
      isConnectedToInternet = onValue;
    });

    searchUserListStream =
        StreamController<PsResource<List<CUser>>>.broadcast();
    subscription =
        searchUserListStream!.stream.listen((PsResource<List<CUser>> resource) {
      updateOffset(resource.data!.length);

      _searchUserList = resource;

      if (resource.status != PsStatus.BLOCK_LOADING &&
          resource.status != PsStatus.PROGRESS_LOADING) {
        isLoading = false;
      }

      if (!isDispose) {
        notifyListeners();
      }
    });
  }
  StreamController<PsResource<List<CUser>>>? searchUserListStream;
  CSearchUserParameterHolder searchUserParameterHolder =
      CSearchUserParameterHolder();

  SearchUserRepository? _repo;
  PsValueHolder? psValueHolder;

  PsResource<List<CUser>> _searchUserList =
      PsResource<List<CUser>>(PsStatus.NOACTION, '', <CUser>[]);

  PsResource<List<CUser>> get searchUserList => _searchUserList;
  late StreamSubscription<PsResource<List<CUser>>> subscription;

  final PsResource<ApiStatus> _apiStatus =
      PsResource<ApiStatus>(PsStatus.NOACTION, '', null);
  PsResource<ApiStatus> get user => _apiStatus;
  @override
  void dispose() {
    subscription.cancel();
    isDispose = true;
    print('Search CUser Provider Dispose: $hashCode');
    super.dispose();
  }

  Future<dynamic> loadSearchUserList(
      Map<dynamic, dynamic> jsonMap, String? loginUserId) async {
    isLoading = true;

    isConnectedToInternet = await Utils.checkInternetConnectivity();
    if (isConnectedToInternet) {
      await _repo!.getSearchUserList(
          searchUserListStream,
          isConnectedToInternet,
          jsonMap,
          loginUserId,
          limit,
          offset,
          PsStatus.PROGRESS_LOADING);
    }
    return isConnectedToInternet;
  }

  Future<dynamic> nextSearchUserList(
      Map<dynamic, dynamic> jsonMap, String? loginUserId) async {
    isConnectedToInternet = await Utils.checkInternetConnectivity();

    if (!isLoading && !isReachMaxData) {
      super.isLoading = true;
      await _repo!.getNextPageSearchUserList(
          searchUserListStream,
          isConnectedToInternet,
          jsonMap,
          loginUserId,
          limit,
          offset,
          PsStatus.PROGRESS_LOADING);
    }
  }

  Future<void> resetSearchUserList(
      Map<dynamic, dynamic> jsonMap, String? loginUserId) async {
    isConnectedToInternet = await Utils.checkInternetConnectivity();
    isLoading = true;

    updateOffset(0);
    if (isConnectedToInternet) {
      await _repo!.getSearchUserList(
          searchUserListStream,
          isConnectedToInternet,
          jsonMap,
          loginUserId,
          limit,
          offset,
          PsStatus.PROGRESS_LOADING);
    }

    isLoading = false;
    // return isConnectedToInternet;
  }
}
