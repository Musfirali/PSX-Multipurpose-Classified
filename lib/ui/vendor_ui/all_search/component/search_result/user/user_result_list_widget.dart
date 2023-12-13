import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';
import 'package:psxmpc/core/vendor/viewobject/common/ps_value_holder.dart';

import '../../../../../../config/route/route_paths.dart';
import '../../../../../../core/vendor/api/common/ps_status.dart';
import '../../../../../../core/vendor/provider/all_search/all_search_result_provider.dart';
import '../../../../../../core/vendor/utils/ps_animation.dart';
import '../../../../../../core/vendor/viewobject/holder/intent_holder/search_user_intent_holder.dart';
import '../../../../../../core/vendor/viewobject/user.dart';
import '../../../../../custom_ui/all_search/component/search_result/user/user_result_list_text_item.dart';
import '../../../../../custom_ui/user/follow/component/user_vertical_list_item.dart';
import '../../../../common/ps_list_header_widget.dart';

class UserResultListWidget extends StatelessWidget {
  const UserResultListWidget({required this.animationController});
  final AnimationController animationController;
  @override
  Widget build(BuildContext context) {
    final AllSearchResultProvider provider =
        Provider.of<AllSearchResultProvider>(context);
    final PsValueHolder valueHolder =
        Provider.of<PsValueHolder>(context, listen: false);
    if ((provider.hasUserList ||
            provider.currentStatus == PsStatus.BLOCK_LOADING) &&
        provider.showUserList) {
      final bool isLoading = provider.currentStatus == PsStatus.BLOCK_LOADING;
      final int count = isLoading
          ? valueHolder.loadingShimmerItemCount!
          : provider.userListLength;
      return Column(
        children: <Widget>[
          PsListHeaderWidget(
              headerName: 'all_search__user'.tr,
              viewAllClicked: () {
                Navigator.pushNamed(context, RoutePaths.searchUser,
                    arguments: SearchUserIntentHolder(
                        keyword:
                            provider.allSearchParameterHolder.keyword ?? ''));
              }),
          ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              primary: false,
              shrinkWrap: true,
              itemCount: count,
              itemBuilder: (BuildContext context, int index) {
                final User user = provider.getUserAtIndex(index);
                if (provider.showAll)
                  return CustomUserResultTextItem(
                    animationController: animationController,
                    animation: curveAnimation(animationController,
                        count: count, index: index),
                    user: isLoading ? User() : user,
                    isLoading: isLoading,
                  );
                else if (provider.showOnlyUserList)
                  return CustomUserVerticalListItem(
                    animationController: animationController,
                    animation: curveAnimation(animationController,
                        count: count, index: index),
                    user: isLoading ? User() : user,
                    isLoading: isLoading,
                  );
                else {
                  return const SizedBox();
                }
              })
        ],
      );
    } else
      return const SizedBox();
  }
}
