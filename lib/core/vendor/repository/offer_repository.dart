import 'dart:async';

import 'package:sembast/sembast.dart';

import '../api/common/ps_resource.dart';
import '../api/common/ps_status.dart';
import '../api/ps_api_service.dart';
import '../db/common/ps_data_source_manager.dart';
import '../db/offer_dao.dart';
import '../db/offer_map_dao.dart';
import '../viewobject/common/ps_holder.dart';
import '../viewobject/holder/request_path_holder.dart';
import '../viewobject/offer.dart';
import '../viewobject/offer_map.dart';
import 'Common/ps_repository.dart';

class OfferRepository extends PsRepository {
  OfferRepository(
      {required PsApiService psApiService, required OfferDao offerDao}) {
    _psApiService = psApiService;
    _offerDao = offerDao;
  }
  String primaryKey = 'id';
  String mapKey = 'map_key';
  late PsApiService _psApiService;
  late OfferDao _offerDao;

  void sinkOfferListStream(
      StreamController<PsResource<List<Offer?>>>? offerListStream,
      PsResource<List<Offer?>> dataList) {
    if (offerListStream != null) {
      offerListStream.sink.add(dataList);
    }
  }

  Future<dynamic> insert(Offer offer) async {
    return _offerDao.insert(primaryKey, offer);
  }

  Future<dynamic> update(Offer offer) async {
    return _offerDao.update(offer);
  }

  Future<dynamic> delete(Offer offer) async {
    return _offerDao.delete(offer);
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
    final OfferMapDao offerMapDao = OfferMapDao.instance;
    final Finder finder = Finder(filter: Filter.equals(mapKey, paramKey));
    await startResourceSinkingForListWithMap<OfferMap>(
      dao: _offerDao,
      primaryKey: primaryKey,
      finder: finder,
      mapKey: mapKey,
      paramKey: paramKey,
      mapObject: OfferMap(),
      streamController: streamController,
      mapDao: offerMapDao,
      dataConfig: dataConfig,
      serverRequestCallback: () => _psApiService.getOfferList(
          requestBodyHolder.toMap(),
          requestPathHolder?.loginUserId ?? 'nologinuser',
          requestPathHolder!.headerToken!,requestPathHolder.languageCode ?? 'en'),
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
    final OfferMapDao offerMapDao = OfferMapDao.instance;
    final Finder finder = Finder(filter: Filter.equals(mapKey, paramKey));

    await startResourceSinkingForNextListWithMap<OfferMap>(
      dao: _offerDao,
      primaryKey: primaryKey,
      finder: finder,
      mapKey: mapKey,
      paramKey: paramKey,
      mapObject: OfferMap(),
      streamController: streamController,
      mapDao: offerMapDao,
      dataConfig: dataConfig,
      loadingStatus: PsStatus.PROGRESS_LOADING,
      serverRequestCallback: () => _psApiService.getOfferList(
          requestBodyHolder.toMap(),
          requestPathHolder?.loginUserId ?? 'nologinuser',
          requestPathHolder!.headerToken!,requestPathHolder.languageCode ?? 'en'),
    );
  }

  // Future<dynamic> getOfferList(
  //     StreamController<PsResource<List<Offer>>>? offerListStream,
  //     bool isConnectedToInternet,
  //     int limit,
  //     int? offset,
  //     PsStatus status,
  //     OfferParameterHolder holder,
  //     {bool isLoadFromServer = true}) async {
  //   // Prepare Holder and Map Dao
  //   final String paramKey = holder.getParamKey();
  //   final OfferMapDao offerMapDao = OfferMapDao.instance;

  //   // Load from Db and Send to UI
  //   sinkOfferListStream(
  //       offerListStream,
  //       await _offerDao.getAllByMap(
  //           primaryKey, mapKey, paramKey, offerMapDao, OfferMap(),
  //           status: status));

  //   // Server Call
  //   if (isConnectedToInternet) {
  //     final PsResource<List<Offer>> _resource =
  //         await _psApiService.getOfferList(holder.toMap());

  //     print('Param Key $paramKey');
  //     if (_resource.status == PsStatus.SUCCESS) {
  //       // Create Map List
  //       final List<OfferMap> offerMapList = <OfferMap>[];
  //       int i = 0;
  //       for (Offer data in _resource.data!) {
  //         offerMapList.add(OfferMap(
  //             id: data.id! + paramKey,
  //             mapKey: paramKey,
  //             offerId: data.id,
  //             sorting: i++,
  //             addedDate: '2020'));
  //       }

  //       // Delete and Insert Map Dao
  //       print('Delete Key $paramKey');
  //       await offerMapDao
  //           .deleteWithFinder(Finder(filter: Filter.equals(mapKey, paramKey)));
  //       print('Insert All Key $paramKey');
  //       await offerMapDao.insertAll(primaryKey, offerMapList);

  //       // Insert Offer
  //       await _offerDao.insertAll(primaryKey, _resource.data!);
  //     } else {
  //       if (_resource.errorCode == PsConst.TOTALLY_NO_RECORD) {
  //         // Delete and Insert Map Dao
  //         await offerMapDao.deleteWithFinder(
  //             Finder(filter: Filter.equals(mapKey, paramKey)));
  //       }
  //     }
  //     // Load updated Data from Db and Send to UI
  //     sinkOfferListStream(
  //         offerListStream,
  //         await _offerDao.getAllByMap(
  //             primaryKey, mapKey, paramKey, offerMapDao, OfferMap()));
  //   }
  // }

  // Future<dynamic> getNextPageOfferList(
  //     StreamController<PsResource<List<Offer>>>? offerListStream,
  //     bool isConnectedToInternet,
  //     int limit,
  //     int? offset,
  //     PsStatus status,
  //     OfferParameterHolder holder,
  //     {bool isLoadFromServer = true}) async {
  //   final String paramKey = holder.getParamKey();
  //   final OfferMapDao offerMapDao = OfferMapDao.instance;
  //   // Load from Db and Send to UI
  //   sinkOfferListStream(
  //       offerListStream,
  //       await _offerDao.getAllByMap(
  //           primaryKey, mapKey, paramKey, offerMapDao, OfferMap(),
  //           status: status));
  //   if (isConnectedToInternet) {
  //     final PsResource<List<Offer>> _resource =
  //         await _psApiService.getOfferList(holder.toMap());

  //     if (_resource.status == PsStatus.SUCCESS) {
  //       // Create Map List
  //       final List<OfferMap> offerMapList = <OfferMap>[];
  //       final PsResource<List<OfferMap>> existingMapList = await offerMapDao
  //           .getAll(finder: Finder(filter: Filter.equals(mapKey, paramKey)));

  //       int i = 0;
  //       i = existingMapList.data!.length + 1;
  //       for (Offer data in _resource.data!) {
  //         offerMapList.add(OfferMap(
  //             id: data.id! + paramKey,
  //             mapKey: paramKey,
  //             offerId: data.id,
  //             sorting: i++,
  //             addedDate: '2019'));
  //       }

  //       await offerMapDao.insertAll(primaryKey, offerMapList);

  //       // Insert Offer
  //       await _offerDao.insertAll(primaryKey, _resource.data!);
  //     }
  //     sinkOfferListStream(
  //         offerListStream,
  //         await _offerDao.getAllByMap(
  //             primaryKey, mapKey, paramKey, offerMapDao, OfferMap()));
  //   }
  // }
}
