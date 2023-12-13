import 'common/ps_object.dart';

class PaymentAttributes extends PsObject<PaymentAttributes> {
  PaymentAttributes({
    this.type,
    this.count,
    this.price,
    this.status,
    this.currencySymbol,
    this.currencyShortForm,
  });

  String? type;
  String? count;
  String? price;
  String? status;
  String? currencySymbol;
  String? currencyShortForm;


  @override
  String? getPrimaryKey() {
    return '';
  }

  @override
  PaymentAttributes fromMap(dynamic dynamicData) {
    // if (dynamicData != null) {
    return PaymentAttributes(
      type : dynamicData['type'],
      count : dynamicData['count'],
      price : dynamicData['price'],
      status: dynamicData['status'],
      currencySymbol: dynamicData['currency_symbol'],
      currencyShortForm: dynamicData['currency_short_form'],
    );
    // } else {
    //   return null;
    // }
  }

  @override
  Map<String, dynamic>? toMap(PaymentAttributes? object) {
    if (object != null) {
      final Map<String, dynamic> data = <String, dynamic>{};
      data['type'] = object.type;
      data['count'] = object.count;
      data['price'] = object.price;
      data['status'] = object.status;
      data['currency_symbol'] = object.currencySymbol;
      data['currency_short_form'] = object.currencyShortForm;
      return data;
    } else {
      return null;
    }
  }

  @override
  List<PaymentAttributes> fromMapList(List<dynamic> dynamicDataList) {
    final List<PaymentAttributes> blogList = <PaymentAttributes>[];

    for (dynamic dynamicData in dynamicDataList) {
      if (dynamicData != null) {
        blogList.add(fromMap(dynamicData));
      }
    }
    return blogList;
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<PaymentAttributes?> objectList) {
    final List<Map<String, dynamic>?> mapList = <Map<String, dynamic>?>[];
    for (PaymentAttributes? data in objectList) {
      if (data != null) {
        mapList.add(toMap(data));
      }
    }
    return mapList;
  }
}