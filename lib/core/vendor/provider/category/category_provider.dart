import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:psxmpc/core/vendor/provider/common/ps_init_provider.dart';
import 'package:psxmpc/core/vendor/utils/utils.dart';
import 'package:psxmpc/core/vendor/viewobject/common/ps_value_holder.dart';
import 'package:psxmpc/core/vendor/viewobject/holder/request_path_holder.dart';

import '../../api/common/ps_resource.dart';
import '../../constant/ps_constants.dart';
import '../../repository/category_repository.dart';
import '../../viewobject/category.dart';
import '../../viewobject/holder/category_parameter_holder.dart';
import '../common/ps_provider.dart';

class CategoryProvider extends PsProvider<Category> {
  CategoryProvider({
    required this.repo,
    int limit = 0,
  }) : super(repo, limit, subscriptionType: PsConst.LIST_OBJECT_SUBSCRIPTION);

  CategoryParameterHolder categoryParameterHolder =
      CategoryParameterHolder().getLatestParameterHolder();
  
  CategoryParameterHolder trendingCategoryParameterHolder =
      CategoryParameterHolder().getTrendingParameterHolder();

  final CategoryRepository? repo;
  late String catId = '';

  PsResource<List<Category>> get categoryList => super.dataList;
}

SingleChildWidget initCategoryProvider(BuildContext context, Function function,
    {Widget? widget, String? keyword}) {
  final PsValueHolder valueHolder = Provider.of<PsValueHolder>(context);
  final CategoryRepository repo1 = Provider.of<CategoryRepository>(context);
  // final AppLocalization langProvider = Provider.of<AppLocalization>(context);
  return psInitProvider<CategoryProvider>(
      widget: widget,
      initProvider: () {
        return CategoryProvider(
          repo: repo1,
          limit: valueHolder.categoryLoadingLimit!,
        );
      },
      onProviderReady: (CategoryProvider provider) {
        if (keyword!.isNotEmpty)
          provider.categoryParameterHolder.keyword = keyword;
        provider.loadDataList(
            requestBodyHolder: provider.categoryParameterHolder,
            requestPathHolder: RequestPathHolder(
                loginUserId: Utils.checkUserLoginId(valueHolder),
                languageCode: valueHolder.languageCode));
        function(provider);
      });
}
