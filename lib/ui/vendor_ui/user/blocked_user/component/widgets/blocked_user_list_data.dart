import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/vendor/provider/user/blocked_user_provider.dart';
import '../../../../../../core/vendor/utils/ps_animation.dart';
import '../../../../../custom_ui/user/blocked_user/component/widgets/blocked_user_vertical_list_item.dart';

class BlockUserListData extends StatelessWidget {
  const BlockUserListData({required this.animationController});
  final AnimationController animationController;
  @override
  Widget build(BuildContext context) {
    final BlockedUserProvider provider =
        Provider.of<BlockedUserProvider>(context);
    final int count = provider.dataLength;
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          print(provider.blockedUserList.data![index].userName);
          return CustomBlockedUserVerticalListItem(
            animationController: animationController,
            animation:
                curveAnimation(animationController, count: count, index: index),
            blockedUser: provider.getListIndexOf(index),
          );
        },
        childCount: provider.dataLength,
      ),
    );
  }
}
