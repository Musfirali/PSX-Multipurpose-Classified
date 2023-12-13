import 'common/ps_object.dart';
import 'product_relation.dart';

class CProduct extends PsObject<CProduct> {
  CProduct({
    this.description,
    this.id,
    this.title,
    this.categoryId,
    this.productRelation,
    this.userId,
  });

  int? id;
  String? title;
  String? description;
  int? categoryId;
  int? userId;
  List<ProductRelation>? productRelation;

  @override
  CProduct fromMap(dynamic dynamicData) {
    return CProduct(
        id: dynamicData['id'],
        description: dynamicData['description'],
        title: dynamicData['title'],
        categoryId: dynamicData['category_id'],
        productRelation:
            ProductRelation().fromMapList(dynamicData['productRelation']),
        userId: dynamicData['userId']);
  }

  @override
  List<CProduct> fromMapList(List<dynamic>? dynamicDataList) {
    final List<CProduct> list = <CProduct>[];
    if (dynamicDataList != null) {
      for (dynamic element in dynamicDataList) {
        if (element != null) {
          list.add(fromMap(element));
        }
      }
    }
    return list;
  }

  @override
  String? getPrimaryKey() {
    return id.toString();
  }

  @override
  Map<String, dynamic>? toMap(CProduct? object) {
    if (object != null) {
      final Map<String, dynamic> data = <String, dynamic>{};
      data['id'] = object.id;
      data['description'] = object.description;
      data['title'] = object.title;
      data['category_id'] = object.categoryId;
      data['productRelation'] =
          ProductRelation().toMapList(object.productRelation!);
      data['userId'] = object.userId;

      return data;
    } else {
      return null;
    }
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<dynamic> objectList) {
    final List<Map<String, dynamic>?> mapList = <Map<String, dynamic>?>[];

    for (dynamic data in objectList) {
      if (data != null) {
        mapList.add(toMap(data));
      }
    }

    return mapList;
  }
}
