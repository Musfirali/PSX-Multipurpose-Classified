import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../../core/vendor/utils/ps_animation.dart';
import '../../../../../custom_ui/user/profile/component/detail_info/widgets/rating_widget.dart';
import '../../../../../custom_ui/user/user_detail/component/detail_info/widgets/other_user_follower_count.dart';
import '../../../../../custom_ui/user/user_detail/component/detail_info/widgets/other_user_following_count.dart';
import '../../../../../custom_ui/user/user_detail/component/detail_info/widgets/other_user_item_count.dart';
import '../../../../../custom_ui/user/user_detail/component/detail_info/widgets/other_user_joined_datetime_widget.dart';
import '../../../../../custom_ui/user/user_detail/component/detail_info/widgets/other_user_profile_photo.dart';
import '../../../../common/bluemark_icon.dart';

class OtherUserProfileDetailWidget extends StatelessWidget {
  const OtherUserProfileDetailWidget({
    Key? key,
    this.animationController,
  }) : super(key: key);

  final AnimationController? animationController;
  @override
  Widget build(BuildContext context) {
    final Animation<double>? animation = curveAnimation(animationController!);

    return SliverToBoxAdapter(child: Consumer<UserProvider>(
        builder: (BuildContext context, UserProvider provider, Widget? child) {
      if (provider.user.data != null) {
        animationController!.forward();
        return AnimatedBuilder(
            animation: animationController!,
            child: Column(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(width: PsDimens.space8),
                    CustomOtherUserProfilePhoto(),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: PsDimens.space10, top: PsDimens.space6),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                provider.user.data!.name ?? '',
                                textAlign: TextAlign.start,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge,
                                maxLines: 1,
                              ),
                              if (provider.user.data!.isVefifiedBlueMarkUser)
                                const BluemarkIcon(
                                  icon: Icons.verified_user,
                                ),
                            ],
                          ),
                          CustomRatingWidget(
                            user: provider.user.data,
                            starCount: 5,
                          ),
                          CustomOtherUserJoinDateTimeWidget(),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CustomOtherUserItemCount(),
                    CustomOtherUserFollowerCount(),
                    CustomOtherUserFollowingCount(),
                  ],
                ),
              ],
            ),
            builder: (BuildContext context, Widget? child) {
              return FadeTransition(
                  opacity: animation!,
                  child: Transform(
                      transform: Matrix4.translationValues(
                          0.0, 100 * (1.0 - animation.value), 0.0),
                      child: child));
            });
      } else {
        return const SizedBox();
      }
    }));
  }
}