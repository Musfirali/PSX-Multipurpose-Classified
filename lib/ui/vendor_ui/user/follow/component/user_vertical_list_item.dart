import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';

import '../../../../../config/route/route_paths.dart';
import '../../../../../core/vendor/api/common/ps_resource.dart';
import '../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../core/vendor/utils/utils.dart';
import '../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../core/vendor/viewobject/holder/intent_holder/user_intent_holder.dart';
import '../../../../../core/vendor/viewobject/holder/user_follow_holder.dart';
import '../../../../../core/vendor/viewobject/user.dart';
import '../../../common/bluemark_icon.dart';
import '../../../common/dialog/error_dialog.dart';
import '../../../common/ps_ui_widget.dart';
import '../../../common/shimmer_item.dart';
import '../../../common/user_rating_widget.dart';

class UserVerticalListItem extends StatefulWidget {
  const UserVerticalListItem({
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
  State<UserVerticalListItem> createState() => _UserVerticalListItemState();
}

class _UserVerticalListItemState extends State<UserVerticalListItem> {
  void onTap(BuildContext context) {
    Navigator.pushNamed(context, RoutePaths.userDetail,
        arguments: UserIntentHolder(
            userId: widget.user.userId, userName: widget.user.name));
  }

  late UserProvider userProvider;
  late AppLocalization langProvider;
  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UserProvider>(context);
    langProvider = Provider.of<AppLocalization>(context);
    final PsValueHolder psValueHolder = Provider.of<PsValueHolder>(context);

    widget.animationController!.forward();
    return AnimatedBuilder(
        animation: widget.animationController!,
        child: Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(
              bottom: PsDimens.space16,
              left: PsDimens.space16,
              right: PsDimens.space16),
          child: widget.isLoading
              ? const ShimmerItem()
              : InkWell(
                  onTap: () {
                    onTap(context);
                  },
                  child: Container(
                    height: 80,
                    decoration: BoxDecoration(
                      color: Utils.isLightMode(context)
                          ? PsColors.achromatic50
                          : PsColors.achromatic400,
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: PsColors.achromatic500.withOpacity(0.3),
                          spreadRadius: 0.05,
                          blurRadius: 0.05,
                          offset:
                              const Offset(0, 1), // changes position of shadow
                        ),
                      ],
                      borderRadius: const BorderRadius.all(
                          Radius.circular(PsDimens.space8)),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: PsDimens.space16,
                        vertical: PsDimens.space8),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: PsDimens.space48,
                          height: PsDimens.space48,
                          child: PsNetworkCircleImageForUser(
                            photoKey: '',
                            imagePath: widget.user.userCoverPhoto ?? '',
                            boxfit: BoxFit.cover,
                            onTap: () {
                              onTap(context);
                            },
                          ),
                        ),
                        const SizedBox(
                          width: PsDimens.space16,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: widget.user.userAddress == ''
                                ? MainAxisAlignment.center
                                : MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                        widget.user.name == ''
                                            ? 'default__user_name'.tr
                                            : widget.user.name ?? '',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .copyWith(
                                                fontSize: 14,
                                                color:
                                                    Utils.isLightMode(context)
                                                        ? PsColors.text800 : PsColors.text50,
                                                fontWeight: FontWeight.w600)),
                                  ),
                                  if (widget.user.isVefifiedBlueMarkUser)
                                    const BluemarkIcon()
                                ],
                              ),
                              if (widget.user.userAddress != '')
                                Text(widget.user.userAddress ?? '',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                            fontSize: 12,
                                            color: Utils.isLightMode(context)
                                                ? PsColors.text800 : PsColors.text50,
                                            fontWeight: FontWeight.w400))
                              else
                                const SizedBox(height: PsDimens.space2),
                              UserRatingWidget(
                                user: widget.user,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: PsDimens.space16,
                        ),
                        if (!widget.user.isOwnUserData(
                            Utils.checkUserLoginId(psValueHolder)))
                          SizedBox(
                            width:
                                widget.user.isFollowed == PsConst.ONE ? 96 : 75,
                            child: MaterialButton(
                                color: widget.user.isFollowed == PsConst.ONE
                                    ? PsColors.text50
                                    : Theme.of(context).primaryColor,
                                height: PsDimens.space32,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(PsDimens.space4)),
                                ),
                                child: widget.user.isFollowed == PsConst.ONE
                                    ? Text(
                                        'profile__following'.tr,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge!
                                            .copyWith(
                                                color: Theme.of(context).primaryColor),
                                      )
                                    : Text(
                                        'profile__follow'.tr,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge!
                                            .copyWith(
                                                color:
                                                    Utils.isLightMode(context)
                                                        ? PsColors.text50
                                                        : Utils.isLightMode(context) ? PsColors.achromatic50 : PsColors.achromatic800),
                                      ),
                                onPressed: () async {
                                  if (await Utils.checkInternetConnectivity()) {
                                    Utils.navigateOnUserVerificationView(
                                        context, () async {
                                      if (widget.user.isFollowed ==
                                          PsConst.ZERO) {
                                        setState(() {
                                          widget.user.isFollowed = PsConst.ONE;
                                        });
                                      } else {
                                        setState(() {
                                          widget.user.isFollowed = PsConst.ZERO;
                                        });
                                      }

                                      final UserFollowHolder userFollowHolder =
                                          UserFollowHolder(
                                              userId: userProvider
                                                  .psValueHolder!.loginUserId,
                                              followedUserId:
                                                  widget.user.userId);

                                      final PsResource<User> _user =
                                          await userProvider.postUserFollow(
                                              userFollowHolder.toMap(),
                                              userProvider
                                                  .psValueHolder!.loginUserId!,
                                              langProvider
                                                  .currentLocale.languageCode);
                                      if (_user.data != null) {
                                        if (_user.data!.isFollowed ==
                                            PsConst.ONE) {
                                          widget.user.isFollowed = PsConst.ONE;
                                        } else {
                                          widget.user.isFollowed = PsConst.ZERO;
                                        }
                                      }
                                    });
                                  } else {
                                    showDialog<dynamic>(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return ErrorDialog(
                                            message:
                                                'error_dialog__no_internet'.tr,
                                          );
                                        });
                                  }

                                  // widget.onClick(context);
                                }),
                          )
                      ],
                    ),
                  ),
                ),
        ),
        builder: (BuildContext context, Widget? child) {
          return FadeTransition(
              opacity: widget.animation!,
              child: Transform(
                  transform: Matrix4.translationValues(
                      0.0, 100 * (1.0 - widget.animation!.value), 0.0),
                  child: child));
        });
  }
}
