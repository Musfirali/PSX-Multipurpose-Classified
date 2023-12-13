import '../common/ps_holder.dart';

class DeliveryCostParameterHolder
    extends PsHolder<DeliveryCostParameterHolder> {
  DeliveryCostParameterHolder(
      {required this.userLat,
      required this.userLng,
      required this.productId});

  final String? userLat;
  final String? userLng;
  final String? productId;

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{};

    map['user_lat'] = userLat;
    map['user_lng'] = userLng;
    map['product_id'] = productId;

    return map;
  }

  @override
  DeliveryCostParameterHolder fromMap(dynamic dynamicData) {
    return DeliveryCostParameterHolder(
      userLat: dynamicData['user_lat'],
      userLng: dynamicData['user_lng'],
      productId: dynamicData['product_id'],
    );
  }

  @override
  String getParamKey() {
    String key = '';

    if (userLat != '') {
      key += userLat!;
    }
    if (userLng != '') {
      key += userLng!;
    }
    if (productId != '') {
      key += productId!;
    }
    return key;
  }
}
