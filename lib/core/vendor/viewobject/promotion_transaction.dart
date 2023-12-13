import 'package:quiver/core.dart';

import 'common/ps_object.dart';

class PromotionTransaction extends PsObject<PromotionTransaction> {
  PromotionTransaction({
    this.id,
    this.itemId,
    this.startDate,
    this.endDate,
    this.amount,
    this.promotedDays,
    this.promotedMsg,
    this.paymentMethod,
    this.status,
    this.addedDateStr,
  });

  String? id;
  String? itemId;
  String? startDate;
  String? endDate;
  String? amount;
  String? promotedDays;
  String? promotedMsg;
  String? paymentMethod;
  String? status;
  String? addedDateStr;

  @override
  bool operator ==(dynamic other) =>
      other is PromotionTransaction && id == other.id;

  @override
  int get hashCode {
    return hash2(id.hashCode, id.hashCode);
  }

  @override
  String? getPrimaryKey() {
    return id;
  }

  @override
  PromotionTransaction fromMap(dynamic dynamicData) {
    // if (dynamicData != null) {
    return PromotionTransaction(
      id: dynamicData['id'],
      itemId: dynamicData['item_id'],
      startDate: dynamicData['start_date'],
      endDate: dynamicData['end_date'],
      amount: dynamicData['amount'],
      promotedDays: dynamicData['promoted_days'],
      promotedMsg: dynamicData['promoted_msg'],
      paymentMethod: dynamicData['payment_method'],
      status: dynamicData['status'],
      addedDateStr: dynamicData['added_date_str'],
    );
    // } else {
    //   return null;
    // }
  }

  @override
  Map<String, dynamic>? toMap(PromotionTransaction? object) {
    if (object != null) {
      final Map<String, dynamic> data = <String, dynamic>{};
      data['id'] = object.id;
      data['item_id '] = object.itemId;
      data['start_date '] = object.startDate;
      data['end_date '] = object.endDate;
      data['amount'] = object.amount;
      data['promoted_days'] = object.promotedDays;
      data['promoted_msg'] = object.promotedMsg;
      data['payment_method'] = object.paymentMethod;
      data['status'] = object.status;
      data['added_date_str'] = object.addedDateStr;
      return data;
    } else {
      return null;
    }
  }

  @override
  List<PromotionTransaction> fromMapList(List<dynamic> dynamicDataList) {
    final List<PromotionTransaction> blogList = <PromotionTransaction>[];

    for (dynamic dynamicData in dynamicDataList) {
      if (dynamicData != null) {
        blogList.add(fromMap(dynamicData));
      }
    }
    return blogList;
  }

  @override
  List<Map<String, dynamic>?> toMapList(
      List<PromotionTransaction?> objectList) {
    final List<Map<String, dynamic>?> mapList = <Map<String, dynamic>?>[];
    for (PromotionTransaction? data in objectList) {
      if (data != null) {
        mapList.add(toMap(data));
      }
    }
    return mapList;
  }
}
