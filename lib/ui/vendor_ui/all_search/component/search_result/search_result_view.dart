import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/vendor/api/common/ps_status.dart';
import '../../../../../core/vendor/provider/all_search/all_search_result_provider.dart';
import '../../../../custom_ui/all_search/component/search_result/category/category_result_list_widget.dart';
import '../../../../custom_ui/all_search/component/search_result/item/item_result_list_widget.dart';
import '../../../../custom_ui/all_search/component/search_result/user/user_result_list_widget.dart';
import '../../../../custom_ui/item/list_with_filter/components/item/widgets/item_list_empty_box.dart';
import '../../../common/ps_ui_widget.dart';

class SearchAllResultView extends StatelessWidget {
  const SearchAllResultView({required this.animationController});
  final AnimationController animationController;
  @override
  Widget build(BuildContext context) {
    return Consumer<AllSearchResultProvider>(builder: (BuildContext context,
        AllSearchResultProvider provider, Widget? child) {
      final bool hasData = provider.hasCategoryList ||
          provider.hasProductList ||
          provider.hasUserList;
      return Flexible(
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child:
                  (hasData || provider.currentStatus == PsStatus.BLOCK_LOADING)
                      ? Column(
                          children: <Widget>[
                            CustomUserResultListWidget(
                              animationController: animationController,
                            ),
                            CustomCategoryResultListWidget(
                              animationController: animationController,
                            ),
                            CustomItemResultListWidget(
                              animationController: animationController,
                            )
                          ],
                        )
                      : (provider.currentStatus != PsStatus.PROGRESS_LOADING &&
                              provider.currentStatus != PsStatus.NOACTION)
                          ? CustomItemListEmptyBox()
                          : const SizedBox(),
            ),
            PSProgressIndicator(provider.currentStatus),
          ],
        ),
      );
    });
  }
}
