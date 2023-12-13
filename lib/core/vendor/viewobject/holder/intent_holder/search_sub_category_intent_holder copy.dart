import 'package:psxmpc/core/vendor/viewobject/holder/sub_category_parameter_holder.dart';

class SearchSubCategoryIntentHolder {
  const SearchSubCategoryIntentHolder({
    required this.subCategoryParameterHolder,
    required this.categoryId,
  });
  final SubCategoryParameterHolder subCategoryParameterHolder;
  final String categoryId;
}