import 'dart:async';

import '../api/common/ps_resource.dart';
import '../api/common/ps_status.dart';
import '../api/ps_api_service.dart';
import '../db/common/ps_data_source_manager.dart';
import '../db/rating_dao.dart';
import '../viewobject/common/ps_holder.dart';
import '../viewobject/holder/request_path_holder.dart';
import '../viewobject/rating.dart';
import 'Common/ps_repository.dart';

class RatingRepository extends PsRepository {
  RatingRepository(
      {required PsApiService psApiService, required RatingDao ratingDao}) {
    _psApiService = psApiService;
    _ratingDao = ratingDao;
  }

  String primaryKey = 'id';
  late PsApiService _psApiService;
  late RatingDao _ratingDao;

  Future<dynamic> insert(Rating rating) async {
    return _ratingDao.insert(primaryKey, rating);
  }

  Future<dynamic> update(Rating rating) async {
    return _ratingDao.update(rating);
  }

  Future<dynamic> delete(Rating rating) async {
    return _ratingDao.delete(rating);
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
      dao: _ratingDao,
      streamController: streamController,
      dataConfig: dataConfig,
      serverRequestCallback: () => _psApiService.getRatingList(
          requestBodyHolder!.toMap(),
          limit,
          offset,
          requestPathHolder!.loginUserId!,
          //requestPathHolder.headerToken!,
          requestPathHolder.languageCode ?? 'en'),
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
      dao: _ratingDao,
      streamController: streamController,
      dataConfig: dataConfig,
      loadingStatus: PsStatus.PROGRESS_LOADING,
      serverRequestCallback: () => _psApiService.getRatingList(
          requestBodyHolder!.toMap(),
          limit,
          offset,
          requestPathHolder!.loginUserId!,
          //requestPathHolder.headerToken!,
          requestPathHolder.languageCode ?? 'en'),
    );
  }

  @override
  Future<dynamic> postData({
    required PsHolder<dynamic>? requestBodyHolder,
    required RequestPathHolder? requestPathHolder,
  }) async {}

  Future<dynamic> postRating(
      StreamController<PsResource<dynamic>>? ratingListStream,
      Map<dynamic, dynamic> jsonMap,
      bool isConnectedToInternet,
      String loginUserId,
      String tokenHeader,
      PsStatus status,String languageCode,
      {bool isLoadFromServer = true}) async {
    final PsResource<Rating> _resource =
        await _psApiService.postRating(jsonMap, loginUserId, tokenHeader,languageCode);
    if (_resource.status == PsStatus.SUCCESS) {
      // await _ratingDao
      //     .deleteWithFinder(Finder(filter: Filter.equals(primaryKey,jsonMap['id'])));
      await _ratingDao.insert(primaryKey, _resource.data!);
    }

    final dynamic subscription = _ratingDao.getOneWithSubscription(
        status: PsStatus.SUCCESS,
        onDataUpdated: (Rating rating) {
          if (status != PsStatus.NOACTION) {
            print(status);
            ratingListStream?.sink.add(PsResource<Rating>(status, '', rating));
          } else {
            print('No Action');
          }
        });

    return subscription;
  }
}
