


import '../common/ps_holder.dart';

class ItemChangeStatusParameterHolder extends PsHolder<dynamic> {
  ItemChangeStatusParameterHolder({
    required this.itemId,
    required this.status
  });

  String? itemId;
  String? status;

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['item_id'] = itemId;
    map['status'] = status;
    return map;
  }

  @override
  dynamic fromMap(dynamic dynamicData) {
    itemId = '';
    status = '';
    return this;
  }

  @override
  String getParamKey() {
    String result = '';

    if (itemId != '') {
      result += itemId! + ':';
    }
    if (status != '') {
      result += status! + '';
    }
    return result;
  }
}
