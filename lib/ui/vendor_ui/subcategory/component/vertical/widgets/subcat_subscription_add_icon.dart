import 'package:flutter/material.dart';

import '../../../../../../core/vendor/provider/subcategory/sub_category_provider.dart';
import '../../../../../../core/vendor/utils/utils.dart';

class SubscriptionAddIcon extends StatelessWidget {
  const SubscriptionAddIcon(
      {required this.subCategoryProvider, required this.changeMode});
  final SubCategoryProvider subCategoryProvider;
  final Function changeMode;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.notification_add_outlined),
      onPressed: () async {
        if (await Utils.checkInternetConnectivity()) {
          Utils.navigateOnUserVerificationView(context, () {
            changeMode();
            subCategoryProvider.loadDataList(
              reset: true,
            );
          });
        }
      },
    );
  }
}
