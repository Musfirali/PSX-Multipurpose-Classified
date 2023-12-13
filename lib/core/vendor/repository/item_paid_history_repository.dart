import 'dart:async';

import '../api/common/ps_resource.dart';
import '../api/common/ps_status.dart';
import '../api/ps_api_service.dart';
import '../viewobject/common/ps_holder.dart';
import '../viewobject/holder/request_path_holder.dart';
import '../viewobject/item_paid_history.dart';
import 'Common/ps_repository.dart';

class ItemPaidHistoryRepository extends PsRepository {
  ItemPaidHistoryRepository({required PsApiService psApiService}) {
    _psApiService = psApiService;
  }
  String primaryKey = 'id';
  late PsApiService _psApiService;

  @override
  Future<PsResource<ItemPaidHistory>> postData({
    PsHolder<dynamic>? requestBodyHolder,
    RequestPathHolder? requestPathHolder,
  }) async {
    final PsResource<ItemPaidHistory> _resource =
        await _psApiService.postItemPaidHistory(requestBodyHolder!.toMap(), requestPathHolder?.loginUserId ?? 'nologinuser',requestPathHolder!.languageCode ?? 'en' );
    if (_resource.status == PsStatus.SUCCESS) {
      return _resource;
    } else {
      final Completer<PsResource<ItemPaidHistory>> completer =
          Completer<PsResource<ItemPaidHistory>>();
      completer.complete(_resource);
      return completer.future;
    }
  }
}
