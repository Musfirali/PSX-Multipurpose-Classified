import 'dart:async';
import '../api/common/ps_resource.dart';
import '../api/common/ps_status.dart';
import '../api/ps_api_service.dart';
import '../db/common/ps_data_source_manager.dart';
import '../db/schedule_header_dao.dart';
import '../viewobject/api_status.dart';
import '../viewobject/common/ps_holder.dart';
import '../viewobject/holder/request_path_holder.dart';
import '../viewobject/schedule_header.dart';
import 'Common/ps_repository.dart';

class ScheduleHeaderRepository extends PsRepository {
  ScheduleHeaderRepository({
    required PsApiService apiService,
    required ScheduleHeaderDao scheduleHeaderDao,
  }) {
    _psApiService = apiService;
    _scheduleHeaderDao = scheduleHeaderDao;
  }

  late PsApiService _psApiService;
  late ScheduleHeaderDao _scheduleHeaderDao;
  // final String _primaryKey = 'id';

  @override
  Future<void> loadDataList({
    required StreamController<PsResource<List<dynamic>>> streamController,
    required int limit,
    required int offset,
    PsHolder<dynamic>? requestBodyHolder,
    RequestPathHolder? requestPathHolder,
    required DataConfiguration dataConfig,
  }) async {
    await startResourceSinkingForList(
        dao: _scheduleHeaderDao,
        streamController: streamController,
        dataConfig: dataConfig,
        serverRequestCallback: () => _psApiService.getAllScheduleHeaderByUserId(
            requestPathHolder!.loginUserId!, limit, offset));
  }

  @override
  Future<void> loadNextDataList({
    required StreamController<PsResource<List<dynamic>>> streamController,
    required int limit,
    required int offset,
    PsHolder<dynamic>? requestBodyHolder,
    RequestPathHolder? requestPathHolder,
    required DataConfiguration dataConfig,
  }) async {
    await startResourceSinkingForNextList(
        dao: _scheduleHeaderDao,
        streamController: streamController,
        dataConfig: dataConfig,
        serverRequestCallback: () => _psApiService.getAllScheduleHeaderByUserId(
            requestPathHolder!.loginUserId!, limit, offset));
  }

  @override
  Future<dynamic> postData({
    required PsHolder<dynamic>? requestBodyHolder,
    required RequestPathHolder? requestPathHolder,
  }) async {}

  // Future<dynamic> postScheduleSubmit(
  //     StreamController<PsResource<List<ScheduleHeader>>> scheduleListStream,
  //     Map<String, dynamic> jsonMap,
  //     PsStatus status,
  //     {bool isLoadFromServer = true}) async {
  //   final PsResource<List<ScheduleHeader>> _resource =
  //       await _psApiService.postScheduleSubmit(jsonMap);
  //   if (_resource.status == PsStatus.SUCCESS) {
  //     return _resource;
  //   } else {
  //     final Completer<PsResource<List<ScheduleHeader>>> completer =
  //         Completer<PsResource<List<ScheduleHeader>>>();
  //     completer.complete(_resource);
  //     return completer.future;
  //   }
  // }

  Future<PsResource<List<ScheduleHeader>>> updateScheduleOrderStatus(
      Map<String, dynamic> json, bool isConnectedToInternet) async {
    final PsResource<List<ScheduleHeader>> _resource =
        await _psApiService.updateScheduleOrder(json);
    if (_resource.status == PsStatus.SUCCESS) {
      return _resource;
    } else {
      final Completer<PsResource<List<ScheduleHeader>>> completer =
          Completer<PsResource<List<ScheduleHeader>>>();
      completer.complete(_resource);
      return completer.future;
    }
  }

  Future<PsResource<ApiStatus>> deleteScheduleOrder(
    Map<String, dynamic> json,
  ) async {
    final PsResource<ApiStatus> _resource =
        await _psApiService.deleteSchedule(json);

    if (_resource.status == PsStatus.SUCCESS) {
      return _resource;
    } else {
      final Completer<PsResource<ApiStatus>> completer =
          Completer<PsResource<ApiStatus>>();
      completer.complete(_resource);
      return completer.future;
    }
  }

  // Future<PsResource<ApiStatus>> postResendCode(Map<dynamic, dynamic> jsonMap,
  //     bool isConnectedToInternet, PsStatus status,
  //     {bool isLoadFromServer = true}) async {
  //   final PsResource<ApiStatus> _resource =
  //       await _psApiService.postResendCode(jsonMap);
  //   if (_resource.status == PsStatus.SUCCESS) {
  //     return _resource;
  //   } else {
  //     final Completer<PsResource<ApiStatus>> completer =
  //         Completer<PsResource<ApiStatus>>();
  //     completer.complete(_resource);
  //     return completer.future;
  //   }
  // }
}
