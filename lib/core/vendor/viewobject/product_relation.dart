import 'common/ps_object.dart';
import 'selected_value.dart';

class ProductRelation extends PsObject<ProductRelation> {
  ProductRelation(
      {this.id,
      this.productId,
      this.coreKeyId,
      this.value,
      this.uiTypeId,
      this.selectedValues,
      this.addedDateStr});

  String? id;
  String? productId;
  String? coreKeyId;
  String? value;
  String? uiTypeId;
  List<SelectedValue>? selectedValues;
  String? addedDateStr;

  @override
  ProductRelation fromMap(dynamic dynamicData) {
    return ProductRelation(
      id: dynamicData['id'],
      productId: dynamicData['item_id'],
      coreKeyId: dynamicData['core_keys_id'],
      value: dynamicData['value'],
      uiTypeId: dynamicData['ui_type_id'],
      selectedValues: SelectedValue().fromMapList(dynamicData['selectedValue']),
      addedDateStr: dynamicData['added_date_str'],
    );
  }

  @override
  List<ProductRelation> fromMapList(List<dynamic>? dynamicDataList) {
    final List<ProductRelation> list = <ProductRelation>[];
    if (dynamicDataList != null) {
      for (dynamic element in dynamicDataList) {
        list.add(fromMap(element));
      }
    }
    return list;
  }

  @override
  String? getPrimaryKey() {
    return id.toString();
  }

  @override
  Map<String, dynamic>? toMap(ProductRelation? object) {
    if (object != null) {
      final Map<String, dynamic> data = <String, dynamic>{};
      data['id'] = object.id;
      data['item_id'] = object.productId;
      data['core_keys_id'] = object.coreKeyId;
      data['value'] = object.value;
      data['ui_type_id'] = object.uiTypeId;
      data['selectedValue'] = SelectedValue().toMapList(object.selectedValues!);
      data['added_date_str'] = object.addedDateStr;

      return data;
    } else {
      return null;
    }
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<ProductRelation> objectList) {
    final List<Map<String, dynamic>?> mapList = <Map<String, dynamic>?>[];

    for (ProductRelation? data in objectList) {
      if (data != null) {
        mapList.add(toMap(data));
      }
    }

    return mapList;
  }
}
