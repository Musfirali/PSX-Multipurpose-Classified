import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';

import '../../../../../core/vendor/api/common/ps_status.dart';
import '../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../core/vendor/provider/search_category_history/search_category_history_provider.dart';
import '../../../../../core/vendor/utils/utils.dart';
import '../../../../custom_ui/category/component/search_history/search_category_history_widget.dart';

class SearchCategoryHistoryView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchCategoryHistoryProvider>(
        builder: (BuildContext context,
            SearchCategoryHistoryProvider provider,
            Widget? child) {
      final bool showResultSearch = provider.hasData;

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
                    'Recent Searches',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Utils.isLightMode(context)
                            ? PsColors.achromatic800
                            : PsColors.achromatic500,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                CustomSearchCategoryHistoryListWidget(
                    searchCategoryHistoryList: provider.searchCategoryHistory.data!),
              ],
            ),
          ),
        );
      else if (provider.currentStatus != PsStatus.PROGRESS_LOADING) {
        return Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(
              horizontal: PsDimens.space16, vertical: PsDimens.space8),
          child: Text(
            'No Recent Searches',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Utils.isLightMode(context)
                    ? PsColors.achromatic800
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
