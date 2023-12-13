import 'dart:async';
import '../api/common/ps_resource.dart';
import '../api/common/ps_status.dart';
import '../api/ps_api_service.dart';
import '../db/common/ps_data_source_manager.dart';
import '../db/promotion_transaction_dao.dart';
import '../viewobject/api_status.dart';
import '../viewobject/common/ps_holder.dart';
import '../viewobject/holder/request_path_holder.dart';
import '../viewobject/promotion_transaction.dart';
import 'Common/ps_repository.dart';

class PromotionTranscationRepository extends PsRepository {
  PromotionTranscationRepository(
      {required PsApiService psApiService,
      required PromotionTransactionDao promotransactionDao}) {
    _psApiService = psApiService;
    _promotransactionDao = promotransactionDao;
  }

  String primaryKey = 'id';
  String mapKey = 'map_key';
  late PsApiService _psApiService;
  late PromotionTransactionDao _promotransactionDao;

  Future<dynamic> insert(PromotionTransaction promoTransaction) async {
    return _promotransactionDao.insert(primaryKey, promoTransaction);
  }

  Future<dynamic> update(PromotionTransaction promoTransaction) async {
    return _promotransactionDao.update(promoTransaction);
  }

  Future<dynamic> delete(PromotionTransaction promoTransaction) async {
    return _promotransactionDao.delete(promoTransaction);
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
    await startResourceSinkingForList(
      dao: _promotransactionDao,
      streamController: streamController,
      dataConfig: dataConfig,
      serverRequestCallback: () =>
          _psApiService.getPromotionTransactionDetailList(
              requestBodyHolder!.toMap(),
              limit,
              offset,
              requestPathHolder!.loginUserId!,requestPathHolder.languageCode ?? 'en'),
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
    await startResourceSinkingForNextList(
      dao: _promotransactionDao,
      streamController: streamController,
      dataConfig: dataConfig,
      loadingStatus: PsStatus.PROGRESS_LOADING,
      serverRequestCallback: () =>
          _psApiService.getPromotionTransactionDetailList(
              requestBodyHolder!.toMap(),
              limit,
              offset,
              requestPathHolder!.loginUserId!,requestPathHolder.languageCode ?? 'en'),
    );
  }

  Future<PsResource<ApiStatus>> deletePromotionHistoryList(
      Map<dynamic, dynamic> jsonMap,
      bool isConnectedToInternet,
      String? loginUserId,
      PsStatus status,String languageCode,
      {bool isLoadFromServer = true}) async {
    final PsResource<ApiStatus> _resource =
        await _psApiService.deletePromotionHistoryList(jsonMap, loginUserId,languageCode);
    if (_resource.status == PsStatus.SUCCESS) {
      return _resource;
    } else {
      final Completer<PsResource<ApiStatus>> completer =
          Completer<PsResource<ApiStatus>>();
      completer.complete(_resource);
      return completer.future;
    }
  }
}
