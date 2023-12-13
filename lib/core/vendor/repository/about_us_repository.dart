import 'dart:async';
import '../api/common/ps_resource.dart';
import '../api/ps_api_service.dart';
import '../db/about_us_dao.dart';
import '../db/common/ps_data_source_manager.dart';
import '../viewobject/about_us.dart';
import '../viewobject/common/ps_holder.dart';
import '../viewobject/holder/request_path_holder.dart';
import 'Common/ps_repository.dart';

class AboutUsRepository extends PsRepository {
  AboutUsRepository(
      {required PsApiService psApiService, required AboutUsDao aboutUsDao}) {
    _psApiService = psApiService;
    _aboutUsDao = aboutUsDao;
  }

  String primaryKey = 'id';
  late PsApiService _psApiService;
  late AboutUsDao _aboutUsDao;

  Future<dynamic> insert(AboutUs aboutUs) async {
    return _aboutUsDao.insert(primaryKey, aboutUs);
  }

  Future<dynamic> update(AboutUs aboutUs) async {
    return _aboutUsDao.update(aboutUs);
  }

  Future<dynamic> delete(AboutUs aboutUs) async {
    return _aboutUsDao.delete(aboutUs);
  }

  // @override
  // Future<void> loadDataList({
  //   required StreamController<PsResource<List<dynamic>>> streamController,
  //   required int limit,
  //   required int offset,
  //   PsHolder<dynamic>? requestBodyHolder,
  //   RequestPathHolder? requestPathHolder,
  //   required DataConfiguration dataConfig,
  // }) async {
  //   await startResourceSinkingForList(
  //     dao: _aboutUsDao,
  //     streamController: streamController,
  //     dataConfig: dataConfig,
  //     serverRequestCallback: () => _psApiService
  //         .getAboutUsDataList(requestPathHolder?.loginUserId ?? 'nologinuser'),
  //   );
  // }

  @override
  Future<void> loadData({
    required StreamController<PsResource<dynamic>> streamController,
    PsHolder<dynamic>? requestBodyHolder,
    RequestPathHolder? requestPathHolder,
    required DataConfiguration dataConfig,
  }) async {
    await startResourceSinkingForOne(
      dao: _aboutUsDao,
      streamController: streamController,
      dataConfig: dataConfig,
      serverRequestCallback: () => _psApiService
          .getAboutUsData(requestPathHolder?.loginUserId ?? 'nologinuser',requestPathHolder!.languageCode ?? 'en'),
    );
  }
}
