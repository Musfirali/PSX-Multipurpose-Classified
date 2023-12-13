import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/core/vendor/provider/category/category_provider.dart';

import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../core/vendor/provider/search_category_history/search_category_history_provider.dart';
import '../../../../../core/vendor/viewobject/holder/delete_search_histroy_holder.dart';
import '../../../../../core/vendor/viewobject/search_category_history.dart';

class SearchCategoryHistoryItem extends StatelessWidget {
  const SearchCategoryHistoryItem(
      {required this.searchCategoryHistory});
  final SearchCategoryHistory searchCategoryHistory;

  @override
  Widget build(BuildContext context) {
    final CategoryProvider categoryProvider = 
        Provider.of<CategoryProvider>(context, listen: false);
    final AppLocalization langProvider = 
        Provider.of<AppLocalization>(context);

    return InkWell(
      highlightColor: PsColors.primary50,
      onTap: () async {
        categoryProvider.categoryParameterHolder.keyword =
            searchCategoryHistory.keyword;
        Navigator.pop(context, categoryProvider.categoryParameterHolder);
      
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
            vertical: PsDimens.space6, horizontal: PsDimens.space16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              searchCategoryHistory.keyword!,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: PsColors.text500,
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
            ),
            InkWell(
              onTap: () {
                onDelete(context, searchCategoryHistory, langProvider);
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

  Future<void> onDelete( BuildContext context, 
      SearchCategoryHistory searchCategoryHistory, AppLocalization langProvider) async {
    final PsValueHolder psValueHolder =
        Provider.of<PsValueHolder>(context, listen: false);
    final DeleteSearchHistoryHolder holder =
        DeleteSearchHistoryHolder(id: searchCategoryHistory.id);
    final SearchCategoryHistoryProvider provider =
        Provider.of<SearchCategoryHistoryProvider>(context, listen: false);
    await provider.deleteSearchCategoryHistoryList(holder.toMap(),
        psValueHolder.loginUserId, langProvider.currentLocale.languageCode);
    provider.loadDataList(reset: true);
  }
}
