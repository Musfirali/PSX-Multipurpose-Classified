import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';

import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../core/vendor/provider/search_subcategory_history/search_subcategory_history_provider.dart';
import '../../../../../core/vendor/provider/subcategory/sub_category_provider.dart';
import '../../../../../core/vendor/viewobject/holder/delete_search_histroy_holder.dart';
import '../../../../../core/vendor/viewobject/search_subcategory_history.dart';

class SearchSubCategoryHistoryItem extends StatelessWidget {
  const SearchSubCategoryHistoryItem(
      {required this.searchSubCategoryHistory});
  final SearchSubCategoryHistory searchSubCategoryHistory;

  @override
  Widget build(BuildContext context) {
    final SubCategoryProvider subCategoryProvider = 
        Provider.of<SubCategoryProvider>(context, listen: false);
    final AppLocalization langProvider = 
        Provider.of<AppLocalization>(context);

    return InkWell(
      highlightColor: PsColors.primary50,
      onTap: () async {
        subCategoryProvider.subCategoryParameterHolder.keyword =
            searchSubCategoryHistory.keyword;
        Navigator.pop(context, subCategoryProvider.subCategoryParameterHolder);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
            vertical: PsDimens.space6, horizontal: PsDimens.space16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              searchSubCategoryHistory.keyword!,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: PsColors.text500,
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
            ),
            InkWell(
              onTap: () {
                onDelete(context, searchSubCategoryHistory, langProvider);
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
      SearchSubCategoryHistory searchSubCategoryHistory, AppLocalization langProvider) async {
    final PsValueHolder psValueHolder =
        Provider.of<PsValueHolder>(context, listen: false);
    final DeleteSearchHistoryHolder holder =
        DeleteSearchHistoryHolder(id: searchSubCategoryHistory.id);
    final SearchSubCategoryHistoryProvider provider =
        Provider.of<SearchSubCategoryHistoryProvider>(context, listen: false);
    await provider.deleteSearchSubCategoryHistoryList(holder.toMap(),
        psValueHolder.loginUserId, langProvider.currentLocale.languageCode);
    provider.loadDataList(reset: true);
  }
}
