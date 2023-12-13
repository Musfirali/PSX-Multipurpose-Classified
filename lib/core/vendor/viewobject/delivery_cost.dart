import 'common/ps_object.dart';

class DeliveryCost extends PsObject<DeliveryCost> {
  DeliveryCost(
      {this.optionType,
      this.distance,
      this.costPerCharges,
      this.totalCost,
      this.unit});

  String? optionType;
  String? distance;
  String? costPerCharges;
  String? totalCost;
  String? unit;

  @override
  String getPrimaryKey() {
    return '';
  }

  @override
  DeliveryCost fromMap(dynamic dynamicData) {
    //if (dynamicData != null) {
    return DeliveryCost(
      optionType: dynamicData['option_type'],
      distance: dynamicData['distance'],
      costPerCharges: dynamicData['cost_per_charges'],
      totalCost: dynamicData['total_cost'],
      unit: dynamicData['unit'],
    );
    // } else {
    //   return null;
    // }
  }

  @override
  Map<String, dynamic>? toMap(dynamic object) {
    if (object != null) {
      final Map<String, dynamic> data = <String, dynamic>{};
      data['option_type'] = object.optionType;
      data['distance'] = object.distance;
      data['cost_per_charges'] = object.costPerCharges;
      data['total_cost'] = object.totalCost;
      data['unit'] = object.unit;

      return data;
    } else {
      return null;
    }
  }

  @override
  List<DeliveryCost> fromMapList(List<dynamic> dynamicDataList) {
    final List<DeliveryCost> shippingCostList = <DeliveryCost>[];

    //if (dynamicDataList != null) {
    for (dynamic json in dynamicDataList) {
      if (json != null) {
        shippingCostList.add(fromMap(json));
      }
    }
    //}
    return shippingCostList;
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<dynamic> objectList) {
    final List<dynamic> dynamicList = <dynamic>[];
    //if (objectList != null) {
    for (dynamic data in objectList) {
      if (data != null) {
        dynamicList.add(toMap(data));
      }
    }
    //}

    return dynamicList as List<Map<String, dynamic>?>;
  }
}
