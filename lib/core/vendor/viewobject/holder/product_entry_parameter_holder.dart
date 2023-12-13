import '../common/ps_holder.dart';
import '../entry_product_relation.dart';

class ProductEntryParameterHolder
    extends PsHolder<ProductEntryParameterHolder> {
  ProductEntryParameterHolder({
    this.categoryId,
    this.description,
    this.productRelation,
    this.title,
  });
  String? title;
  String? description;
  int? categoryId;
  List<EntryProductRelation>? productRelation;

  @override
  ProductEntryParameterHolder fromMap(dynamic dynamicData) {
    return ProductEntryParameterHolder(
      title: dynamicData['title'],
      description: dynamicData['desc'],
      categoryId: dynamicData['category_id'],
      productRelation: dynamicData['product_relation'],
    );
  }

  @override
  String getParamKey() {
    return '';
  }

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{};
    for (EntryProductRelation element in productRelation!) {
      print(element.coreKeyId);
      print(element.value);

    }
    map['title'] = title;
    map['desc'] = description;
    map['category_id'] = categoryId;
    map['product_relation'] =
        EntryProductRelation().toMapList(productRelation!);
    return map;
  }
}
