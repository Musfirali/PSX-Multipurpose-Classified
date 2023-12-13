// ignore_for_file: unnecessary_null_comparison

import 'dart:async';

import 'package:sembast/sembast.dart';

import '../api/common/ps_resource.dart';
import '../api/common/ps_status.dart';
import '../api/ps_api_service.dart';
import '../db/common/ps_data_source_manager.dart';
import '../db/favourite_product_dao.dart';
import '../db/follower_item_dao.dart';
import '../db/product_dao.dart';
import '../db/product_map_dao.dart';
import '../db/related_product_dao.dart';
import '../viewobject/api_status.dart';
import '../viewobject/common/ps_holder.dart';
import '../viewobject/favourite_product.dart';
import '../viewobject/follower_item.dart';
import '../viewobject/holder/mark_sold_out_item_parameter_holder.dart';
import '../viewobject/holder/request_path_holder.dart';
import '../viewobject/product.dart';
import '../viewobject/product_map.dart';
import '../viewobject/related_product.dart';
import 'Common/ps_repository.dart';

class ProductRepository extends PsRepository {
  ProductRepository(
      {required PsApiService psApiService, required ProductDao productDao}) {
    _psApiService = psApiService;
    _productDao = productDao;
  }
  String primaryKey = 'id';
  String mapKey = 'map_key';
  String addedUserIdKey = 'added_user_id';
  String collectionIdKey = 'collection_id';
  String mainProductId =
      'main_product_id'; //for main product id of related products
  late PsApiService _psApiService;
  late ProductDao _productDao;

  void sinkItemDetailStream(
      StreamController<PsResource<dynamic>>? itemDetailStream,
      PsResource<Product?> data) {
    if (data != null) {
      itemDetailStream!.sink.add(data);
    }
  }

  Future<dynamic> insert(Product? product) async {
    return _productDao.insert(primaryKey, product!);
  }

  Future<dynamic> update(Product product) async {
    return _productDao.update(product);
  }

  Future<dynamic> delete(Product product) async {
    return _productDao.delete(product);
  }

  Future<dynamic> getItemFromDB(String? itemId,
      StreamController<dynamic> itemStream, PsStatus status) async {
    final Finder finder = Finder(filter: Filter.equals(primaryKey, itemId));

    itemStream.sink
        .add(await _productDao.getOne(finder: finder, status: status));
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
    final ProductMapDao productMapDao = ProductMapDao.instance;

    await startResourceSinkingForListWithMap<ProductMap>(
      mapObject: ProductMap(),
      mapDao: productMapDao,
      dao: _productDao,
      streamController: streamController,
      dataConfig: dataConfig,
      primaryKey: primaryKey,
      mapKey: mapKey,
      paramKey: paramKey,
      serverRequestCallback: () => _psApiService.getProductList(
        requestBodyHolder.toMap(),
        requestPathHolder!.loginUserId,
        requestPathHolder.languageCode,
        limit,
        offset,
      ),
    );

    await subscribeDataListWithMap(
        dataListStream: streamController,
        primaryKey: primaryKey,
        mapKey: mapKey,
        mapObject: ProductMap(),
        paramKey: paramKey,
        dao: _productDao,
        statusOnDataChange: PsStatus.PROGRESS_LOADING,
        dataConfig: dataConfig,
        mapDao: productMapDao);
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
    final ProductMapDao productMapDao = ProductMapDao.instance;

    await startResourceSinkingForNextListWithMap<ProductMap>(
      mapObject: ProductMap(),
      mapDao: productMapDao,
      dao: _productDao,
      loadingStatus: PsStatus.PROGRESS_LOADING,
      streamController: streamController,
      dataConfig: dataConfig,
      primaryKey: primaryKey,
      mapKey: mapKey,
      paramKey: paramKey,
      serverRequestCallback: () => _psApiService.getProductList(
        requestBodyHolder.toMap(),
        requestPathHolder!.loginUserId,
        requestPathHolder.languageCode,
        limit,
        offset,
      ),
    );
    await subscribeDataListWithMap(
        dataListStream: streamController,
        primaryKey: primaryKey,
        mapKey: mapKey,
        mapObject: ProductMap(),
        paramKey: paramKey,
        dao: _productDao,
        statusOnDataChange: PsStatus.PROGRESS_LOADING,
        dataConfig: dataConfig,
        mapDao: productMapDao);
  }

  @override
  Future<void> loadData({
    required StreamController<PsResource<dynamic>> streamController,
    PsHolder<dynamic>? requestBodyHolder,
    RequestPathHolder? requestPathHolder,
    required DataConfiguration dataConfig,
  }) async {
    final Finder finder =
        Finder(filter: Filter.equals(primaryKey, requestPathHolder?.itemId));

    await startResourceSinkingForOne(
      dao: _productDao,
      streamController: streamController,
      finder: finder,
      dataConfig: dataConfig,
      serverRequestCallback: () async {
        return _psApiService.getItemDetail(
            requestPathHolder?.itemId,
            requestPathHolder?.loginUserId,
            requestPathHolder?.languageCode ?? 'en');
      },
    );
  }

  Future<dynamic> deleteLocalProductCacheById(
      StreamController<PsResource<dynamic>>? itemDetailStream,
      String? itemId,
      String? loginUserId,
      bool isConnectedToInternet,
      PsStatus status,
      {bool isLoadFromServer = true}) async {
    // Prepare Holder and Map Dao
    final Finder finder = Finder(filter: Filter.equals(primaryKey, itemId));

    await _productDao.deleteWithFinder(finder);

    sinkItemDetailStream(
        itemDetailStream, await _productDao.getOne(finder: finder));
  }

  Future<dynamic> deleteLocalProductCacheByUserId(
      StreamController<PsResource<dynamic>>? itemDetailStream,
      String? loginUserId,
      String? addedUserId,
      bool isConnectedToInternet,
      PsStatus status,
      {bool isLoadFromServer = true}) async {
    // Prepare Holder and Map Dao
    final Finder finder =
        Finder(filter: Filter.equals(addedUserIdKey, addedUserId));

    await _productDao.deleteWithFinder(finder);

    sinkItemDetailStream(
        itemDetailStream, await _productDao.getOne(finder: finder));
  }

  Future<dynamic> getItemDetailForFav(
      StreamController<PsResource<Product>>? productDetailStream,
      String? itemId,
      String? loginUserId,
      String? languageCode,
      bool isConnectedToInternet,
      PsStatus status,
      {bool isLoadFromServer = true}) async {
    final Finder finder = Finder(filter: Filter.equals(primaryKey, itemId));

    if (isConnectedToInternet) {
      final PsResource<Product> _resource = await _psApiService.getItemDetail(
          itemId, loginUserId, languageCode ?? 'en');

      if (_resource.status == PsStatus.SUCCESS) {
        // await _productDao.deleteWithFinder(finder);
        await _productDao.insert(primaryKey, _resource.data!);
        sinkItemDetailStream(
            productDetailStream, await _productDao.getOne(finder: finder));
      }
    }
  }

  Future<dynamic> getAllFavouritesList(
    StreamController<PsResource<List<dynamic>>>? favouriteProductListStream,
    String? loginUserId,
    String? headerToken,
    String? languageCode,
    int limit,
    int? offset,
    PsStatus status,
    DataConfiguration dataConfig,
  ) async {
    final FavouriteProductDao favouriteProductDao =
        FavouriteProductDao.instance;
    await startResourceSinkingForListWithJoin<FavouriteProduct>(
      dao: _productDao,
      primaryKey: primaryKey,
      mapKey: mapKey,
      mapObject: FavouriteProduct(),
      streamController: favouriteProductListStream,
      mapDao: favouriteProductDao,
      dataConfig: dataConfig,
      serverRequestCallback: () => _psApiService.getFavouritesList(
          loginUserId, headerToken!, languageCode ?? 'en', limit, offset),
    );
    await subscribeDataListWithJoin(
      dataListStream: favouriteProductListStream!,
      primaryKey: primaryKey,
      mapKey: mapKey,
      mapObject: FavouriteProduct(),
      dao: _productDao,
      statusOnDataChange: PsStatus.PROGRESS_LOADING,
      dataConfig: dataConfig,
      mapDao: favouriteProductDao,
    );
  }

  Future<dynamic> getNextPageFavouritesList(
    StreamController<PsResource<List<dynamic>>>? favouriteProductListStream,
    String? loginUserId,
    String? headerToken,
    String? languageCode,
    int limit,
    int? offset,
    PsStatus status,
    DataConfiguration dataConfig,
  ) async {
    final FavouriteProductDao favouriteProductDao =
        FavouriteProductDao.instance;
    await startResourceSinkingForNextListWithJoin<FavouriteProduct>(
      dao: _productDao,
      primaryKey: primaryKey,
      mapKey: mapKey,
      mapObject: FavouriteProduct(),
      streamController: favouriteProductListStream,
      loadingStatus: PsStatus.PROGRESS_LOADING,
      mapDao: favouriteProductDao,
      dataConfig: dataConfig,
      serverRequestCallback: () => _psApiService.getFavouritesList(
        loginUserId,
        headerToken!,
        languageCode ?? 'en',
        limit,
        offset,
      ),
    );
    await subscribeDataListWithJoin(
      dataListStream: favouriteProductListStream!,
      primaryKey: primaryKey,
      mapKey: mapKey,
      mapObject: FavouriteProduct(),
      dao: _productDao,
      statusOnDataChange: PsStatus.PROGRESS_LOADING,
      dataConfig: dataConfig,
      mapDao: favouriteProductDao,
    );
  }

  Future<PsResource<Product>> postFavourite(
      Map<dynamic, dynamic> jsonMap,
      bool isConnectedToInternet,
      PsStatus status,
      String loginUserId,
      String headerToken,
      String? languageCode,
      {bool isLoadFromServer = true}) async {
    final PsResource<Product> _resource = await _psApiService.postFavourite(
        jsonMap, loginUserId, headerToken, languageCode ?? 'en');
    if (_resource.status == PsStatus.SUCCESS) {
      update(_resource.data!);
      return _resource;
    } else {
      final Completer<PsResource<Product>> completer =
          Completer<PsResource<Product>>();
      completer.complete(_resource);
      return completer.future;
    }
  }

  // Future<PsResource<ApiStatus>> postTouchCount(Map<dynamic, dynamic> jsonMap,
  //     bool isConnectedToInternet, PsStatus status,
  //     {bool isLoadFromServer = true}) async {
  //   final PsResource<ApiStatus> _resource =
  //       await _psApiService.postTouchCount(jsonMap);
  //   if (_resource.status == PsStatus.SUCCESS) {
  //     return _resource;
  //   } else {
  //     final Completer<PsResource<ApiStatus>> completer =
  //         Completer<PsResource<ApiStatus>>();
  //     completer.complete(_resource);
  //     return completer.future;
  //   }
  // }

  @override
  Future<PsResource<ApiStatus>> postData({
    PsHolder<dynamic>? requestBodyHolder,
    RequestPathHolder? requestPathHolder,
  }) async {
    final PsResource<ApiStatus> _resource = await _psApiService.postTouchCount(
        requestBodyHolder!.toMap(),
        requestPathHolder?.loginUserId ?? '',
        requestPathHolder?.languageCode ?? 'en');
    if (_resource.status == PsStatus.SUCCESS) {
      return _resource;
    } else {
      final Completer<PsResource<ApiStatus>> completer =
          Completer<PsResource<ApiStatus>>();
      completer.complete(_resource);
      return completer.future;
    }
  }

  Future<dynamic> getRelatedProductList(
    StreamController<PsResource<List<dynamic>>>? relatedProductListStream,
    String productId,
    String categoryId,
    String loginUserId,
    String? languageCode,
    bool isConnectedToInternet,
    int limit,
    int? offset,
    DataConfiguration dataConfig,
  ) async {
    final RelatedProductDao relatedProductDao = RelatedProductDao.instance;

    await startResourceSinkingForListWithJoin<RelatedProduct>(
      dao: _productDao,
      primaryKey: primaryKey,
      mapKey: mapKey,
      mapObject: RelatedProduct(),
      streamController: relatedProductListStream,
      mapDao: relatedProductDao,
      dataConfig: dataConfig,
      serverRequestCallback: () => _psApiService.getRelatedProductList(
          productId,
          categoryId,
          loginUserId,
          languageCode ?? 'en',
          limit,
          offset),
    );
  }

  Future<dynamic> getNextPageRelatedProductList(
    StreamController<PsResource<List<dynamic>>>? relatedProductListStream,
    String productId,
    String categoryId,
    String loginUserId,
    String? languageCode,
    int limit,
    int? offset,
    PsStatus status,
    DataConfiguration dataConfig,
  ) async {
    final RelatedProductDao relatedProductDao = RelatedProductDao.instance;
    await startResourceSinkingForNextListWithJoin<RelatedProduct>(
      dao: _productDao,
      primaryKey: primaryKey,
      mapKey: mapKey,
      mapObject: RelatedProduct(),
      streamController: relatedProductListStream,
      mapDao: relatedProductDao,
      dataConfig: dataConfig,
      serverRequestCallback: () => _psApiService.getRelatedProductList(
          productId,
          categoryId,
          loginUserId,
          languageCode ?? 'en',
          limit,
          offset),
    );
  }

  Future<dynamic> getAllItemListFromFollower(
    StreamController<PsResource<List<dynamic>>>? itemListFromFollowersStream,
    Map<dynamic, dynamic> jsonMap,
    String? loginUserId,
    int limit,
    int? offset,
    PsStatus status,
    String languageCode,
    DataConfiguration dataConfig,
  ) async {
    final FollowerItemDao followerItemDao = FollowerItemDao.instance;
    await startResourceSinkingForListWithJoin<FollowerItem>(
      dao: _productDao,
      primaryKey: primaryKey,
      mapKey: mapKey,
      mapObject: FollowerItem(),
      streamController: itemListFromFollowersStream,
      mapDao: followerItemDao,
      dataConfig: dataConfig,
      serverRequestCallback: () => _psApiService.getAllItemListFromFollower(
          jsonMap, loginUserId, limit, offset, languageCode),
    );
    await subscribeDataListWithJoin(
      dataListStream: itemListFromFollowersStream!,
      primaryKey: primaryKey,
      mapKey: mapKey,
      mapObject: FollowerItem(),
      dao: _productDao,
      statusOnDataChange: PsStatus.PROGRESS_LOADING,
      dataConfig: dataConfig,
      mapDao: followerItemDao,
    );
  }

  Future<dynamic> getNextPageItemListFromFollower(
    StreamController<PsResource<List<dynamic>>>? itemListFromFollowersStream,
    Map<dynamic, dynamic> jsonMap,
    String loginUserId,
    int limit,
    int? offset,
    PsStatus status,
    String languageCode,
    DataConfiguration dataConfig,
  ) async {
    final FollowerItemDao followerItemDao = FollowerItemDao.instance;
    await startResourceSinkingForNextListWithJoin<FollowerItem>(
      dao: _productDao,
      primaryKey: primaryKey,
      mapKey: mapKey,
      mapObject: FollowerItem(),
      streamController: itemListFromFollowersStream,
      mapDao: followerItemDao,
      dataConfig: dataConfig,
      serverRequestCallback: () => _psApiService.getAllItemListFromFollower(
          jsonMap, loginUserId, limit, offset, languageCode),
    );
    await subscribeDataListWithJoin(
      mapKey: mapKey,
      dataListStream: itemListFromFollowersStream!,
      primaryKey: primaryKey,
      mapObject: FollowerItem(),
      dao: _productDao,
      statusOnDataChange: PsStatus.PROGRESS_LOADING,
      dataConfig: dataConfig,
      mapDao: followerItemDao,
    );
  }

  // Future<dynamic> getItemListByUserId(
  //   StreamController<PsResource<List<Product>>>? productListStream,
  //   String? loginUserId,
  //   int limit,
  //   int? offset,
  //   PsStatus status,
  //   ProductParameterHolder holder,
  //   DataConfiguration dataConfig,
  // ) async {
  //   // Prepare Holder and Map Dao
  //   final String paramKey = holder.getParamKey();
  //   final ProductMapDao productMapDao = ProductMapDao.instance;

  //   startResourceSinkingForListWithMap<ProductMap>(
  //     mapObject: ProductMap(),
  //     mapDao: productMapDao,
  //     dao: _productDao,
  //     streamController: productListStream,
  //     dataConfig: dataConfig,
  //     primaryKey: primaryKey,
  //     mapKey: mapKey,
  //     paramKey: paramKey,
  //     serverRequestCallback: () => _psApiService.getProductList(
  //       holder.toMap(),
  //       loginUserId,
  //       limit,
  //       offset,
  //     ),
  //   );
  // }

  // Future<dynamic> getNextItemListByUserId(
  //   StreamController<PsResource<List<Product>>>? productListStream,
  //   String? loginUserId,
  //   int limit,
  //   int? offset,
  //   PsStatus status,
  //   ProductParameterHolder holder,
  //   DataConfiguration dataConfig,
  // ) async {
  //   // Prepare Holder and Map Dao
  //   final String paramKey = holder.getParamKey();
  //   final ProductMapDao productMapDao = ProductMapDao.instance;

  //   startResourceSinkingForNextListWithMap<ProductMap>(
  //     mapObject: ProductMap(),
  //     mapDao: productMapDao,
  //     dao: _productDao,
  //     streamController: productListStream,
  //     dataConfig: dataConfig,
  //     primaryKey: primaryKey,
  //     mapKey: mapKey,
  //     paramKey: paramKey,
  //     serverRequestCallback: () => _psApiService.getProductList(
  //       holder.toMap(),
  //       loginUserId,
  //       limit,
  //       offset,
  //     ),
  //   );
  // }

  /// Mark As sold
  Future<dynamic> markSoldOutItem(
    StreamController<PsResource<Product>>? markSoldOutStream,
    String? loginUserId,
    String headerToken,
    String? languageCode,
    bool isConnectedToInternet,
    PsStatus status,
    MarkSoldOutItemParameterHolder? holder,
    DataConfiguration dataConfig,
  ) async {
    startResourceSinkingForOne(
        dao: _productDao,
        streamController: markSoldOutStream,
        dataConfig: dataConfig,
        serverRequestCallback: () => _psApiService.markSoldOutItem(
            holder!.toMap(), loginUserId, headerToken, languageCode ?? 'en'));

    // sinkItemDetailStream(
    //     markSoldOutStream, await _productDao.getOne(status: status));

    // if (isConnectedToInternet) {
    //   final PsResource<Product> _resource =
    //       await _psApiService.markSoldOutItem(holder!.toMap(), loginUserId);

    //   if (_resource.status == PsStatus.SUCCESS) {
    //     //await _productDao.deleteAll();
    //     await _productDao.update(_resource.data!);
    //     sinkItemDetailStream(markSoldOutStream, await _productDao.getOne());
    //   }
    // }
  }

  Future<PsResource<Product>> postItemEntry(
      Map<dynamic, dynamic> jsonMap,
      String loginUserId,
      String headerToken,
      String? languageCode,
      PsStatus status,
      {bool isLoadFromServer = true}) async {
    final PsResource<Product> _resource = await _psApiService.postItemEntry(
        jsonMap, loginUserId, headerToken, languageCode ?? 'en');

    if (_resource.status == PsStatus.SUCCESS) {
      await insert(_resource.data);
      return _resource;
    } else {
      final Completer<PsResource<Product>> completer =
          Completer<PsResource<Product>>();
      completer.complete(_resource);
      return completer.future;
    }
  }

  ///
  /// For Delete item
  ///
  Future<PsResource<ApiStatus>> userDeleteItem(
      Map<dynamic, dynamic> jsonMap,
      String loginUserId,
      String itemId,
      String headerToken,
      String? languageCode,
      bool isConnectedToInternet,
      PsStatus status,
      {bool isLoadFromServer = true}) async {
    final PsResource<ApiStatus> _resource = await _psApiService.deleteItem(
        jsonMap, loginUserId, itemId, headerToken, languageCode ?? 'en');
    if (_resource.status == PsStatus.SUCCESS) {
      return _resource;
    } else {
      final Completer<PsResource<ApiStatus>> completer =
          Completer<PsResource<ApiStatus>>();
      completer.complete(_resource);
      return completer.future;
    }
  }

    /// Change Item Status
  Future<dynamic> changeItemStatus(
      Map<dynamic, dynamic> jsonMap,
      String loginUserId,
      String itemId,
      String headerToken,
      String? languageCode,
      bool isConnectedToInternet,
      PsStatus status,
      {bool isLoadFromServer = true}) async {
    final PsResource<Product> _resource = await _psApiService.changeItemStatus(
        jsonMap, loginUserId, headerToken, languageCode ?? 'en');

    if (_resource.status == PsStatus.SUCCESS) {
      // await insert(_resource.data);
      return _resource;
    } else {
      final Completer<PsResource<Product>> completer =
          Completer<PsResource<Product>>();
      completer.complete(_resource);
      return completer.future;
    }
  }
}
