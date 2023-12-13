import 'dart:async';

import '../../api/common/ps_resource.dart';
import '../../api/common/ps_status.dart';
import '../../constant/ps_constants.dart';
import '../../repository/token_repository.dart';
import '../../utils/utils.dart';
import '../../viewobject/api_status.dart';
import '../common/ps_provider.dart';

class TokenProvider extends PsProvider<ApiStatus> {
  TokenProvider({
    required TokenRepository? repo,
    int limit = 0,
  }) : super(repo, limit, subscriptionType: PsConst.NO_SUBSCRIPTION) {
    _repo = repo;
  }

  TokenRepository? _repo;

  Future<PsResource<ApiStatus>> loadToken( String loginUserId,String languageCode) async {
    isLoading = true;
    isConnectedToInternet = await Utils.checkInternetConnectivity();

    final PsResource<ApiStatus> _resource =
        await _repo!.getToken(isConnectedToInternet, PsStatus.SUCCESS,loginUserId,languageCode);

    return _resource;
  }
}
