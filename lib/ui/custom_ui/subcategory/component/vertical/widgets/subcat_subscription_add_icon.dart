import 'package:flutter/material.dart';

import '../../../../../../core/vendor/provider/subcategory/sub_category_provider.dart';
import '../../../../../vendor_ui/subcategory/component/vertical/widgets/subcat_subscription_add_icon.dart';

class CustomSubscriptionAddIcon extends StatelessWidget {
  const CustomSubscriptionAddIcon(
      {required this.subCategoryProvider, required this.changeMode});
  final SubCategoryProvider subCategoryProvider;
  final Function changeMode;

  @override
  Widget build(BuildContext context) {
    return SubscriptionAddIcon(
        subCategoryProvider: subCategoryProvider, changeMode: changeMode);
  }
}
