import 'category.dart';
import 'common/ps_object.dart';
import 'product.dart';
import 'shop.dart';
import 'sub_category.dart';

class SearchResult extends PsObject<SearchResult> {
  SearchResult({
    this.id,
    this.products,
    this.categories,
    this.shops,
    this.subCategories,
  });

  final String? id;
  final List<Product>? products;
  final List<Category>? categories;
  final List<Shop>? shops;
  final List<SubCategory>? subCategories;

  @override
  SearchResult fromMap(dynamic dynamicData) {
    //if (dynamicData != null) {
    return SearchResult(
      // id: dynamicData['id'],
      products: Product().fromMapList(dynamicData['products']),
      categories: Category().fromMapList(dynamicData['categories']),
      shops: Shop().fromMapList(dynamicData['shops']),
      subCategories: SubCategory().fromMapList(dynamicData['subcategories']),
    );
    // } else {
    //   return null;
    // }
  }

  @override
  List<SearchResult> fromMapList(List<dynamic> dynamicDataList) {
    final List<SearchResult> list = <SearchResult>[];
    // if (dynamicDataList != null) {
    for (dynamic json in dynamicDataList) {
      if (json != null) {
        list.add(fromMap(json));
      }
    }
    // }
    return list;
  }

  @override
  String? getPrimaryKey() {
    return id ?? '';
  }

  @override
  Map<String, dynamic>? toMap(SearchResult? object) {
    if (object != null) {
      final Map<String, dynamic> data = <String, dynamic>{};
      // data['id'] = object.id;
      data['products'] = Product().toMapList(object.products!);
      data['categories'] = Category().toMapList(object.categories!);
      data['shops'] = Shop().toMapList(object.shops!);
      data['subcategories'] = SubCategory().toMapList(object.subCategories!);
      return data;
    } else {
      return null;
    }
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<SearchResult> objectList) {
    final List<Map<String, dynamic>?> mapList = <Map<String, dynamic>?>[];
    //  if (objectList != null) {
    for (dynamic data in mapList) {
      if (data != null) {
        mapList.add(toMap(data));
      }
    }
    // }
    return mapList;
  }
}
