import 'dart:async';
import 'package:sembast/sembast.dart';
import '../api/common/ps_resource.dart';
import '../api/ps_api_service.dart';
import '../db/common/ps_data_source_manager.dart';
import '../db/schedule_detail_dao.dart';
import '../viewobject/common/ps_holder.dart';
import '../viewobject/holder/request_path_holder.dart';
import 'Common/ps_repository.dart';

class ScheduleDetailRepository extends PsRepository {
  ScheduleDetailRepository({
    required PsApiService apiService,
    required ScheduleDetailDao scheduleDetailDao,
  }) {
    _psApiService = apiService;
    _scheduleDetailDao = scheduleDetailDao;
  }

  String primaryKey = 'id';
  late PsApiService _psApiService;
  late ScheduleDetailDao _scheduleDetailDao;

  @override
  Future<void> loadDataList({
    required StreamController<PsResource<List<dynamic>>> streamController,
    required int limit,
    required int offset,
    PsHolder<dynamic>? requestBodyHolder,
    RequestPathHolder? requestPathHolder,
    required DataConfiguration dataConfig,
  }) async {
    final Finder finder = Finder(
        filter: Filter.equals(
            'schedule_header_id', requestPathHolder!.scheduleHeaderId));
    await startResourceSinkingForList(
      finder: finder,
      dao: _scheduleDetailDao,
      streamController: streamController,
      dataConfig: dataConfig,
      serverRequestCallback: () => _psApiService.getScheduleDetail(
          requestPathHolder.scheduleHeaderId!, limit, offset),
    );
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
    final Finder finder = Finder(
        filter: Filter.equals(
            'schedule_header_id', requestPathHolder!.scheduleHeaderId));
    await startResourceSinkingForNextList(
      finder: finder,
      dao: _scheduleDetailDao,
      streamController: streamController,
      dataConfig: dataConfig,
      serverRequestCallback: () => _psApiService.getScheduleDetail(
          requestPathHolder.scheduleHeaderId!, limit, offset),
    );
  }

  // Future<dynamic> getAllScheduleDetailList(
  //   StreamController<PsResource<List<ScheduleDetail>>> scheduleDetailStream,
  //   bool isConnectedToInternet,
  //   ScheduleHeader scheduleHeader,
  //   int limit,
  //   int offset,
  //   PsStatus status,
  // ) async {
  //   final Finder finder =
  //       Finder(filter: Filter.equals('schedule_header_id', scheduleHeader.id));

  //   scheduleDetailStream.sink
  //       .add(await _scheduleDetailDao.getAll(finder: finder, status: status));

  //   if (isConnectedToInternet) {
  //     final PsResource<List<ScheduleDetail>> resource = await _psApiService
  //         .getScheduleDetail(scheduleHeader.id!, limit, offset);

  //     if (resource.status == PsStatus.SUCCESS) {
  //       await _scheduleDetailDao.deleteWithFinder(finder);
  //       await _scheduleDetailDao.insertAll(primaryKey, resource.data!);
  //     } else {
  //       if (resource.errorCode == PsConst.ERROR_CODE_10001) {
  //         await _scheduleDetailDao.deleteWithFinder(finder);
  //       }
  //     }
  //     scheduleDetailStream.sink
  //         .add(await _scheduleDetailDao.getAll(finder: finder));
  //   }
  // }

  // Future<dynamic> getNextPageScheduleDetailList(
  //   StreamController<PsResource<List<ScheduleDetail>>> scheduleDetailStream,
  //   bool isConnectedToInternet,
  //   ScheduleHeader scheduleHeader,
  //   int limit,
  //   int offset,
  //   PsStatus status,
  // ) async {
  //   final Finder finder =
  //       Finder(filter: Filter.equals('schedule_header_id', scheduleHeader.id));

  //   scheduleDetailStream.sink
  //       .add(await _scheduleDetailDao.getAll(finder: finder, status: status));

  //   if (isConnectedToInternet) {
  //     final PsResource<List<ScheduleDetail>> resource = await _psApiService
  //         .getScheduleDetail(scheduleHeader.id!, limit, offset);

  //     if (resource.status == PsStatus.SUCCESS) {
  //       await _scheduleDetailDao.deleteWithFinder(finder);
  //       await _scheduleDetailDao.insertAll(primaryKey, resource.data!);
  //     } else {
  //       if (resource.errorCode == PsConst.ERROR_CODE_10001) {
  //         await _scheduleDetailDao.deleteWithFinder(finder);
  //       }
  //     }
  //     scheduleDetailStream.sink
  //         .add(await _scheduleDetailDao.getAll(finder: finder));
  //   }
  // }
}
