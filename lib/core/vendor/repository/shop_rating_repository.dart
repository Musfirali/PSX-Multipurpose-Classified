import 'dart:async';
import 'package:sembast/sembast.dart';
import '../api/common/ps_resource.dart';
import '../api/ps_api_service.dart';
import '../db/common/ps_data_source_manager.dart';
import '../db/shop_rating_dao.dart';
import '../viewobject/common/ps_holder.dart';
import '../viewobject/holder/request_path_holder.dart';
import '../viewobject/shop_rating.dart';
import 'Common/ps_repository.dart';

class ShopRatingRepository extends PsRepository {
  ShopRatingRepository(
      {required PsApiService psApiService,
      required ShopRatingDao shopRatingDao}) {
    _psApiService = psApiService;
    _shopRatingDao = shopRatingDao;
  }

  String primaryKey = 'id';
  late PsApiService _psApiService;
  late ShopRatingDao _shopRatingDao;

  Future<dynamic> insert(ShopRating shopRating) async {
    return _shopRatingDao.insert(primaryKey, shopRating);
  }

  Future<dynamic> update(ShopRating shopRating) async {
    return _shopRatingDao.update(shopRating);
  }

  Future<dynamic> delete(ShopRating shopRating) async {
    return _shopRatingDao.delete(shopRating);
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
    final RequestPathHolder holder = requestPathHolder!;
    await startResourceSinkingForList(
      dao: _shopRatingDao,
      streamController: streamController,
      finder: Finder(filter: Filter.equals('shop_id', holder.shopId)),
      dataConfig: dataConfig,
      serverRequestCallback: () =>
          _psApiService.getShopRatingList(holder.shopId!, limit, offset),
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
    final RequestPathHolder holder = requestPathHolder!;
    await startResourceSinkingForNextList(
      dao: _shopRatingDao,
      streamController: streamController,
      finder: Finder(filter: Filter.equals('shop_id', holder.shopId)),
      dataConfig: dataConfig,
      serverRequestCallback: () =>
          _psApiService.getShopRatingList(holder.shopId!, limit, offset),
    );
  }

  @override
  Future<dynamic> postData({
    required PsHolder<dynamic>? requestBodyHolder,
    required RequestPathHolder? requestPathHolder,
  }) async {
    // final PsResource<ShopRating> _resource =
    //     await _psApiService.postShopRating(requestBodyHolder!.toMap());
    // if (_resource.status == PsStatus.SUCCESS) {
    //   shopRatingListStream.sink
    //       .add(await _shopRatingDao.getAll(status: PsStatus.SUCCESS));
    //   return _resource;
    // } else {
    //   final Completer<PsResource<ShopRating>> completer =
    //       Completer<PsResource<ShopRating>>();
    //   completer.complete(_resource);
    //   shopRatingListStream.sink
    //       .add(await _shopRatingDao.getAll(status: PsStatus.SUCCESS));
    //   return completer.future;
    // }
  }
  }
