import 'dart:async';

import '../api/common/ps_resource.dart';
import '../api/common/ps_status.dart';
import '../db/basket_dao.dart';
import '../db/common/ps_data_source_manager.dart';
import '../viewobject/basket.dart';
import '../viewobject/common/ps_holder.dart';
import '../viewobject/holder/request_path_holder.dart';
import 'Common/ps_repository.dart';

class BasketRepository extends PsRepository {
  BasketRepository({required BasketDao basketDao}) {
    _basketDao = basketDao;
  }

  String primaryKey = 'id';
  late BasketDao _basketDao;

  Future<dynamic> insert(Basket basket) async {
    return _basketDao.insert(primaryKey, basket);
  }

  Future<dynamic> update(Basket basket) async {
    return _basketDao.update(basket);
  }

  Future<dynamic> delete(Basket basket) async {
    return _basketDao.delete(basket);
  }

  Future<dynamic> addBasket(
      StreamController<PsResource<List<dynamic>>> basketListStream,
      PsStatus status,
      Basket basket) async {
    // final Finder finder =
    //     Finder(filter: Filter.equals('shop_id', basket.shopId));
    await insert(basket);
    basketListStream.sink.add(await _basketDao.getAll(status: status));
  }

  // Future<dynamic> addAllBasketByShopId(
  //     StreamController<PsResource<List<Basket>>> basketListStream,
  //     PsStatus status,
  //     Basket basket) async {
  //   await _basketDao.insert(primaryKey, basket);
  //   basketListStream.sink.add(await _basketDao.getAll(status: status));
  // }

  Future<dynamic> updateBasket(
      StreamController<PsResource<List<dynamic>>> basketListStream,
      Basket product) async {
    await update(product);
    basketListStream.sink
        .add(await _basketDao.getAll(status: PsStatus.SUCCESS));
  }

  Future<dynamic> deleteBasketByProduct(
      StreamController<PsResource<List<dynamic>>> basketListStream,
      Basket product) async {
    await delete(product);
    basketListStream.sink
        .add(await _basketDao.getAll(status: PsStatus.SUCCESS));
  }

  Future<dynamic> deleteWholeBasketList(
      StreamController<PsResource<List<dynamic>>> basketListStream) async {
    await _basketDao.deleteAll();
  }

  @override
  Future<void> loadDataListFromDatabase({
    required StreamController<PsResource<List<dynamic>>> streamController,
    PsHolder<dynamic>? requestBodyHolder,
    RequestPathHolder? requestPathHolder,
  }) async {
    await startResourceSinkingForListFromDataBase(
      dao: _basketDao,
      streamController: streamController,
    );
    subscribeDataList(
        dataListStream: streamController,
        dao: _basketDao,
        statusOnDataChange: PsStatus.SUCCESS,
        dataConfig:
            DataConfiguration(dataSourceType: DataSourceType.FULL_CACHE));
  }
}
