import 'package:flutter/material.dart';
import 'package:psxmpc/config/ps_colors.dart';

import '../../../../../../config/route/route_paths.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../core/vendor/viewobject/holder/intent_holder/user_intent_holder.dart';
import '../../../../../../core/vendor/viewobject/user.dart';

class UserResultTextItem extends StatelessWidget {
  const UserResultTextItem({
    Key? key,
    required this.user,
    this.animationController,
    this.animation,
    this.isLoading = false,
  }) : super(key: key);
  final User user;
  final AnimationController? animationController;
  final Animation<double>? animation;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    animationController?.forward();
    return AnimatedBuilder(
        animation: animationController!,
        child: InkWell(
          highlightColor: PsColors.primary50,
          onTap: () {
            goToUserDetail(context, user);
          },
          child: Container(
            margin: const EdgeInsets.symmetric(
                vertical: PsDimens.space10, horizontal: PsDimens.space16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  user.name ?? '',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Utils.isLightMode(context) ? PsColors.text900: PsColors.text50,
                      fontSize: 16),
                ),
                const Icon(Icons.keyboard_arrow_right),
              ],
            ),
          ),
        ),
        builder: (BuildContext context, Widget? child) {
          return FadeTransition(
            opacity: animation!,
            child: Transform(
                transform: Matrix4.translationValues(
                    0.0, 100 * (1.0 - animation!.value), 0.0),
                child: child),
          );
        });
  }

  void goToUserDetail(BuildContext context, User user) {
    Navigator.pushNamed(context, RoutePaths.userDetail,
        arguments:
            UserIntentHolder(userId: user.userId, userName: user.name));
  }
}
