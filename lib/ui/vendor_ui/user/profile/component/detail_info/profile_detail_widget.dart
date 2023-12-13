import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../../core/vendor/utils/ps_animation.dart';
import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../core/vendor/viewobject/user.dart';
import '../../../../../custom_ui/user/profile/component/detail_info/widgets/bluemark_info.dart';
import '../../../../../custom_ui/user/profile/component/detail_info/widgets/follower_count.dart';
import '../../../../../custom_ui/user/profile/component/detail_info/widgets/following_count.dart';
import '../../../../../custom_ui/user/profile/component/detail_info/widgets/join_date_widget.dart';
import '../../../../../custom_ui/user/profile/component/detail_info/widgets/own_item_count.dart';
import '../../../../../custom_ui/user/profile/component/detail_info/widgets/post_left_count.dart';
import '../../../../../custom_ui/user/profile/component/detail_info/widgets/profile_photo.dart';
import '../../../../../custom_ui/user/profile/component/detail_info/widgets/rating_widget.dart';
import '../../../../common/bluemark_icon.dart';

class ProfileDetailWidget extends StatefulWidget {
  const ProfileDetailWidget(
      {Key? key,
      required this.animationController,
      required this.callLogoutCallBack})
      : super(key: key);

  final AnimationController? animationController;
  final Function callLogoutCallBack;

  @override
  __ProfileDetailWidgetState createState() => __ProfileDetailWidgetState();
}

class __ProfileDetailWidgetState extends State<ProfileDetailWidget> {
  late Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    final PsValueHolder psValueHolder =
        Provider.of<PsValueHolder>(context, listen: false);
    animation = curveAnimation(widget.animationController!);
    const Widget _dividerWidget = Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Divider(
        height: 1,
      ),
    );

    return SliverToBoxAdapter(
      child: Consumer<UserProvider>(builder:
          (BuildContext context, UserProvider provider, Widget? child) {
        if (provider.hasData) {
          /**
               * UI SECTION
               */
          final User user = provider.user.data!;
          return AnimatedBuilder(
              animation: widget.animationController!,
              child: Column(
                children: <Widget>[
                  const SizedBox(height: PsDimens.space8),
                  CustomProfilePhoto(),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: PsDimens.space6,
                    ),
                    child: Column(
                      //crossAxisAlignment: CrossAxisAlignment.center,
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
                            if (user.isVefifiedBlueMarkUser)
                              const BluemarkIcon(icon: Icons.verified_user)
                          ],
                        ),
                        CustomRatingWidget(
                          user: provider.user.data,
                          starCount: 5,
                        ),
                        const CustomJoinDateWidget(),
                        if (!user.isVefifiedBlueMarkUser)
                          const CustomBluemarkInfoWidget(),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      if (psValueHolder.isPaidApp == PsConst.ONE)
                        CustomPostLeftInfo(),
                      CustomOwnerItemCountInfo(),
                      CustomFollowerCount(),
                      CustomFollowingCount(),
                    ],
                  ),
                  _dividerWidget,
                ],
              ),
              builder: (BuildContext context, Widget? child) {
                return FadeTransition(
                    opacity: animation,
                    child: Transform(
                        transform: Matrix4.translationValues(
                            0.0, 100 * (1.0 - animation.value), 0.0),
                        child: child));
              });
        } else {
          return const SizedBox();
        }
      }),
    );
  }
}
