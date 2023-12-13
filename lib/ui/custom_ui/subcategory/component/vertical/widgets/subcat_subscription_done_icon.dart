import 'package:flutter/material.dart';

import '../../../../../../core/vendor/provider/subcategory/sub_category_provider.dart';
import '../../../../../vendor_ui/subcategory/component/vertical/widgets/subcat_subscription_done_icon.dart';

class CustomSubscriptionDoneIcon extends StatefulWidget {
  const CustomSubscriptionDoneIcon(
      {required this.subCategoryProvider, 
      required this.changeMode});
  final SubCategoryProvider subCategoryProvider;

  final Function changeMode;
  @override
  _SubCatSubscriptionDoneState createState() => _SubCatSubscriptionDoneState();
}

class _SubCatSubscriptionDoneState extends State<CustomSubscriptionDoneIcon> {
  @override
  Widget build(BuildContext context) {
    return SubscriptionDoneIcon(
        subCategoryProvider: widget.subCategoryProvider,
        changeMode: widget.changeMode);
  }
}
