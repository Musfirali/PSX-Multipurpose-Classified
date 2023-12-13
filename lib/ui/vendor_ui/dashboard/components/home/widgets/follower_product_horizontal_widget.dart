import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../../config/route/route_paths.dart';
import '../../../../../../core/vendor/api/common/ps_status.dart';
import '../../../../../../core/vendor/provider/product/item_list_from_followers_provider.dart';
import '../../../../../../core/vendor/utils/ps_animation.dart';
import '../../../../../custom_ui/item/list_item/product_horizontal_list_widget.dart';
import '../../../../common/ps_list_header_widget.dart';

class ItemListFromFollowersHorizontalListWidget extends StatelessWidget {
  const ItemListFromFollowersHorizontalListWidget({
    Key? key,
    required this.animationController,
  }) : super(key: key);

  final AnimationController? animationController;

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = curveAnimation(animationController!);
    return SliverToBoxAdapter(
      child: Consumer<ItemListFromFollowersProvider>(
        builder: (BuildContext context,
            ItemListFromFollowersProvider itemListFromFollowersProvider,
            Widget? child) {
          return AnimatedBuilder(
            animation: animationController!,
            child: (itemListFromFollowersProvider.hasLoginUserId &&
                    (itemListFromFollowersProvider.currentStatus ==
                            PsStatus.BLOCK_LOADING ||
                        itemListFromFollowersProvider.hasData))
                /**
                 * UI SECTION
                 *  */
                ? Column(
                    children: <Widget>[
                      PsListHeaderWidget(
                        headerName: 'dashboard__item_list_from_followers'.tr,
                        headerDescription: '',
                        viewAllClicked: () {
                          onFollowerItemsClicked(
                              context, itemListFromFollowersProvider);
                        },
                      ),
                      CustomProductHorizontalListWidget(
                        tagKey:
                            itemListFromFollowersProvider.hashCode.toString(),
                        productList: itemListFromFollowersProvider
                            .itemListFromFollowersList.data,
                        isLoading:
                            itemListFromFollowersProvider.currentStatus ==
                                PsStatus.BLOCK_LOADING,
                      ),
                    ],
                  )
                : const SizedBox(),
            builder: (BuildContext context, Widget? child) {
              return FadeTransition(
                opacity: animation,
                child: Transform(
                    transform: Matrix4.translationValues(
                        0.0, 100 * (1.0 - animation.value), 0.0),
                    child: child),
              );
            },
          );
        },
      ),
    );
  }

  void onFollowerItemsClicked(BuildContext context,
      ItemListFromFollowersProvider itemListFromFollowersProvider) {
    Navigator.pushNamed(context, RoutePaths.itemListFromFollower,
        arguments: <String, dynamic>{
          'userId': itemListFromFollowersProvider.psValueHolder!.loginUserId,
          'holder': itemListFromFollowersProvider.followUserItemParameterHolder
        });
  }
}
