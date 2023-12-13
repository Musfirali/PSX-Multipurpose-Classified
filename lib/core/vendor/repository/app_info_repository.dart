import 'dart:async';

import '../api/common/ps_resource.dart';
import '../api/common/ps_status.dart';
import '../api/ps_api_service.dart';
import '../viewobject/common/ps_holder.dart';
import '../viewobject/holder/request_path_holder.dart';
import '../viewobject/ps_app_info.dart';
import 'Common/ps_repository.dart';

class AppInfoRepository extends PsRepository {
  AppInfoRepository({
    required PsApiService psApiService,
  }) {
    _psApiService = psApiService;
  }
  late PsApiService _psApiService;

  // Future<PsResource<PSAppInfo>> postDeleteHistory(Map<dynamic, dynamic> jsonMap,
  //     {bool isLoadFromServer = true}) async {
  //   final PsResource<PSAppInfo> _resource =
  //       await _psApiService.postPsAppInfo(jsonMap);
  //   if (_resource.status == PsStatus.SUCCESS) {
  //     if (_resource.data!.deleteObject!.isNotEmpty) {}
  //     return _resource;
  //   } else {
  //     final Completer<PsResource<PSAppInfo>> completer =
  //         Completer<PsResource<PSAppInfo>>();
  //     completer.complete(_resource);
  //     return completer.future;
  //   }
  // }
  @override
  Future<PsResource<PSAppInfo>> postData({
    PsHolder<dynamic>? requestBodyHolder,
    RequestPathHolder? requestPathHolder,
  }) async {
    final PsResource<PSAppInfo> _resource =
        await _psApiService.postPsAppInfo(
          requestBodyHolder!.toMap(), 
          requestPathHolder?.loginUserId ?? 'nologinuser');

    if (_resource.status == PsStatus.SUCCESS) {
      // if (_resource.data!.deleteObject!.isNotEmpty) {

      // }
      return _resource;
    } else {
      final Completer<PsResource<PSAppInfo>> completer =
          Completer<PsResource<PSAppInfo>>();
      completer.complete(_resource);
      return completer.future;
    }
  }
}
