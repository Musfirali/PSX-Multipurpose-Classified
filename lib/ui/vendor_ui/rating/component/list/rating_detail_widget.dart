import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../core/vendor/utils/utils.dart';
import '../../../common/smooth_star_rating_widget.dart';

class UserRatingDetailWidget extends StatefulWidget {
  const UserRatingDetailWidget({Key? key}) : super(key: key);

  @override
  _HeaderWidgetState createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<UserRatingDetailWidget> {
  @override
  Widget build(BuildContext context) {
    const Widget _spacingWidget = SizedBox(
      height: PsDimens.space10,
    );
    return SliverToBoxAdapter(
      child: Consumer<UserProvider>(builder:
          (BuildContext context, UserProvider userProvider, Widget? child) {
        if (userProvider.hasData) {
          return Padding(
            padding: const EdgeInsets.only(
                left: PsDimens.space12,
                right: PsDimens.space12,
                bottom: PsDimens.space8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _spacingWidget,
                Container(
                  alignment: Alignment.center,
                  child: Column(
                    children: <Widget>[
                      Text(
                          '${userProvider.user.data!.ratingDetail!.totalRatingCount} ',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(
                                  color: Utils.isLightMode(context) ? PsColors.text300: PsColors.text50, fontSize: 18)),
                      const SizedBox(
                        height: PsDimens.space4,
                      ),
                      SmoothStarRating(
                          key: Key(userProvider
                              .user.data!.ratingDetail!.totalRatingCount!),
                          rating: double.parse(userProvider
                              .user.data!.ratingDetail!.totalRatingCount!),
                          isReadOnly: true,
                          allowHalfRating: false,
                          starCount: 5,
                          size: PsDimens.space28,
                          color: PsColors.warning500,
                          borderColor: PsColors.achromatic500.withAlpha(100),
                          spacing: 0.0),
                      const SizedBox(
                        width: PsDimens.space100,
                      ),
                      Text(
                          '${userProvider.user.data!.ratingCount} ${'Ratings'.tr}',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(color: PsColors.achromatic500)),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return const SizedBox();
        }
      }),
    );
  }
}
