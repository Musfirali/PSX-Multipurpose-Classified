import 'dart:async';
import '../../../vendor/repository/Common/ps_repository.dart';

import '../../api/common/ps_resource.dart';
import '../../api/common/ps_status.dart';
import '../../api/ps_api_service.dart';
import '../../viewobject/api_status.dart';

class NotificationRepository extends PsRepository {
  NotificationRepository({required PsApiService psApiService}) {
    _psApiService = psApiService;
  }

  late PsApiService _psApiService;

  //noti register
  Future<PsResource<ApiStatus>> rawRegisterNotiToken(
      Map<dynamic, dynamic> jsonMap,
      bool isConnectedToInternet,
      PsStatus status,
      String loginUserId,
      String headerToken,
      String? languageCode,
      {bool isLoadFromServer = true}) async {
    final PsResource<ApiStatus> _resource =
        await _psApiService.rawRegisterNotiToken(
            jsonMap, loginUserId, headerToken, languageCode ?? 'en');
    if (_resource.status == PsStatus.SUCCESS) {
      return _resource;
    } else {
      final Completer<PsResource<ApiStatus>> completer =
          Completer<PsResource<ApiStatus>>();
      completer.complete(_resource);
      return completer.future;
    }
  }
  //end region

  //noti unregister
  Future<PsResource<ApiStatus>> rawUnRegisterNotiToken(
      Map<dynamic, dynamic> jsonMap,
      bool isConnectedToInternet,
      PsStatus status,
      String loginuserId,
      String headerToken,
      String? languageCode,
      {bool isLoadFromServer = true}) async {
    final PsResource<ApiStatus> _resource =
        await _psApiService.rawUnRegisterNotiToken(
            jsonMap, loginuserId, headerToken, languageCode ?? 'en');
    if (_resource.status == PsStatus.SUCCESS) {
      return _resource;
    } else {
      final Completer<PsResource<ApiStatus>> completer =
          Completer<PsResource<ApiStatus>>();
      completer.complete(_resource);
      return completer.future;
    }
  }

  //end region
}
