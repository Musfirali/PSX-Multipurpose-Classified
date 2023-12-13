import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/core/vendor/db/common/ps_data_source_manager.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';
import 'package:psxmpc/core/vendor/utils/utils.dart';
import 'package:psxmpc/core/vendor/viewobject/common/ps_value_holder.dart';
import 'package:psxmpc/core/vendor/viewobject/product.dart';

import '../../../../../../config/route/route_paths.dart';
import '../../../../../../core/vendor/api/common/ps_status.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/product/product_provider.dart';
import '../../../../../../core/vendor/provider/product/related_product_provider.dart';
import '../../../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../../../custom_ui/item/list_item/product_horizontal_list_widget.dart';
import '../../../../common/ps_list_header_widget.dart';

class RelatedProductListWidget extends StatefulWidget {
  @override
  State<RelatedProductListWidget> createState() =>
      _RelatedProductListWidgetState();
}

class _RelatedProductListWidgetState extends State<RelatedProductListWidget> {
  bool isFirstTime = false;

  @override
  Widget build(BuildContext context) {
    final ItemDetailProvider itemDetailProvider =
        Provider.of<ItemDetailProvider>(context);
    final PsValueHolder valueHolder = Provider.of<PsValueHolder>(context);

    final Product product = itemDetailProvider.product;

    return SliverToBoxAdapter(
        child: itemDetailProvider.hasData
            ? Consumer<RelatedProductProvider>(
                builder: (BuildContext context,
                    RelatedProductProvider relatedProductProvider,
                    Widget? child) {
                  if (!isFirstTime) {
                    relatedProductProvider.loadRelatedProductList(
                        dataConfiguration: DataConfiguration(
                            dataSourceType: DataSourceType.SERVER_DIRECT),
                        productId: product.id,
                        categoryId: product.catId!,
                        loginUserId: Utils.checkUserLoginId(valueHolder),
                        languageCode: valueHolder.languageCode);
                    isFirstTime = true;
                  }
                  return relatedProductProvider.hasData
                      ? Column(
                          children: <Widget>[
                            PsListHeaderWidget(
                              headerName:
                                  'related_product_tile__related_product'.tr,
                              headerDescription: '',
                              viewAllClicked: () {
                                viewAllRelatedItemsClicked(context);
                              },
                            ),
                            CustomProductHorizontalListWidget(
                              tagKey:
                                  relatedProductProvider.hashCode.toString(),
                              productList: relatedProductProvider
                                  .relatedProductList.data,
                              isLoading: relatedProductProvider.currentStatus ==
                                  PsStatus.BLOCK_LOADING,
                            ),
                            const SizedBox(height: PsDimens.space8,)
                          ],
                        )
                      : const SizedBox();
                },
              )
            : const SizedBox());
  }

  void viewAllRelatedItemsClicked(BuildContext context) {
    final ItemDetailProvider itemDetailProvider =
        Provider.of<ItemDetailProvider>(context, listen: false);
    Navigator.pushNamed(context, RoutePaths.relatedProductList,
        arguments: RequestPathHolder(
            categoryId: itemDetailProvider.product.catId,
            productId: itemDetailProvider.product.id));
  }
}
