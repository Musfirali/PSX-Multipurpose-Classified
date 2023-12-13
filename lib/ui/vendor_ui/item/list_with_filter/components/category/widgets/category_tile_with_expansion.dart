import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';

import '../../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../core/vendor/provider/subcategory/sub_category_provider.dart';
import '../../../../../../../core/vendor/repository/sub_category_repository.dart';
import '../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../core/vendor/viewobject/category.dart';
import '../../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../../../common/expansion_tile.dart' as custom;
import '../../../../../common/shimmer_item.dart';

class CategoryTileWithExpansion extends StatefulWidget {
  const CategoryTileWithExpansion(
      {Key? key,
      this.selectedData,
      this.category,
      required this.onSubCategoryClick,
      required this.isLoading})
      : super(key: key);
  final dynamic selectedData;
  final Category? category;
  final Function onSubCategoryClick;
  final bool isLoading;
  @override
  State<StatefulWidget> createState() => _FilterExpantionTileView();
}

class _FilterExpantionTileView extends State<CategoryTileWithExpansion> {
  SubCategoryRepository? subCategoryRepository;
  PsValueHolder? valueHolder;
  bool isExpanded = false;
  late AppLocalization langProvider;
//  SubCategoryProvider? _subCategoryProvider;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    langProvider = Provider.of<AppLocalization>(context);
    subCategoryRepository = Provider.of<SubCategoryRepository>(context);
    valueHolder = Provider.of<PsValueHolder>(context);

    if (widget.isLoading)
      return Container(
          margin: const EdgeInsets.symmetric(vertical: 1.0),
          height: PsDimens.space52,
          child: const ShimmerItem());

    return ChangeNotifierProvider<SubCategoryProvider>(
        lazy: false,
        create: (BuildContext context) {
          final SubCategoryProvider provider =
              SubCategoryProvider(repo: subCategoryRepository);
          provider.subCategoryParameterHolder.catId = widget.category!.catId;
          provider.categoryId = widget.category!.catId!;
          provider.loadDataList(
              requestBodyHolder: provider.subCategoryParameterHolder,
              requestPathHolder: RequestPathHolder(
                  loginUserId: Utils.checkUserLoginId(valueHolder),
                  languageCode: langProvider.currentLocale.languageCode));
          return provider;
        },
        child: Consumer<SubCategoryProvider>(builder: (BuildContext context,
            SubCategoryProvider provider, Widget? child) {
          return Container(
              child: custom.ExpansionTile(
            initiallyExpanded: false,
            headerBackgroundColor: Utils.isLightMode(context) ? PsColors.achromatic50
              : PsColors.achromatic900,
            title: Container(
              child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      widget.category!.catName!,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Container(
                        child: widget.category!.catId ==
                                widget.selectedData[PsConst.CATEGORY_ID]
                            ? IconButton(
                                icon: const Icon(Icons.playlist_add_check),
                                onPressed: () {})
                            : const SizedBox())
                  ]),
            ),
            children: <Widget>[
              Container(
                color:
                    Utils.isLightMode(context) ? PsColors.achromatic50 : PsColors.achromatic900,
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: provider.subCategoryList.data!.length + 1,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: PsDimens.space16),
                                child: index == 0
                                    ? Text(
                                        'product_list__category_all'.tr,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      )
                                    : Text(
                                        provider.subCategoryList
                                            .data![index - 1].name!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge),
                              ),
                            ),
                            Container(
                                child: index == 0 &&
                                        widget.category!.catId ==
                                            widget.selectedData[
                                                PsConst.CATEGORY_ID] &&
                                        widget.selectedData[PsConst.SUB_CATEGORY_ID] ==
                                            ''
                                    ? IconButton(
                                        icon: const Icon(Icons.check_circle),
                                        onPressed: () {})
                                    : index != 0 &&
                                            widget.selectedData[
                                                    PsConst.SUB_CATEGORY_ID] ==
                                                provider.subCategoryList
                                                    .data![index - 1].id
                                        ? IconButton(
                                            icon: Icon(Icons.check_circle,
                                                color: Theme.of(context)
                                                    .iconTheme
                                                    .color),
                                            onPressed: () {})
                                        : Container())
                          ],
                        ),
                        onTap: () {
                          final Map<String, String?> dataHolder =
                              <String, String?>{};
                          if (index == 0) {
                            dataHolder[PsConst.CATEGORY_ID] =
                                widget.category!.catId;
                            dataHolder[PsConst.SUB_CATEGORY_ID] = '';
                            dataHolder[PsConst.CATEGORY_NAME] =
                                widget.category!.catName;
                            widget.onSubCategoryClick(dataHolder);
                          } else {
                            dataHolder[PsConst.CATEGORY_ID] =
                                widget.category!.catId;
                            dataHolder[PsConst.SUB_CATEGORY_ID] =
                                provider.subCategoryList.data![index - 1].id;
                            dataHolder[PsConst.CATEGORY_NAME] =
                                provider.subCategoryList.data![index - 1].name;
                            widget.onSubCategoryClick(dataHolder);
                          }
                        },
                      );
                    }),
              ),
            ],
            onExpansionChanged: (bool expanding) =>
                setState(() => isExpanded = expanding),
          ));
        }));
  }
}
