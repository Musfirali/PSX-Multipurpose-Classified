import 'dart:async';

import '../../api/common/ps_status.dart';
import '../../constant/ps_constants.dart';
import '../../repository/rating_repository.dart';
import '../../utils/utils.dart';
import '../../viewobject/rating.dart';
import '../common/ps_provider.dart';

class RatingProvider extends PsProvider<Rating> {
  RatingProvider({
    required RatingRepository? repo,
    int limit = 0,
  }) : super(repo, limit, subscriptionType: PsConst.NO_SUBSCRIPTION) {
    _repo = repo;
  }

  RatingRepository? _repo;

  dynamic daoSubscription;

  @override
  void dispose() {
    if (daoSubscription != null) {
      daoSubscription.cancel();
    }
    isDispose = true;
    super.dispose();
  }

  Future<dynamic> postRating(
      Map<dynamic, dynamic> jsonMap, String loginUserId, String headerToken,String languageCode) async {
    isLoading = true;

    isConnectedToInternet = await Utils.checkInternetConnectivity();

    daoSubscription = await _repo!.postRating(super.dataListStreamController,
        jsonMap, isConnectedToInternet, loginUserId, headerToken, PsStatus.PROGRESS_LOADING,languageCode);

    return daoSubscription;
  }
}
