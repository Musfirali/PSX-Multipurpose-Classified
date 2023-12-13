import '../../../vendor/provider/common/ps_provider.dart';

import '../../api/common/ps_resource.dart';
import '../../api/common/ps_status.dart';
import '../../constant/ps_constants.dart';
import '../../repository/Common/notification_repository.dart';
import '../../utils/utils.dart';
import '../../viewobject/api_status.dart';
import '../../viewobject/common/ps_value_holder.dart';

class NotificationProvider extends PsProvider<Type> {
  NotificationProvider({
    required NotificationRepository? repo,
    required this.psValueHolder,
    int limit = 0,
  }) : super(repo, limit, subscriptionType: PsConst.NO_SUBSCRIPTION) {
    _repo = repo;
  }

  NotificationRepository? _repo;
  PsValueHolder? psValueHolder;

  PsResource<ApiStatus> _notification =
      PsResource<ApiStatus>(PsStatus.NOACTION, '', null);
  PsResource<ApiStatus> get user => _notification;

  Future<dynamic> rawRegisterNotiToken(Map<dynamic, dynamic> jsonMap,
      String loginUserId, String languageCode) async {
    isLoading = true;

    isConnectedToInternet = await Utils.checkInternetConnectivity();

    _notification = await _repo!.rawRegisterNotiToken(
        jsonMap,
        isConnectedToInternet,
        PsStatus.PROGRESS_LOADING,
        loginUserId,
        psValueHolder!.headerToken!,
        languageCode);

    return _notification;
  }

  Future<dynamic> rawUnRegisterNotiToken(Map<dynamic, dynamic> jsonMap,
      String loginUserId, String languageCode) async {
    isLoading = true;

    isConnectedToInternet = await Utils.checkInternetConnectivity();

    _notification = await _repo!.rawUnRegisterNotiToken(
        jsonMap,
        isConnectedToInternet,
        PsStatus.PROGRESS_LOADING,
        loginUserId,
        psValueHolder!.headerToken!,
        languageCode);

    return _notification;
  }
}
