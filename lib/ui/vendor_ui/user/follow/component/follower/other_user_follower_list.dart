import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/vendor/provider/user/user_list_provider.dart';
import '../../../../../../core/vendor/utils/ps_animation.dart';
import '../../../../../custom_ui/user/follow/component/user_vertical_list_item.dart';

class OtherUserFollowerList extends StatelessWidget {
  const OtherUserFollowerList({required this.animationController});
  final AnimationController animationController;
  @override
  Widget build(BuildContext context) {
    final UserListProvider provider = Provider.of<UserListProvider>(context);
    final int count = provider.userList.data!.length;
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return CustomUserVerticalListItem(
            animationController: animationController,
            animation:
                curveAnimation(animationController, count: count, index: index),
            user: provider.getListIndexOf(index),
          );
        },
        childCount: count,
      ),
    );
  }
}
