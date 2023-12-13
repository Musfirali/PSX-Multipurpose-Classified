import 'category.dart';
import 'common/ps_object.dart';
import 'product.dart';
import 'user.dart';

class AllSearchResult extends PsObject<AllSearchResult> {
  AllSearchResult({
    this.id,
    this.products,
    this.categories,
    this.users,
  });

  final String? id;
  final List<Product>? products;
  final List<Category>? categories;
  final List<User>? users;

  @override
  AllSearchResult fromMap(dynamic dynamicData) {
    return AllSearchResult(
      // id: dynamicData['id'],
      products: Product().fromMapList(dynamicData['items']),
      categories: Category().fromMapList(dynamicData['categories']),
      users: User().fromMapList(dynamicData['users']),
    );
  }

  @override
  List<AllSearchResult> fromMapList(List<dynamic> dynamicDataList) {
    final List<AllSearchResult> list = <AllSearchResult>[];
    for (dynamic json in dynamicDataList) {
      if (json != null) {
        list.add(fromMap(json));
      }
    }
    return list;
  }

  @override
  String? getPrimaryKey() {
    return id ?? '';
  }

  @override
  Map<String, dynamic>? toMap(AllSearchResult? object) {
    if (object != null) {
      final Map<String, dynamic> data = <String, dynamic>{};
      // data['id'] = object.id;
      data['items'] = Product().toMapList(object.products!);
      data['categories'] = Category().toMapList(object.categories!);
      data['users'] = User().toMapList(object.users!);
      return data;
    } else {
      return null;
    }
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<AllSearchResult> objectList) {
    final List<Map<String, dynamic>?> mapList = <Map<String, dynamic>?>[];
    for (dynamic data in mapList) {
      if (data != null) {
        mapList.add(toMap(data));
      }
    }
    return mapList;
  }
}
