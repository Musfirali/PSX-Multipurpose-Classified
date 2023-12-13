import 'package:flutter/material.dart';

import '../../../../../../core/vendor/provider/subcategory/sub_category_provider.dart';
import '../../../../../custom_ui/subcategory/component/vertical/widgets/subcat_subscription_add_icon.dart';
import '../../../../../custom_ui/subcategory/component/vertical/widgets/subcat_subscription_done_icon.dart';

class SubscriptionActionWidgets extends StatefulWidget {
  const SubscriptionActionWidgets({required this.subCategoryProvider});
  final SubCategoryProvider subCategoryProvider;

  @override
  _SubscriptionActionWidgets createState() => _SubscriptionActionWidgets();
}

class _SubscriptionActionWidgets extends State<SubscriptionActionWidgets> {
  @override
  Widget build(BuildContext context) {
    if (!widget.subCategoryProvider.subscriptionMode)
      return CustomSubscriptionAddIcon(
          subCategoryProvider: widget.subCategoryProvider,
          changeMode: () {
            setState(() {
              widget.subCategoryProvider.subscriptionMode = true;
            });
          });
    else
      return CustomSubscriptionDoneIcon(
          subCategoryProvider: widget.subCategoryProvider,
          changeMode: () {
            setState(() {
              widget.subCategoryProvider.subscriptionMode = false;
            });
          });
  }
}
