import 'dart:async';
import 'package:sembast/sembast.dart';

import '../api/common/ps_resource.dart';
import '../api/ps_api_service.dart';
import '../db/common/ps_data_source_manager.dart';
import '../db/shipping_area_dao.dart';
import '../viewobject/common/ps_holder.dart';
import '../viewobject/holder/request_path_holder.dart';
import 'Common/ps_repository.dart';

class ShippingAreaRepository extends PsRepository {
  ShippingAreaRepository(
      {required PsApiService psApiService,
      required ShippingAreaDao shippingAreaDao}) {
    _psApiService = psApiService;
    _shippingAreaDao = shippingAreaDao;
  }

  String primaryKey = 'id';
  late PsApiService _psApiService;
  late ShippingAreaDao _shippingAreaDao;

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
      dao: _shippingAreaDao,
      streamController: streamController,
      dataConfig: dataConfig,
      serverRequestCallback: () =>
          _psApiService.getShippingArea(requestPathHolder!.shopId!),
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
      dao: _shippingAreaDao,
      streamController: streamController,
      dataConfig: dataConfig,
      serverRequestCallback: () =>
          _psApiService.getShippingArea(requestPathHolder!.shopId!),
    );
  }

  @override
  Future<void> loadData({
    required StreamController<PsResource<dynamic>> streamController,
    PsHolder<dynamic>? requestBodyHolder,
    RequestPathHolder? requestPathHolder,
    required DataConfiguration dataConfig,
  }) async {
    await startResourceSinkingForOne(
        dao: _shippingAreaDao,
        finder:
            Finder(filter: Filter.equals('id', requestPathHolder!.shippingId!)),
        streamController: streamController,
        dataConfig: dataConfig,
        serverRequestCallback: () =>
            _psApiService.getShippingAreaById(requestPathHolder.shippingId!));
  }
}
