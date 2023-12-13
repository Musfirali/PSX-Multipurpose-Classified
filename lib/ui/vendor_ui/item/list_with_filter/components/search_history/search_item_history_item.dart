import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';

import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/provider/search_item_history/search_item_history_provider.dart';
import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../core/vendor/viewobject/holder/delete_search_histroy_holder.dart';
import '../../../../../../core/vendor/viewobject/holder/product_parameter_holder.dart';
import '../../../../../../core/vendor/viewobject/search_item_history.dart';

class SearchItemHistoryItem extends StatelessWidget {
  const SearchItemHistoryItem(
      {required this.searchItemHistory});
  final SearchItemHistory searchItemHistory;

  @override
  Widget build(BuildContext context) {
    final ProductParameterHolder productParameterHolder = 
        ProductParameterHolder();
    final AppLocalization langProvider = 
        Provider.of<AppLocalization>(context);
        
    return InkWell(
      highlightColor: PsColors.primary50,
      onTap: () async {
        productParameterHolder.searchTerm = searchItemHistory.keyword;
        Navigator.pop(context, productParameterHolder);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
            vertical: PsDimens.space6, horizontal: PsDimens.space16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              searchItemHistory.keyword!,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: PsColors.text500,
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
            ),
            InkWell(
              onTap: () {
                onDelete(context, searchItemHistory, langProvider);
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
      SearchItemHistory searchItemHistory, AppLocalization langProvider) async {
    final PsValueHolder psValueHolder =
        Provider.of<PsValueHolder>(context, listen: false);
    final DeleteSearchHistoryHolder holder =
        DeleteSearchHistoryHolder(id: searchItemHistory.id);
    final SearchItemHistoryProvider provider =
        Provider.of<SearchItemHistoryProvider>(context, listen: false);
    await provider.deleteSearchItemHistoryList(holder.toMap(),
        psValueHolder.loginUserId, langProvider.currentLocale.languageCode);
    provider.loadDataList(reset: true);
  }
}
