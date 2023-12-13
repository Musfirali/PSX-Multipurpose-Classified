import 'dart:async';

import '../api/common/ps_resource.dart';
import '../api/common/ps_status.dart';
import '../api/ps_api_service.dart';
import '../db/common/ps_data_source_manager.dart';
import '../db/get_in_touch_dao.dart';
import '../viewobject/common/ps_holder.dart';
import '../viewobject/contact_us_message.dart';
import '../viewobject/holder/request_path_holder.dart';

import 'Common/ps_repository.dart';

class ContactUsRepository extends PsRepository {
  ContactUsRepository({
    required PsApiService psApiService,
    required GetInTouchDao getInTouchDao,
  }) {
    _psApiService = psApiService;
    _getInTouchDao = getInTouchDao;

  }

  late PsApiService _psApiService;
  late GetInTouchDao _getInTouchDao;

  @override
  Future<void> loadData({
    required StreamController<PsResource<dynamic>> streamController,
    PsHolder<dynamic>? requestBodyHolder,
    RequestPathHolder? requestPathHolder,
    required DataConfiguration dataConfig,
  }) async {
    await startResourceSinkingForOne(
      dao: _getInTouchDao,
      streamController: streamController,
      dataConfig: dataConfig,
      serverRequestCallback: () => _psApiService
          .getGetInTouchData(requestPathHolder?.loginUserId ?? 'nologinuser',requestPathHolder!.languageCode ?? 'en'),
    );
  }

  @override
  Future<PsResource<ContactUsMessage>> postData({
    PsHolder<dynamic>? requestBodyHolder,
    RequestPathHolder? requestPathHolder,
  }) async {
    final PsResource<ContactUsMessage> _resource =
        await _psApiService.postContactUs(requestBodyHolder!.toMap(), requestPathHolder?.loginUserId ?? 'nologinuser',requestPathHolder!.languageCode ?? 'en');
    if (_resource.status == PsStatus.SUCCESS) {
      return _resource;
    } else {
      final Completer<PsResource<ContactUsMessage>> completer =
          Completer<PsResource<ContactUsMessage>>();
      completer.complete(_resource);
      return completer.future;
    }
  }
}
