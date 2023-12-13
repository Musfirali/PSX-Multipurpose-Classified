import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../core/vendor/provider/category/category_provider.dart';
import '../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../core/vendor/repository/category_repository.dart';
import '../../../../../core/vendor/utils/utils.dart';
import '../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../../custom_ui/item/list_with_filter/components/category/category_filter_list.dart';
import '../../../common/ps_admob_banner_widget.dart';
import '../../../common/ps_app_bar_widget.dart';

class CategoryFilterListContainer extends StatefulWidget {
  const CategoryFilterListContainer({
    Key? key,
    required this.selectedData,
  }) : super(key: key);
  final dynamic selectedData;
  @override
  State<CategoryFilterListContainer> createState() =>
      CategoryFilterListContainerState();
}

class CategoryFilterListContainerState
    extends State<CategoryFilterListContainer> {
  void onSubCategoryClick(Map<String, String?> subCategory) {
    Navigator.pop(context, subCategory);
  }

  void onCategoryClick(Map<String, String?> category) {
    Navigator.pop(context, category);
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalization? langProvider = Provider.of<AppLocalization>(context);
    final CategoryRepository repo = Provider.of<CategoryRepository>(context);
    final PsValueHolder psValueHolder = Provider.of<PsValueHolder>(context);
    return Scaffold(
      appBar: PsAppbarWidget(
        appBarTitle: 'search__category'.tr,
        actionWidgets: <Widget>[
          IconButton(
            icon:
                const Icon(Icons.filter_alt_off_outlined),
            onPressed: () {
              final Map<String, String> dataHolder = <String, String>{};
              dataHolder[PsConst.CATEGORY_ID] = '';
              dataHolder[PsConst.SUB_CATEGORY_ID] = '';
              dataHolder[PsConst.CATEGORY_NAME] = '';
              onSubCategoryClick(dataHolder);
            },
          )
        ],
      ),
      body: ChangeNotifierProvider<CategoryProvider>(
        create: (BuildContext context) {
          final CategoryProvider provider = CategoryProvider(repo: repo);
          provider.loadDataList(
              requestBodyHolder: provider.categoryParameterHolder,
              requestPathHolder: RequestPathHolder(
                  loginUserId: Utils.checkUserLoginId(psValueHolder),
                  languageCode: langProvider!.currentLocale.languageCode));
          return provider;
        },
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const PsAdMobBannerWidget(),
              CustomCategoryFilterList(
                selectedData: widget.selectedData,
                onCategoryClick: onCategoryClick,
                onSubCategoryClick: onSubCategoryClick,
              ),
            ],
          ),
        ),
      ),
    );
  }
}