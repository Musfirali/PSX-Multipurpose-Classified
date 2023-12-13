import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../core/vendor/api/common/ps_status.dart';
import '../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../core/vendor/provider/all_search/all_search_result_provider.dart';
import '../../../../../core/vendor/provider/all_search/category_search_history_provider.dart';
import '../../../../../core/vendor/provider/all_search/item_search_history_provider.dart';
import '../../../../../core/vendor/provider/all_search/user_search_history_provider.dart';
import '../../../../../core/vendor/utils/utils.dart';
import '../../../../custom_ui/all_search/component/search_result/history/search_history_widget.dart';

class HistoryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AllSearchResultProvider allSearchResultProvider =
        Provider.of<AllSearchResultProvider>(context);
    return Consumer3<CategorySearchHistoryProvider, ItemSearchHistoryProvider,
            UserSearchHistoryProvider>(
        builder: (BuildContext context,
            CategorySearchHistoryProvider categoryProvider,
            ItemSearchHistoryProvider itemProvider,
            UserSearchHistoryProvider userProvider,
            Widget? child) {
      //check recent searches has or not
      final bool showResultSearch = (allSearchResultProvider.showAll &&
              (categoryProvider.hasData ||
                  categoryProvider.hasData ||
                  itemProvider.hasData ||
                  userProvider.hasData)) ||
          (allSearchResultProvider.showOnlyCategoryList &&
              categoryProvider.hasData) ||
          (allSearchResultProvider.showOnlyUserList && userProvider.hasData) ||
          (allSearchResultProvider.showOnlyProductList && itemProvider.hasData);

      if (showResultSearch)
        return Flexible(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(
                      horizontal: PsDimens.space16, vertical: PsDimens.space8),
                  child: Text(
                    'all_search__recent_search'.tr,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Utils.isLightMode(context)
                            ? PsColors.text800
                            : PsColors.achromatic500,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                if (userProvider.hasData &&
                    allSearchResultProvider.showUserList)
                  CustomSearchHistoryListWidget(
                      title: 'all_search__user'.tr,
                      searchHistoryList: userProvider.searchHistory.data!,
                      hasLimit: allSearchResultProvider.showAll),
                if (categoryProvider.hasData &&
                    allSearchResultProvider.showCategoryList)
                  CustomSearchHistoryListWidget(
                      title: 'all_search__category'.tr,
                      searchHistoryList: categoryProvider.searchHistory.data!,
                      hasLimit: allSearchResultProvider.showAll),
                if (itemProvider.hasData &&
                    allSearchResultProvider.showProductList)
                  CustomSearchHistoryListWidget(
                      title: 'all_search__item'.tr,
                      searchHistoryList: itemProvider.searchHistory.data!,
                      hasLimit: allSearchResultProvider.showAll),
              ],
            ),
          ),
        );
      else if (categoryProvider.currentStatus != PsStatus.PROGRESS_LOADING &&
          itemProvider.currentStatus != PsStatus.PROGRESS_LOADING &&
          userProvider.currentStatus != PsStatus.PROGRESS_LOADING) {
        return Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(
              horizontal: PsDimens.space16, vertical: PsDimens.space8),
          child: Text(
            'No Recent Searches',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Utils.isLightMode(context)
                    ? PsColors.text800
                    : PsColors.achromatic500,
                fontWeight: FontWeight.w600),
          ),
        );
      } else {
        return const SizedBox();
      }
    });
  }
}
