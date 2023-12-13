import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../config/ps_colors.dart';
import '../../../../../core/vendor/api/common/ps_resource.dart';
import '../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../core/vendor/utils/utils.dart';
import '../../../../../core/vendor/viewobject/holder/user_follow_holder.dart';
import '../../../../../core/vendor/viewobject/user.dart';
import '../../../common/dialog/error_dialog.dart';

class FollowWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FollowWidgetState();
}

class _FollowWidgetState extends State<FollowWidget> {
  late UserProvider userProvider;
  late AppLocalization langProvider;
  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UserProvider>(context);
    langProvider = Provider.of<AppLocalization>(context);
    return SliverToBoxAdapter(
      child: Container(
          margin: const EdgeInsets.only(
              top: PsDimens.space12, bottom: PsDimens.space6),
          width: double.infinity,
          child: userProvider.user.data!.isFollowed == PsConst.ONE
              ? MaterialButton(
                  color:  PsColors.achromatic200,
                  height: 40,
                  shape: const BeveledRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(2.0)),
                  ),
                  child: Text(
                    'user_detail__unfollow'.tr,
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: Utils.isLightMode(context)
                            ? Theme.of(context).primaryColor
                            : PsColors.achromatic900),
                  ),
                  onPressed: () async {
                    onTap();
                  },
                )
              : MaterialButton(
                  color: Theme.of(context).primaryColor,
                  height: 40,
                  shape: const BeveledRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  ),
                  child: Text(
                    'user_detail__follow'.tr,
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: Utils.isLightMode(context) ? PsColors.achromatic50: PsColors.text800),
                  ),
                  onPressed: () async {
                    onTap();
                  },
                )),
    );
  }

  Future<void> onTap() async {
    if (await Utils.checkInternetConnectivity()) {
      Utils.navigateOnUserVerificationView(context, () async {
        if (userProvider.user.data!.isFollowed == PsConst.ZERO) {
          setState(() {
            userProvider.user.data!.isFollowed = PsConst.ONE;
          });
        } else {
          setState(() {
            userProvider.user.data!.isFollowed = PsConst.ZERO;
          });
        }

        final UserFollowHolder userFollowHolder = UserFollowHolder(
            userId: userProvider.psValueHolder!.loginUserId,
            followedUserId: userProvider.user.data!.userId);

        final PsResource<User> _user = await userProvider.postUserFollow(
            userFollowHolder.toMap(),
            userProvider.psValueHolder!.loginUserId!,
            langProvider.currentLocale.languageCode);
        if (_user.data != null) {
          if (_user.data!.isFollowed == PsConst.ONE) {
            userProvider.user.data!.isFollowed = PsConst.ONE;
          } else {
            userProvider.user.data!.isFollowed = PsConst.ZERO;
          }
        }
      });
    } else {
      showDialog<dynamic>(
          context: context,
          builder: (BuildContext context) {
            return ErrorDialog(
              message: 'error_dialog__no_internet'.tr,
            );
          });
    }
  }
}
