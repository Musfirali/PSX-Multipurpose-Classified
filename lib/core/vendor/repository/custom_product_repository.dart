import 'dart:async';

import '../api/common/ps_resource.dart';
import '../api/common/ps_status.dart';
import '../api/ps_api_service.dart';
import '../db/common/ps_data_source_manager.dart';
import '../db/custom_product_dao.dart';
import '../viewobject/common/ps_holder.dart';
import '../viewobject/custom_product.dart';
import '../viewobject/holder/request_path_holder.dart';
import 'Common/ps_repository.dart';

class CProductRepository extends PsRepository {
  CProductRepository({
    required this.apiService,
    required this.cProductDao,
  });
  late PsApiService apiService;
  late CProductDao cProductDao;

  Future<dynamic> insert(CProduct cProduct) async {
    return cProductDao.insert('', cProduct);
  }

  Future<dynamic> update(CProduct cProduct) async {
    return cProductDao.update(cProduct);
  }

  Future<dynamic> delete(CProduct cProduct) async {
    return cProductDao.delete(cProduct);
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
      dao: cProductDao,
      streamController: streamController,
      dataConfig: dataConfig,
      serverRequestCallback: () =>
          apiService.getCustomProductList(limit, offset),
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
      dao: cProductDao,
      streamController: streamController,
      dataConfig: dataConfig,
      loadingStatus: PsStatus.PROGRESS_LOADING,
      serverRequestCallback: () =>
          apiService.getCustomProductList(limit, offset),
    );
  }
}
