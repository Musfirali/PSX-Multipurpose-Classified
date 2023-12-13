import 'dart:async';

import '../api/common/ps_resource.dart';
import '../api/common/ps_status.dart';
import '../api/ps_api_service.dart';
import '../db/common/ps_data_source_manager.dart';
import '../db/shop_dao.dart';
import '../db/shop_map_dao.dart';
import '../viewobject/api_status.dart';
import '../viewobject/common/ps_holder.dart';
import '../viewobject/holder/request_path_holder.dart';
import '../viewobject/shop.dart';
import '../viewobject/shop_map.dart';
import 'Common/ps_repository.dart';

class ShopRepository extends PsRepository {
  ShopRepository({required PsApiService psApiService, required ShopDao dao}) {
    _psApiService = psApiService;
    _shopDao = dao;
  }

  String primaryKey = 'id';
  String mapKey = 'map_key';
  String tagIdKey = 'tag_id';
  late PsApiService _psApiService;
  late ShopDao _shopDao;

  Future<dynamic> insert(Shop shop) async {
    return _shopDao.insert(primaryKey, shop);
  }

  Future<dynamic> update(Shop shop) async {
    return _shopDao.update(shop);
  }

  Future<dynamic> delete(Shop shop) async {
    return _shopDao.delete(shop);
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
    final String paramKey = requestBodyHolder!.getParamKey();
    final ShopMapDao shopMapDao = ShopMapDao.instance;

    await startResourceSinkingForListWithMap<ShopMap>(
      mapObject: ShopMap(),
      mapDao: shopMapDao,
      dao: _shopDao,
      streamController: streamController,
      dataConfig: dataConfig,
      primaryKey: primaryKey,
      mapKey: mapKey,
      paramKey: paramKey,
      serverRequestCallback: () => _psApiService.getShopList(
        requestBodyHolder.toMap(),
        limit,
        offset,
      ),
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
    final String paramKey = requestBodyHolder!.getParamKey();
    final ShopMapDao shopMapDao = ShopMapDao.instance;
    await startResourceSinkingForNextListWithMap<ShopMap>(
      mapObject: ShopMap(),
      mapDao: shopMapDao,
      dao: _shopDao,
      streamController: streamController,
      dataConfig: dataConfig,
      loadingStatus: PsStatus.PROGRESS_LOADING,
      primaryKey: primaryKey,
      mapKey: mapKey,
      paramKey: paramKey,
      serverRequestCallback: () => _psApiService.getShopList(
        requestBodyHolder.toMap(),
        limit,
        offset,
      ),
    );
  }

  @override
  Future<dynamic> postData({
    required PsHolder<dynamic>? requestBodyHolder,
    required RequestPathHolder? requestPathHolder,
  }) async {
    final PsResource<ApiStatus> _resource =
        await _psApiService.postTouchCount(requestBodyHolder!.toMap(), requestPathHolder?.loginUserId ?? 'nologinuser', requestPathHolder?.languageCode ?? '');
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
