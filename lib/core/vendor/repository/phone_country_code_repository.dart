import 'dart:async';

import '../api/common/ps_resource.dart';
import '../api/common/ps_status.dart';
import '../api/ps_api_service.dart';
import '../db/common/ps_data_source_manager.dart';
import '../db/phone_country_code_dao.dart';
import '../viewobject/common/ps_holder.dart';
import '../viewobject/holder/request_path_holder.dart';
import '../viewobject/phone_country_code.dart';
import 'Common/ps_repository.dart';

class PhoneCountryCodeRepository extends PsRepository {
  PhoneCountryCodeRepository(
      {required PsApiService psApiService, 
      required PhoneCountryCodeDao phoneCountryCodeDao}) {
    _psApiService = psApiService;
    _phoneCountryCodeDao = phoneCountryCodeDao;
  }

  String primaryKey = 'id';
  late PsApiService _psApiService;
  late PhoneCountryCodeDao _phoneCountryCodeDao;

  Future<dynamic> insert(PhoneCountryCode phoneCoutryCode) async {
    return _phoneCountryCodeDao.insert(primaryKey, phoneCoutryCode);
  }

  Future<dynamic> update(PhoneCountryCode phoneCoutryCode) async {
    return _phoneCountryCodeDao.update(phoneCoutryCode);
  }

  Future<dynamic> delete(PhoneCountryCode phoneCoutryCode) async {
    return _phoneCountryCodeDao.delete(phoneCoutryCode);
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
      dao: _phoneCountryCodeDao,
      streamController: streamController,
      dataConfig: dataConfig,
      serverRequestCallback: () => _psApiService.getPhoneCountryCode(
        requestBodyHolder!.toMap(),
        limit,
        offset,
        requestPathHolder?.loginUserId ?? 'nologinuser',requestPathHolder!.languageCode ?? 'en'),
    );

    await subscribeDataList(
      dataListStream: streamController,
      dao: _phoneCountryCodeDao,
      statusOnDataChange: PsStatus.PROGRESS_LOADING,
      dataConfig: dataConfig,
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
      dao: _phoneCountryCodeDao,
      streamController: streamController,
      loadingStatus: PsStatus.PROGRESS_LOADING,
      dataConfig: dataConfig,
      serverRequestCallback: () => _psApiService.getPhoneCountryCode(
        requestBodyHolder!.toMap(),
        limit,
        offset,
        requestPathHolder?.loginUserId ?? 'nologinuser',requestPathHolder!.languageCode ?? 'en'),
    );
  }
}
