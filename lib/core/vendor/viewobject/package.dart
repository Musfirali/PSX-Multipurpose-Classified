import 'package:quiver/core.dart';

import 'common/ps_object.dart';
import 'core_key.dart';
import 'payment.dart';
import 'payment_attributes.dart';
import 'payment_info.dart';

class Package extends PsObject<Package> {
  Package({
    this.packageId,
    this.paymentId,
    this.coreKeysId,
    this.shopId,
    this.payment,
    this.coreKey,
    this.paymentInfo,
    this.paymentAttributes,
    this.addedDateStr,
  });

  String? packageId;
  String? paymentId;
  String? coreKeysId;
  String? shopId;
  Payment? payment;
  CoreKey? coreKey;
  PaymentInfo? paymentInfo;
  PaymentAttributes? paymentAttributes;
  String? addedDateStr;

  @override
  bool operator ==(dynamic other) =>
      other is Package && packageId == other.packageId;

  @override
  int get hashCode {
    return hash2(packageId.hashCode, packageId.hashCode);
  }

  @override
  String? getPrimaryKey() {
    return packageId;
  }

  @override
  Package fromMap(dynamic dynamicData) {
    // if (dynamicData != null) {
    return Package(
      packageId: dynamicData['id'],
      paymentId: dynamicData['payment_id'],
      coreKeysId: dynamicData['core_keys_id'],
      shopId: dynamicData['shop_id'],
      payment: Payment().fromMap(dynamicData['payment']),
      coreKey: CoreKey().fromMap(dynamicData['core_key']),
      paymentInfo: PaymentInfo().fromMap(dynamicData['payment_info']),
      paymentAttributes:
          PaymentAttributes().fromMap(dynamicData['payment_attributes']),
      addedDateStr: dynamicData['added_date_str'],
    );
    // } else {
    //   return null;
    // }
  }

  @override
  Map<String, dynamic>? toMap(Package? object) {
    if (object != null) {
      final Map<String, dynamic> data = <String, dynamic>{};
      data['id'] = object.packageId;
      data['payment_id'] = object.paymentId;
      data['core_keys_id'] = object.coreKeysId;
      data['shop_id'] = object.shopId;
      data['payment'] = Payment().toMap(object.payment);
      data['core_key'] = CoreKey().toMap(object.coreKey);
      data['payment_info'] = PaymentInfo().toMap(object.paymentInfo);
      data['payment_attributes'] =
          PaymentAttributes().toMap(object.paymentAttributes);
      data['added_date_str'] = object.addedDateStr;

      return data;
    } else {
      return null;
    }
  }

  @override
  List<Package> fromMapList(List<dynamic> dynamicDataList) {
    final List<Package> blogList = <Package>[];

    for (dynamic dynamicData in dynamicDataList) {
      if (dynamicData != null) {
        blogList.add(fromMap(dynamicData));
      }
    }
    return blogList;
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<Package?> objectList) {
    final List<Map<String, dynamic>?> mapList = <Map<String, dynamic>?>[];
    for (Package? data in objectList) {
      if (data != null) {
        mapList.add(toMap(data));
      }
    }
    return mapList;
  }
}
