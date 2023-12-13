import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../../core/vendor/provider/app_info/app_info_provider.dart';
import '../../../../../../../../core/vendor/provider/product/product_provider.dart';
import '../../../../../../../../core/vendor/viewobject/product.dart';
import '../../../../../../custom_ui/item/detail/component/sticky_bottom/owner_action/widgets/change_status_widget.dart';
import '../../../../../../custom_ui/item/detail/component/sticky_bottom/owner_action/widgets/delete_widget.dart';
import '../../../../../../custom_ui/item/detail/component/sticky_bottom/owner_action/widgets/mark_as_sold_widget.dart';
import '../../../../../../custom_ui/item/detail/component/sticky_bottom/owner_action/widgets/promote_item_widget.dart';

class OwnerActionButtonsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ItemDetailProvider provider =
        Provider.of<ItemDetailProvider>(context);
    final Product product = provider.product;
    final AppInfoProvider appInfoprovider = Provider.of<AppInfoProvider>(context);
    return Consumer<AppInfoProvider>(builder:
        (BuildContext context, AppInfoProvider appInfoProvider, Widget? child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            CustomDeleteItemWidget(),
            if (!product.isSoldOutItem) CustomMarkAsSoldWidget(),
            CustomChangeStatusWidget(),
            if (appInfoProvider.appInfo.data != null &&
                product.isItemPromotable &&
                !appInfoprovider.isAllPaymentDisable)
              CustomPromoteItemWidget(),
          ],
        );
    });
  }
}