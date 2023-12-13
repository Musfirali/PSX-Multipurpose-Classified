import 'dart:async';

import '../../api/common/ps_resource.dart';
import '../../api/common/ps_status.dart';
import '../../constant/ps_constants.dart';
import '../../repository/noti_repository.dart';
import '../../utils/utils.dart';
import '../../viewobject/common/ps_value_holder.dart';
import '../../viewobject/noti.dart';
import '../common/ps_provider.dart';

class NotiProvider extends PsProvider<Noti> {
  NotiProvider({
    required NotiRepository? repo,
    this.psValueHolder,
    int limit = 0,
  }) : super(repo, limit, subscriptionType: PsConst.LIST_OBJECT_SUBSCRIPTION) {
    _repo = repo;
  }
  NotiRepository? _repo;
  PsValueHolder? psValueHolder;
  String userId = '';
  String? deviceToken;

  PsResource<Noti?> _noti = PsResource<Noti>(PsStatus.NOACTION, '', null);
  PsResource<Noti?> get user => _noti;

  PsResource<List<Noti>> get notiList => super.dataList;

  Future<dynamic> postNoti(
      Map<dynamic, dynamic> jsonMap, String? loginUserId, String languageCode) async {
    isLoading = true;

    isConnectedToInternet = await Utils.checkInternetConnectivity();

    _noti = await _repo!.postReadNoti(super.dataListStreamController, jsonMap,
        isConnectedToInternet, loginUserId, psValueHolder!.headerToken!,languageCode);

    return _noti;
  }

  Future<dynamic> postUnReadNoti(
      Map<dynamic, dynamic> jsonMap, String? loginUserId, String? languageCode,) async {
    isLoading = true;

    isConnectedToInternet = await Utils.checkInternetConnectivity();

    _noti = await _repo!.postUnReadNoti(super.dataListStreamController, jsonMap,
        isConnectedToInternet, loginUserId, psValueHolder!.headerToken!,languageCode);

    return _noti;
  }

  Future<dynamic> postDeleteNoti(
      Map<dynamic, dynamic> jsonMap, String? loginUserId, String? languageCode) async {
    isLoading = true;

    isConnectedToInternet = await Utils.checkInternetConnectivity();

    _noti = await _repo!.postDeleteNoti(super.dataListStreamController, jsonMap,
        isConnectedToInternet, loginUserId,languageCode);

    return _noti;
  }
}
