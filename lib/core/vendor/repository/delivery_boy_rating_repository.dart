import 'dart:async';

import '../api/common/ps_resource.dart';
import '../api/common/ps_status.dart';
import '../api/ps_api_service.dart';
import '../db/delivery_boy_rating_dao.dart';
import '../viewobject/common/ps_holder.dart';
import '../viewobject/delivery_boy_rating.dart';
import '../viewobject/holder/request_path_holder.dart';
import 'Common/ps_repository.dart';

class DeliveryBoyRatingRepository extends PsRepository {
  DeliveryBoyRatingRepository(
      {required PsApiService psApiService,
      required DeliveryBoyRatingDao ratingDao}) {
    _psApiService = psApiService;
    _ratingDao = ratingDao;
  }

  String primaryKey = 'id';
  late PsApiService _psApiService;
  late DeliveryBoyRatingDao _ratingDao;

  Future<dynamic> insert(DeliveryBoyRating rating) async {
    return _ratingDao.insert(primaryKey, rating);
  }

  Future<dynamic> update(DeliveryBoyRating rating) async {
    return _ratingDao.update(rating);
  }

  Future<dynamic> delete(DeliveryBoyRating rating) async {
    return _ratingDao.delete(rating);
  }

  @override
  Future<dynamic> postData({
    required PsHolder<dynamic>? requestBodyHolder,
    required RequestPathHolder? requestPathHolder,
  }) async {
    final PsResource<DeliveryBoyRating> _resource =
        await _psApiService.postDeliveryBoyRating(requestBodyHolder!.toMap());
    if (_resource.status == PsStatus.SUCCESS) {
      return _resource;
    } else {
      final Completer<PsResource<DeliveryBoyRating>> completer =
          Completer<PsResource<DeliveryBoyRating>>();
      completer.complete(_resource);

      return completer.future;
    }
  }
}
