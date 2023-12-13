import 'dart:async';

import '../api/common/ps_resource.dart';
import '../api/common/ps_status.dart';
import '../api/ps_api_service.dart';
import '../viewobject/common/ps_holder.dart';
import '../viewobject/delivery_cost.dart';
import '../viewobject/holder/request_path_holder.dart';
import 'Common/ps_repository.dart';

class DeliveryCostRepository extends PsRepository {
  DeliveryCostRepository({
    required PsApiService psApiService,
  }) {
    _psApiService = psApiService;
  }
  String primaryKey = 'id';
  late PsApiService _psApiService;

  @override
  Future<dynamic> postData({
    required PsHolder<dynamic>? requestBodyHolder,
    required RequestPathHolder? requestPathHolder,
  }) async {
    final PsResource<DeliveryCost> _resource = await _psApiService
        .postDeliveryCheckingAndCalculating(requestBodyHolder!.toMap());
    if (_resource.status == PsStatus.SUCCESS) {
      return _resource;
    } else {
      final Completer<PsResource<DeliveryCost>> completer =
          Completer<PsResource<DeliveryCost>>();
      completer.complete(_resource);
      return completer.future;
    }
  }
}
