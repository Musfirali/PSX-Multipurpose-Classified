import 'package:quiver/core.dart';
import 'common/ps_object.dart';

class PaymentInfo extends PsObject<PaymentInfo> {
  PaymentInfo({
    this.id,
    this.paymentId,
    this.coreKeysId,
    this.value,
    this.uiTypeId,
    this.shopId,
    this.addedDateStr,
  });

  String? id;
  String? paymentId;
  String? coreKeysId;
  String? value;
  String? uiTypeId;
  String? shopId;
  String? addedDateStr;


  @override
  bool operator ==(dynamic other) => other is PaymentInfo && id == other.id;

  @override
  int get hashCode {
    return hash2(id.hashCode, id.hashCode);
  }

  @override
  String? getPrimaryKey() {
    return id;
  }

  @override
  PaymentInfo fromMap(dynamic dynamicData) {
    // if (dynamicData != null) {
    return PaymentInfo(
      id : dynamicData['id'],
      paymentId : dynamicData['payment_id'],
      coreKeysId : dynamicData['core_keys_id'],
      value: dynamicData['value'],
      uiTypeId: dynamicData['ui_type_id'],
      shopId: dynamicData['shop_id'],
      addedDateStr: dynamicData['added_date_str'],
    );
    // } else {
    //   return null;
    // }
  }

  @override
  Map<String, dynamic>? toMap(PaymentInfo? object) {
    if (object != null) {
      final Map<String, dynamic> data = <String, dynamic>{};
      data['id'] = object.id;
      data['payment_id'] = object.paymentId;
      data['core_keys_id'] = object.coreKeysId;
      data['value'] = object.value;
      data['ui_type_id'] = object.uiTypeId;
      data['shop_id'] = object.shopId;
      data['added_date_str'] = object.addedDateStr;
      return data;
    } else {
      return null;
    }
  }

  @override
  List<PaymentInfo> fromMapList(List<dynamic> dynamicDataList) {
    final List<PaymentInfo> blogList = <PaymentInfo>[];

    for (dynamic dynamicData in dynamicDataList) {
      if (dynamicData != null) {
        blogList.add(fromMap(dynamicData));
      }
    }
    return blogList;
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<PaymentInfo?> objectList) {
    final List<Map<String, dynamic>?> mapList = <Map<String, dynamic>?>[];
    for (PaymentInfo? data in objectList) {
      if (data != null) {
        mapList.add(toMap(data));
      }
    }
    return mapList;
  }
}