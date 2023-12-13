import 'package:flutter/material.dart';

import '../../../../../../core/vendor/provider/subcategory/sub_category_provider.dart';
import '../../../../../vendor_ui/subcategory/component/vertical/widgets/subscription_actions_widget.dart';

class CustomSubscriptionActionWidgets extends StatefulWidget {
  const CustomSubscriptionActionWidgets({required this.subCategoryProvider});
  final SubCategoryProvider subCategoryProvider;
  @override
  _SubscriptionActionWidgets createState() => _SubscriptionActionWidgets();
}

class _SubscriptionActionWidgets
    extends State<CustomSubscriptionActionWidgets> {
  @override
  Widget build(BuildContext context) {
    return SubscriptionActionWidgets(
        subCategoryProvider: widget.subCategoryProvider);
  }
}
