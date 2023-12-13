import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';

import '../../../../../../config/route/route_paths.dart';
import '../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/all_search/category_search_history_provider.dart';
import '../../../../../../core/vendor/provider/all_search/item_search_history_provider.dart';
import '../../../../../../core/vendor/provider/all_search/user_search_history_provider.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../core/vendor/viewobject/holder/delete_histroy_list_holder.dart';
import '../../../../../../core/vendor/viewobject/holder/intent_holder/product_list_intent_holder.dart';
import '../../../../../../core/vendor/viewobject/holder/intent_holder/search_user_intent_holder.dart';
import '../../../../../../core/vendor/viewobject/holder/product_parameter_holder.dart';
import '../../../../../../core/vendor/viewobject/search_history.dart';

class SearchHistoryTextItem extends StatelessWidget {
  const SearchHistoryTextItem({required this.searchHistory});
  final SearchHistory searchHistory;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: PsColors.primary50,
      onTap: () {
        onTap(context, searchHistory);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
            vertical: PsDimens.space6, horizontal: PsDimens.space16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              searchHistory.keyword!,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: PsColors.text500,
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
            ),
            InkWell(
              onTap: () {
                onDelete(context, searchHistory);
              },
              child: SizedBox(
                height: 20,
                child: Icon(
                  Icons.clear,
                  color: PsColors.achromatic500,
                  size: 16,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> onDelete(
      BuildContext context, SearchHistory searchHistory) async {
    final PsValueHolder psValueHolder =
        Provider.of<PsValueHolder>(context, listen: false);
    final AppLocalization langProvider = Provider.of<AppLocalization>(context);
    final DeleteHistoryParameterHolder holder =
        DeleteHistoryParameterHolder(ids: <dynamic>[searchHistory.id]);
    if (searchHistory.type == PsConst.USER) {
      final UserSearchHistoryProvider provider =
          Provider.of<UserSearchHistoryProvider>(context, listen: false);
      await provider.deleteSearchHistoryList(holder.toMap(),
          psValueHolder.loginUserId, langProvider.currentLocale.languageCode);
      provider.loadDataList(reset: true);
    } else if (searchHistory.type == PsConst.ITEM) {
      final ItemSearchHistoryProvider provider =
          Provider.of<ItemSearchHistoryProvider>(context, listen: false);
      await provider.deleteSearchHistoryList(holder.toMap(),
          psValueHolder.loginUserId, langProvider.currentLocale.languageCode);
      provider.loadDataList(reset: true);
    } else if (searchHistory.type == PsConst.CATEGORY) {
      final CategorySearchHistoryProvider provider =
          Provider.of<CategorySearchHistoryProvider>(context, listen: false);
      await provider.deleteSearchHistoryList(holder.toMap(),
          psValueHolder.loginUserId, langProvider.currentLocale.languageCode);
      provider.loadDataList(reset: true);
    }
  }

  void onTap(BuildContext context, SearchHistory searchHistory) {
    if (searchHistory.type == PsConst.USER) {
      Navigator.pushNamed(context, RoutePaths.searchUser,
          arguments: SearchUserIntentHolder(keyword: searchHistory.keyword));
    } else if (searchHistory.type == PsConst.ITEM) {
      final ProductParameterHolder parameterHolder =
          ProductParameterHolder().getRecentParameterHolder();
      parameterHolder.searchTerm = searchHistory.keyword;
      Navigator.pushNamed(context, RoutePaths.filterProductList,
          arguments: ProductListIntentHolder(
              appBarTitle: 'Item List'.tr,
              productParameterHolder: parameterHolder));
    } else if (searchHistory.type == PsConst.CATEGORY) {
      Navigator.pushNamed(context, RoutePaths.categoryList,
          arguments: searchHistory.keyword);
    }
  }
}
