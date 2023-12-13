import 'dart:async';

import '../../api/common/ps_resource.dart';
import '../../api/common/ps_status.dart';
import '../../constant/ps_constants.dart';
import '../../repository/user_repository.dart';
import '../../utils/utils.dart';
import '../../viewobject/common/ps_value_holder.dart';
import '../../viewobject/holder/user_parameter_holder.dart';
import '../../viewobject/user_login.dart';
import '../common/ps_provider.dart';

class UserLoginProvider extends PsProvider<UserLogin> {
  UserLoginProvider({
    required UserRepository repo,
    required this.psValueHolder,
    int limit = 0,
    
  }) : super(repo, limit,subscriptionType: PsConst.SINGLE_OBJECT_SUBSCRIPTION) {
    _repo = repo;
    isDispose = false;

    userLoginStream = StreamController<PsResource<UserLogin>>.broadcast();
    subscriptionUserLogin = userLoginStream!.stream
        .listen((PsResource<UserLogin> userLoginResource) {
      _userLogin = userLoginResource;

      if (userLoginResource.status != PsStatus.BLOCK_LOADING &&
          userLoginResource.status != PsStatus.PROGRESS_LOADING) {
        isLoading = false;
      }

      if (!isDispose) {
        notifyListeners();
      }
    });
  }

  late UserRepository _repo;
  PsValueHolder psValueHolder;

  UserParameterHolder userParameterHolder =
      UserParameterHolder().getOtherUserData();

  PsResource<UserLogin> _userLogin =
      PsResource<UserLogin>(PsStatus.NOACTION, '', null);
  PsResource<UserLogin> get userLogin => _userLogin;

  StreamController<PsResource<UserLogin>>? userLoginStream;
  late StreamSubscription<PsResource<UserLogin>> subscriptionUserLogin;

  @override
  void dispose() {
    subscriptionUserLogin.cancel();
    isDispose = true;
    super.dispose();
  }

  Future<dynamic> getUserLoginFromDB(String loginUserId) async {
    isLoading = true;

    await _repo.getUserLoginFromDB(
        loginUserId, userLoginStream!, PsStatus.PROGRESS_LOADING);
  }

  Future<dynamic> getMyUserData(
    Map<dynamic, dynamic> jsonMap,String loginUserId,String languageCode
  ) async {
    isLoading = true;

    isConnectedToInternet = await Utils.checkInternetConnectivity();

    _userLogin = await _repo.getMyUserData(userLoginStream, jsonMap, loginUserId, psValueHolder.headerToken!, limit, offset!,
        isConnectedToInternet, PsStatus.PROGRESS_LOADING,languageCode);

    return _userLogin;
  }
}
