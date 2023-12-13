
import '../common/ps_holder.dart';

class ShopTouchCountParameterHolder extends PsHolder<ShopTouchCountParameterHolder> {
  ShopTouchCountParameterHolder(
      {required this.typeId,
      required this.typeName,
      required this.userId,
      required this.shopId});

  final String? typeId;
  final String? typeName;
  final String? userId;
  final String? shopId;

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{};

    map['type_id'] = typeId;
    map['type_name'] = typeName;
    map['user_id'] = userId;
    map['shop_id'] = shopId;

    return map;
  }

  @override
  ShopTouchCountParameterHolder fromMap(dynamic dynamicData) {
    return ShopTouchCountParameterHolder(
      typeId: dynamicData['type_id'],
      typeName: dynamicData['type_name'],
      userId: dynamicData['user_id'],
      shopId: dynamicData['shop_id'],
    );
  }

  @override
  String getParamKey() {
    String key = '';

    if (typeId != '') {
      key += typeId!;
    }
    if (typeName != '') {
      key += typeName!;
    }

    if (userId != '') {
      key += userId!;
    }
    if (shopId != '') {
      key += shopId!;
    }
    return key;
  }
}
