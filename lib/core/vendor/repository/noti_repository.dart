import 'dart:async';

import '../api/common/ps_resource.dart';
import '../api/common/ps_status.dart';
import '../api/ps_api_service.dart';
import '../db/common/ps_data_source_manager.dart';
import '../db/noti_dao.dart';
import '../viewobject/common/ps_holder.dart';
import '../viewobject/holder/request_path_holder.dart';
import '../viewobject/noti.dart';
import 'Common/ps_repository.dart';

class NotiRepository extends PsRepository {
  NotiRepository(
      {required PsApiService psApiService, required NotiDao notiDao}) {
    _psApiService = psApiService;
    _notiDao = notiDao;
  }

  late PsApiService _psApiService;
  late NotiDao _notiDao;
  final String _primaryKey = 'id';

  Future<dynamic> insert(Noti noti) async {
    return _notiDao.insert(_primaryKey, noti);
  }

  Future<dynamic> update(Noti noti) async {
    return _notiDao.update(noti);
  }

  Future<dynamic> delete(Noti noti) async {
    return _notiDao.delete(noti);
  }

  @override
  Future<void> loadDataList({
    required StreamController<PsResource<List<dynamic>>> streamController,
    required int limit,
    required int offset,
    PsHolder<dynamic>? requestBodyHolder,
    RequestPathHolder? requestPathHolder,
    required DataConfiguration dataConfig,
  }) async {
    startResourceSinkingForList(
      dao: _notiDao,
      streamController: streamController,
      dataConfig: dataConfig,
      serverRequestCallback: () => _psApiService.getNotificationList(
          requestBodyHolder!.toMap(),
          limit,
          offset,
          requestPathHolder?.loginUserId ?? 'nologinuser',requestPathHolder!.languageCode ?? 'en'),
    );
  }

  Future<PsResource<Noti>> postReadNoti(
      StreamController<PsResource<List<dynamic>>>? ratingListStream,
      Map<dynamic, dynamic> jsonMap,
      bool isConnectedToInternet,
      String? loginUserId,
      String headerToken,
      String? languageCode,
      {bool isLoadFromServer = true}) async {
    final PsResource<Noti> _resource =
        await _psApiService.postReadNoti(jsonMap, loginUserId ?? 'nologinuser', headerToken,languageCode ?? 'en');
    if (_resource.status == PsStatus.SUCCESS) {
      ratingListStream!.sink
          .add(await _notiDao.getAll(status: PsStatus.SUCCESS));
      return _resource;
    } else {
      final Completer<PsResource<Noti>> completer =
          Completer<PsResource<Noti>>();
      completer.complete(_resource);
      ratingListStream!.sink
          .add(await _notiDao.getAll(status: PsStatus.SUCCESS));
      return completer.future;
    }
  }

  Future<PsResource<Noti>> postUnReadNoti(
      StreamController<PsResource<List<dynamic>>>? ratingListStream,
      Map<dynamic, dynamic> jsonMap,
      bool isConnectedToInternet,
      String? loginUserId,
      String headerToken,
      String? languageCode,
      {bool isLoadFromServer = true}) async {
    final PsResource<Noti> _resource = await _psApiService.postUnReadNoti(
        jsonMap, loginUserId ?? 'nologinuser', headerToken,languageCode ?? 'en');
    if (_resource.status == PsStatus.SUCCESS) {
      ratingListStream!.sink
          .add(await _notiDao.getAll(status: PsStatus.SUCCESS));
      return _resource;
    } else {
      final Completer<PsResource<Noti>> completer =
          Completer<PsResource<Noti>>();
      completer.complete(_resource);
      ratingListStream!.sink
          .add(await _notiDao.getAll(status: PsStatus.SUCCESS));
      return completer.future;
    }
  }

  Future<PsResource<Noti>> postDeleteNoti(
      StreamController<PsResource<List<dynamic>>>? ratingListStream,
      Map<dynamic, dynamic> jsonMap,
      bool isConnectedToInternet,
      String? loginUserId,
      String? languageCode,
      {bool isLoadFromServer = true}) async {
    final PsResource<Noti> _resource = await _psApiService.postDeleteNoti(
        jsonMap, loginUserId ?? 'nologinuser',languageCode ?? 'en');
    if (_resource.status == PsStatus.SUCCESS) {
      ratingListStream!.sink
          .add(await _notiDao.getAll(status: PsStatus.SUCCESS));
      return _resource;
    } else {
      final Completer<PsResource<Noti>> completer =
          Completer<PsResource<Noti>>();
      completer.complete(_resource);
      ratingListStream!.sink
          .add(await _notiDao.getAll(status: PsStatus.SUCCESS));
      return completer.future;
    }
  }
}
