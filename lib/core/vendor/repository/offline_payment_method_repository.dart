import 'dart:async';

import '../api/common/ps_resource.dart';
import '../api/common/ps_status.dart';
import '../api/ps_api_service.dart';
import '../db/common/ps_data_source_manager.dart';
import '../db/offline_payment_dao.dart';
import '../viewobject/common/ps_holder.dart';
import '../viewobject/holder/request_path_holder.dart';
import '../viewobject/offline_payment.dart';
import 'Common/ps_repository.dart';

class OfflinePaymentMethodRepository extends PsRepository {
  OfflinePaymentMethodRepository(
      {required PsApiService psApiService,
      required OfflinePaymentDao offlinePaymentMethodDao}) {
    _psApiService = psApiService;
    _offlinePaymentMethodDao = offlinePaymentMethodDao;
  }

  late PsApiService _psApiService;
  late OfflinePaymentDao _offlinePaymentMethodDao;
  final String _primaryKey = 'id';

  Future<dynamic> insert(OfflinePayment noti) async {
    return _offlinePaymentMethodDao.insert(_primaryKey, noti);
  }

  Future<dynamic> update(OfflinePayment noti) async {
    return _offlinePaymentMethodDao.update(noti);
  }

  Future<dynamic> delete(OfflinePayment noti) async {
    return _offlinePaymentMethodDao.delete(noti);
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
      dao: _offlinePaymentMethodDao,
      streamController: streamController,
      dataConfig: dataConfig,
      serverRequestCallback: () => _psApiService.getOfflinePaymentList(limit, offset, requestPathHolder?.loginUserId ?? 'nologinuser',requestPathHolder!.languageCode ?? 'en'),
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
      dao: _offlinePaymentMethodDao,
      streamController: streamController,
      dataConfig: dataConfig,
      loadingStatus: PsStatus.PROGRESS_LOADING,
      serverRequestCallback: () => _psApiService.getOfflinePaymentList(limit, offset, requestPathHolder?.loginUserId ?? 'nologinuser',requestPathHolder!.languageCode ?? 'en'),
    );
  }

  // Future<dynamic> getOfflinePaymentList(
  //     StreamController<PsResource<dynamic>> notiListStream,
  //     bool isConnectedToInternet,
  //     int limit,
  //     int? offset,
  //     PsStatus status,
  //     {bool isLoadFromServer = true}) async {
  //   notiListStream.sink
  //       .add(await _offlinePaymentMethodDao.getOne(status: status));

  //   if (isConnectedToInternet) {
  //     final PsResource<OfflinePaymentMethod> _resource =
  //         await _psApiService.getOfflinePaymentList(limit, offset);

  //     if (_resource.status == PsStatus.SUCCESS) {
  //       await _offlinePaymentMethodDao.deleteAll();
  //       _resource.data!.id = '1';
  //       await _offlinePaymentMethodDao.insert(_primaryKey, _resource.data!);
  //     } else {
  //       if (_resource.errorCode == PsConst.TOTALLY_NO_RECORD) {
  //         await _offlinePaymentMethodDao.deleteAll();
  //       }
  //     }
  //     notiListStream.sink.add(await _offlinePaymentMethodDao.getOne());
  //   }
  // }

  // Future<dynamic> getNextPageOfflinePaymentList(
  //     StreamController<PsResource<dynamic>> notiListStream,
  //     bool isConnectedToInternet,
  //     int limit,
  //     int? offset,
  //     PsStatus status,
  //     {bool isLoadFromServer = true}) async {
  //   notiListStream.sink
  //       .add(await _offlinePaymentMethodDao.getOne(status: status));

  //   if (isConnectedToInternet) {
  //     final PsResource<OfflinePaymentMethod> _resource =
  //         await _psApiService.getOfflinePaymentList(limit, offset);

  //     if (_resource.status == PsStatus.SUCCESS) {
  //       _offlinePaymentMethodDao
  //           .insert(_primaryKey, _resource.data!)
  //           .then((dynamic data) async {
  //         notiListStream.sink.add(await _offlinePaymentMethodDao.getOne());
  //       });
  //     } else {
  //       notiListStream.sink.add(await _offlinePaymentMethodDao.getOne());
  //     }
  //   }
  // }
}
