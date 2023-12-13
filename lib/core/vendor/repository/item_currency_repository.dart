import 'dart:async';

import '../api/common/ps_resource.dart';
import '../api/common/ps_status.dart';
import '../api/ps_api_service.dart';
import '../db/common/ps_data_source_manager.dart';
import '../db/item_currency_dao.dart';
import '../viewobject/common/ps_holder.dart';
import '../viewobject/holder/request_path_holder.dart';
import '../viewobject/item_currency.dart';
import 'Common/ps_repository.dart';

class ItemCurrencyRepository extends PsRepository {
  ItemCurrencyRepository(
      {required PsApiService psApiService,
      required ItemCurrencyDao itemCurrencyDao}) {
    _psApiService = psApiService;
    _itemConditionDao = itemCurrencyDao;
  }

  late PsApiService _psApiService;
  late ItemCurrencyDao _itemConditionDao;
  final String _primaryKey = 'id';

  Future<dynamic> insert(ItemCurrency itemCurrency) async {
    return _itemConditionDao.insert(_primaryKey, itemCurrency);
  }

  Future<dynamic> update(ItemCurrency itemCurrency) async {
    return _itemConditionDao.update(itemCurrency);
  }

  Future<dynamic> delete(ItemCurrency itemCurrency) async {
    return _itemConditionDao.delete(itemCurrency);
  }

  @override
  Future<void> loadDataList(
      {required StreamController<PsResource<List<dynamic>>> streamController,
      required int limit,
      required int offset,
      PsHolder<dynamic>? requestBodyHolder,
      RequestPathHolder? requestPathHolder,
      required DataConfiguration dataConfig}) async {
    await startResourceSinkingForList(
      dao: _itemConditionDao,
      streamController: streamController,
      dataConfig: dataConfig,
      serverRequestCallback: () =>
          _psApiService.getItemCurrencyList(
            limit, offset,
            requestPathHolder?.loginUserId ?? 'nologinuser',
            requestPathHolder?.languageCode ?? 'en'),
    );
  }

  @override
  Future<void> loadNextDataList(
      {required StreamController<PsResource<List<dynamic>>> streamController,
      required int limit,
      required int offset,
      PsHolder<dynamic>? requestBodyHolder,
      RequestPathHolder? requestPathHolder,
      required DataConfiguration dataConfig}) async {
    await startResourceSinkingForNextList(
      dao: _itemConditionDao,
      streamController: streamController,
      dataConfig: dataConfig,
      loadingStatus: PsStatus.PROGRESS_LOADING,
      serverRequestCallback: () =>
          _psApiService.getItemCurrencyList(
            limit, offset,
            requestPathHolder?.loginUserId ?? 'nologinuser',
            requestPathHolder?.languageCode ?? 'en'),
    );
  }
}
