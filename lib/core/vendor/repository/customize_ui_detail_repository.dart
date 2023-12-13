import 'dart:async';

import 'package:sembast/sembast.dart';

import '../api/common/ps_resource.dart';
import '../api/ps_api_service.dart';
import '../db/common/ps_data_source_manager.dart';
import '../db/cutomize_ui_detail_dao.dart';
import '../viewobject/common/ps_holder.dart';
import '../viewobject/customize_ui_detail.dart';
import '../viewobject/holder/request_path_holder.dart';
import 'Common/ps_repository.dart';

class CustomizeUiDetailRepository extends PsRepository {
  CustomizeUiDetailRepository({
    required this.apiService,
    required this.customizeUiDetailDao,
  });

  late CustomizeUiDetailDao customizeUiDetailDao;
  late PsApiService apiService;

  Future<dynamic> insert(CustomizeUiDetail itemEntryField) async {
    return customizeUiDetailDao.insert('', itemEntryField);
  }

  Future<dynamic> update(CustomizeUiDetail itemEntryField) async {
    return customizeUiDetailDao.update(itemEntryField);
  }

  Future<dynamic> delete(CustomizeUiDetail itemEntryField) async {
    return customizeUiDetailDao.delete(itemEntryField);
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
      dao: customizeUiDetailDao,
      finder: Finder(
          filter:
              Filter.equals('core_keys_id', requestPathHolder!.coreKeyId)),
      streamController: streamController,
      dataConfig: dataConfig,
      serverRequestCallback: () => apiService.getCustomizeUiDetailList(
          requestPathHolder.coreKeyId!, limit, offset, requestPathHolder.loginUserId ?? 'nologinuser', requestPathHolder.languageCode ?? 'en'),
    );
  }
}
