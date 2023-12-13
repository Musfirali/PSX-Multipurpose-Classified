import 'dart:async';

import '../api/common/ps_resource.dart';
import '../api/ps_api_service.dart';
import '../db/best_choice_dao.dart';
import '../db/common/ps_data_source_manager.dart';
import '../viewobject/common/ps_holder.dart';
import '../viewobject/holder/request_path_holder.dart';
import 'Common/ps_repository.dart';

class BestChoiceRepository extends PsRepository {
  BestChoiceRepository(
      {required PsApiService psApiService,
      required BestChoiceDao bestChoiceDao}) {
    _psApiService = psApiService;
    _bestChoiceDao = bestChoiceDao;
  }

  late PsApiService _psApiService;
  late BestChoiceDao _bestChoiceDao;

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
        dao: _bestChoiceDao,
        streamController: streamController,
        dataConfig: dataConfig,
        serverRequestCallback: () => _psApiService.getBestChoiceList());
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
        dao: _bestChoiceDao,
        streamController: streamController,
        dataConfig: dataConfig,
        serverRequestCallback: () => _psApiService.getBestChoiceList());
  }
}
