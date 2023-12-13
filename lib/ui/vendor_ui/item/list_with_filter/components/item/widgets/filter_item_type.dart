import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../config/ps_colors.dart';
import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/db/common/ps_data_source_manager.dart';
import '../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../core/vendor/provider/product/item_entry_provider.dart';
import '../../../../../../../core/vendor/provider/product/search_product_provider.dart';
import '../../../../../../../core/vendor/repository/item_entry_field_repository.dart';
import '../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../../core/vendor/viewobject/custom_field.dart';
import '../../../../../../../core/vendor/viewobject/customize_ui_detail.dart';
import '../../../../../../../core/vendor/viewobject/entry_product_relation.dart';
import '../../../../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../../custom_field_selection/view/single_data_selection_view.dart';


class FilterProductItemTypeWidget extends StatefulWidget {
  const FilterProductItemTypeWidget({
    Key? key,
    this.customField,
  }) : super(key: key);
  final CustomField? customField;
  @override
  State<StatefulWidget> createState() => _FilterProductItemTypeWidgetState();
}

class _FilterProductItemTypeWidgetState
    extends State<FilterProductItemTypeWidget> {
  ItemEntryFieldProvider? itemEntryFieldProvider;
  ItemEntryFieldRepository? itemEntryFieldRepo;

  @override
  Widget build(BuildContext context) {
    final AppLocalization langProvider = Provider.of<AppLocalization>(context);
    final TextEditingController valueTextController = TextEditingController();
    final SearchProductProvider searchProductProvider =
        Provider.of<SearchProductProvider>(context);
    final PsValueHolder valueHolder = Provider.of<PsValueHolder>(context);
    itemEntryFieldRepo = Provider.of<ItemEntryFieldRepository>(context);

    const String itemTypeCustomId = 'ps-itm00002';

    return ChangeNotifierProvider<ItemEntryFieldProvider?>(
        lazy: false,
        create: (BuildContext context) {
          itemEntryFieldProvider =
              ItemEntryFieldProvider(repo: itemEntryFieldRepo!);
          itemEntryFieldProvider!.loadData(
              dataConfig: DataConfiguration(
                  dataSourceType: DataSourceType.SERVER_DIRECT),
              requestPathHolder: RequestPathHolder(
                  loginUserId: Utils.checkUserLoginId(valueHolder),
                  languageCode: langProvider.currentLocale.languageCode));
          return itemEntryFieldProvider;
        },
        child: Consumer<ItemEntryFieldProvider>(builder: (BuildContext context,
            ItemEntryFieldProvider provider, Widget? child) {
          if (!provider.hasData) {
            return const SizedBox(
              height: PsDimens.space36,
            );
          } else {
            if (provider.itemEntryField.data!.customField!.indexWhere(
                    (CustomField element) =>
                        element.coreKeyId == itemTypeCustomId) <
                0) {
              return const SizedBox();
            }
            final CustomField customField = provider
                .itemEntryField.data!.customField!
                .where((CustomField element) =>
                    element.coreKeyId == itemTypeCustomId)
                .first;

            return InkWell(
                onTap: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  final dynamic result = await Navigator.of(context)
                      .push<dynamic>(MaterialPageRoute<dynamic>(
                          builder: (BuildContext context) {
                    return SingleDataSelectionContainer(
                      appBartitle: customField.name!,
                      textEditingController: valueTextController,
                      coreKeyId: itemTypeCustomId,
                      selectedId: searchProductProvider.itemTypeId,
                      allNeeded: true,
                    );
                  }));
                  if (result != null) {
                    if (result is CustomizeUiDetail) {
                      searchProductProvider.selectedItemTypeName = result.name;
                      searchProductProvider.itemTypeId = result.id;
                      final EntryProductRelation productRelation =
                          EntryProductRelation(
                              coreKeyId: itemTypeCustomId, value: result.id);

                      /// Remove the same entry product relation
                      /// To prevent multiple values with same key
                      /// After that, add new entry product relation again
                      searchProductProvider
                          .productParameterHolder.productRelation
                          ?.removeWhere((EntryProductRelation element) =>
                              element.coreKeyId == itemTypeCustomId);
                      searchProductProvider
                          .productParameterHolder.productRelation
                          ?.add(productRelation);
                    } else if (result != null &&
                        result == 'product_list__category_all'.tr) {
                      searchProductProvider.itemTypeId =
                          searchProductProvider.selectedItemTypeName =
                              'product_list__category_all'.tr;
                      searchProductProvider
                          .productParameterHolder.productRelation
                          ?.clear();
                    }
                    searchProductProvider.loadDataList(
                        reset: true,
                        requestPathHolder: RequestPathHolder(
                          loginUserId: Utils.checkUserLoginId(valueHolder),
                        ),
                        requestBodyHolder:
                            searchProductProvider.productParameterHolder);
                  }
                },
                child: Container(
                  height: PsDimens.space36,
                  width: PsDimens.space76,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                            searchProductProvider.selectedItemTypeName == ''
                                ? 'product_list__category_all'.tr
                                : searchProductProvider.selectedItemTypeName!,
                            overflow: TextOverflow.ellipsis,
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Utils.isLightMode(context) ? PsColors.text700: PsColors.text50,
                                    )),
                      ),
                      const Icon(
                        Icons.keyboard_arrow_down,
                      ),
                    ],
                  ),
                ));
          }
        }));
  }
}
