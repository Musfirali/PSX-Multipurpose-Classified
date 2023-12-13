import '../../api/common/ps_resource.dart';
import '../../constant/ps_constants.dart';
import '../../repository/all_search_result_repository.dart';
import '../../viewobject/all_search_result.dart';
import '../../viewobject/category.dart';
import '../../viewobject/holder/all_search_parameter_holder.dart';
import '../../viewobject/product.dart';
import '../../viewobject/user.dart';
import '../common/ps_provider.dart';

class AllSearchResultProvider extends PsProvider<AllSearchResult> {
  AllSearchResultProvider(
      {required AllSearchResultRepository repo, int limit = 0})
      : super(repo, limit,
            subscriptionType: PsConst.SINGLE_OBJECT_SUBSCRIPTION);

  PsResource<AllSearchResult> get allSearchResult => data;

  AllSearchParameterHolder allSearchParameterHolder =
      AllSearchParameterHolder().getDefaultParameterHolder();

  Category getCategoryAtIndex(int index) {
    return allSearchResult.data?.categories?[index] ?? Category();
  }

  Product getItemAtIndex(int index) {
    return allSearchResult.data?.products?[index] ?? Product();
  }

  User getUserAtIndex(int index) {
    return allSearchResult.data?.users?[index] ?? User();
  }

  int get categoryListLength {
    return allSearchResult.data?.categories?.length ?? 0;
  }

  int get userListLength {
    return allSearchResult.data?.users?.length ?? 0;
  }

  int get itemListLength {
    return allSearchResult.data?.products?.length ?? 0;
  }

  bool get hasCategoryList {
    return allSearchResult.data != null &&
        allSearchResult.data!.categories != null &&
        allSearchResult.data!.categories!.isNotEmpty;
  }

  bool get showCategoryList {
    return allSearchParameterHolder.type == PsConst.ALL ||
        allSearchParameterHolder.type == PsConst.CATEGORY;
  }

  bool get hasUserList {
    return allSearchResult.data != null &&
        allSearchResult.data!.users != null &&
        allSearchResult.data!.users!.isNotEmpty;
  }

  bool get showUserList {
    return allSearchParameterHolder.type == PsConst.ALL ||
        allSearchParameterHolder.type == PsConst.USER;
  }

  bool get hasProductList {
    return allSearchResult.data != null &&
        allSearchResult.data!.products != null &&
        allSearchResult.data!.products!.isNotEmpty;
  }

  bool get showProductList {
    return allSearchParameterHolder.type == PsConst.ALL ||
        allSearchParameterHolder.type == PsConst.ITEM;
  }

  bool get showOnlyProductList {
    return allSearchParameterHolder.type == PsConst.ITEM;
  }

  bool get showAll {
    return allSearchParameterHolder.type == PsConst.ALL;
  }

  bool get showOnlyUserList {
    return allSearchParameterHolder.type == PsConst.USER;
  }

  bool get showOnlyCategoryList {
    return allSearchParameterHolder.type == PsConst.CATEGORY;
  }

  bool get isEmptyData {
    return allSearchResult.data != null &&
        allSearchResult.data!.categories != null &&
        allSearchResult.data!.categories!.isEmpty &&
        allSearchResult.data!.users != null &&
        allSearchResult.data!.users!.isEmpty &&
        allSearchResult.data!.users != null &&
        allSearchResult.data!.users!.isEmpty;
  }

  void clearData() {
    allSearchResult.data?.categories?.clear();
    allSearchResult.data?.users?.clear();
    allSearchResult.data?.products?.clear();
  }
}
