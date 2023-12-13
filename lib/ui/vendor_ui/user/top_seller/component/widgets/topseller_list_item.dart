import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/core/vendor/api/common/ps_resource.dart';
import 'package:psxmpc/core/vendor/constant/ps_constants.dart';
import 'package:psxmpc/core/vendor/viewobject/holder/user_follow_holder.dart';
import 'package:psxmpc/ui/vendor_ui/common/dialog/error_dialog.dart';
import 'package:psxmpc/ui/vendor_ui/common/smooth_star_rating_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../config/route/route_paths.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../core/vendor/viewobject/holder/intent_holder/user_intent_holder.dart';
import '../../../../../../core/vendor/viewobject/user.dart';
import '../../../../common/bluemark_icon.dart';
import '../../../../common/ps_ui_widget.dart';
import '../../../../common/shimmer_item.dart';

class TopSellerListItem extends StatefulWidget {
  const TopSellerListItem(
      {Key? key,
      required this.user,
      this.animation,
      this.animationController,
      this.isLoading = false,
      this.width})
      : super(key: key);

  final User user;
  final AnimationController? animationController;
  final Animation<double>? animation;
  final bool isLoading;
  final double? width;

  @override
  State<TopSellerListItem> createState() => _UserVerticalListItemState();
}

class _UserVerticalListItemState extends State<TopSellerListItem> {
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
          width: widget.width ?? MediaQuery.of(context).size.width,
          height: 170,
          margin: const EdgeInsets.only(
              bottom: PsDimens.space16,
              left: PsDimens.space8,
              right: PsDimens.space8),
          child: widget.isLoading
              ? const ShimmerItem()
              : InkWell(
                  onTap: () {
                    onTap(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Utils.isLightMode(context)
                          ? PsColors.text50
                          : PsColors.achromatic800,
                      border: Border.all(
                          width: 0.8,
                          color: Utils.isLightMode(context)
                              ? PsColors.text50
                              : PsColors.text800),
                      borderRadius: const BorderRadius.all(
                          Radius.circular(PsDimens.space8)),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: PsDimens.space6),
                    child: Column(
                       mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Stack(
                                children: <Widget>[
                                  Container(
                                    width: PsDimens.space44,
                                    height: PsDimens.space44,
                                    child: PsNetworkCircleImageForUser(
                                      photoKey: '',
                                      imagePath:
                                          widget.user.userCoverPhoto ?? '',
                                      boxfit: BoxFit.cover,
                                      onTap: () {
                                        onTap(context);
                                      },
                                    ),
                                  ),
                                  if (widget.user.isVefifiedBlueMarkUser)
                                    const Positioned(
                                        right: -1,
                                        bottom: -1,
                                        child: BluemarkIcon())
                                ],
                              ),
                              const SizedBox(
                                width: PsDimens.space6,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
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
                                                      fontSize: 16,
                                                      color: Utils.isLightMode(
                                                              context)
                                                          ? PsColors.text800
                                                          : PsColors.text50,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                        ),
                                        const SizedBox(width: PsDimens.space2),
                                      ],
                                    ),
                                    const SizedBox(height: PsDimens.space2),
                                    UserRatingWidget(
                                      user: widget.user,
                                      size: 16,
                                      starCount: 5,
                                      showRatingCount: true,
                                    ),
                                    // const SizedBox(
                                    //   height: PsDimens.space4,
                                    // ),
                                    // Text(
                                    //     '${widget.user.followerCount} ' +
                                    //         'profile__follower'.tr +
                                    //         ', ${widget.user.activeItemCount} ' +
                                    //         'Items'.tr,
                                    //     overflow: TextOverflow.ellipsis,
                                    //     maxLines: 1,
                                    //     style: Theme.of(context)
                                    //         .textTheme
                                    //         .titleSmall!
                                    //         .copyWith(
                                    //             fontSize: 14,
                                    //             color: Utils.isLightMode(context) ? PsColors.text300: PsColors.text50,
                                    //             fontWeight: FontWeight.w500)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: PsDimens.space10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.shopping_cart,
                                  size: 18,
                                  color: PsColors.text600,
                                ),
                                Text(
                                    '${widget.user.activeItemCount} ' +
                                        'top_rated_items'.tr,
                                    // ', ${widget.user.activeItemCount} ' +
                                    // 'Items'.tr,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                            fontSize: 14,
                                            color: Utils.isLightMode(context)
                                                ? PsColors.text600
                                                : PsColors.text50,
                                            fontWeight: FontWeight.w500)),
                              ],
                            ),
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.supervisor_account,///
                                      size: 18,
                                      color: PsColors.text600,
                                    ),
                                    Flexible(
                                      child: Text(
                                          '${widget.user.followerCount} ' +
                                              'profile__follower'.tr,
                                          // ', ${widget.user.activeItemCount} ' +
                                          // 'Items'.tr,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(
                                                  fontSize: 14,
                                                  color: Utils.isLightMode(context)
                                                      ? PsColors.text600
                                                      : PsColors.text50,
                                                  fontWeight: FontWeight.w500)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        // if (!Utils.isActiveLoginUser(
                        //     psValueHolder, widget.user.userId!))
                        Row(
                          children: <Widget>[
                            //phone
                            if (widget.user.showPhone && widget.user.hasPhone)
                              Container(
                                width: 26,
                                height: 26,
                                decoration: BoxDecoration(
                                  color: Utils.isLightMode(context)
                                      ? PsColors.achromatic50
                                      : PsColors.achromatic800,
                                  border: Border.all(
                                      width: 0.8,
                                      color: Utils.isLightMode(context)
                                          ? PsColors.achromatic50
                                          : PsColors.text800),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(PsDimens.space4)),
                                ),
                                child: InkWell(
                                    onTap: () async {
                                      if (await canLaunchUrl(Uri.parse(
                                          'tel://${widget.user.userPhone}'))) {
                                        await launchUrl(Uri.parse(
                                            'tel://${widget.user.userPhone}'));
                                      } else {
                                        throw 'Could not Call Phone Number 1';
                                      }
                                    },
                                    child: Icon(Icons.call,
                                        size: 16,
                                        color: Utils.isLightMode(context)
                                            ? PsColors.primary500
                                            : PsColors.primary300)),
                              ),
                            const SizedBox(
                              width: PsDimens.space8,
                            ),
                            if (widget.user.showEmail)
                              Container(
                                width: 26,
                                height: 26,
                                decoration: BoxDecoration(
                                  color: Utils.isLightMode(context)
                                      ? PsColors.achromatic50
                                      : PsColors.achromatic800,
                                  border: Border.all(
                                      width: 0.8,
                                      color: Utils.isLightMode(context)
                                          ? PsColors.achromatic50
                                          : PsColors.text800),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(PsDimens.space4)),
                                ),
                                child: InkWell(
                                  onTap: () async {
                                    final Uri uri = Uri(
                                      scheme: 'mailto',
                                      path: widget.user.userEmail,
                                    );
                                    if (await canLaunchUrl(uri)) {
                                      await launchUrl(uri);
                                    } else {
                                      throw 'Could not mail';
                                    }
                                  },
                                  child: Icon(Icons.email,
                                      size: 16,
                                      color: Utils.isLightMode(context)
                                          ? PsColors.primary500
                                          : PsColors.primary300),
                                ),
                              ),
                            const SizedBox(
                              width: PsDimens.space8,
                            ),

                            ///if (notOwnUserData) CustomFollowWidget(),
                            //   if (notOwnUserData)

                            Flexible(
                              child: Visibility(
                                visible: !Utils.isActiveLoginUser(
                                    psValueHolder, widget.user.userId!),
                                maintainSize: true,
                                maintainAnimation: true,
                                maintainState: true,
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width ,
                                  // widget.user.isFollowed == PsConst.ONE ? 96 : 100,
                                  child: MaterialButton(
                                    elevation: 0,
                                      color: widget.user.isFollowed == PsConst.ONE
                                          ? PsColors.achromatic50
                                          : PsColors.achromatic50,
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
                                                      color: PsColors.text800),
                                            )
                                          : Text(
                                              'profile__follow'.tr,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge!
                                                  .copyWith(
                                                      color: PsColors.text800),
                                            ),
                                      onPressed: () async {
                                        if (await Utils
                                            .checkInternetConnectivity()) {
                                          Utils.navigateOnUserVerificationView(
                                              context, () async {
                                            if (widget.user.isFollowed ==
                                                PsConst.ZERO) {
                                              setState(() {
                                                widget.user.isFollowed =
                                                    PsConst.ONE;
                                              });
                                            } else {
                                              setState(() {
                                                widget.user.isFollowed =
                                                    PsConst.ZERO;
                                              });
                                            }
                            
                                            final UserFollowHolder
                                                userFollowHolder = UserFollowHolder(
                                                    userId: userProvider
                                                        .psValueHolder!
                                                        .loginUserId,
                                                    followedUserId:
                                                        widget.user.userId);
                            
                                            final PsResource<User> _user =
                                                await userProvider.postUserFollow(
                                                    userFollowHolder.toMap(),
                                                    userProvider.psValueHolder!
                                                        .loginUserId!,
                                                    langProvider.currentLocale
                                                        .languageCode);
                                            if (_user.data != null) {
                                              if (_user.data!.isFollowed ==
                                                  PsConst.ONE) {
                                                widget.user.isFollowed =
                                                    PsConst.ONE;
                                              } else {
                                                widget.user.isFollowed =
                                                    PsConst.ZERO;
                                              }
                                            }
                                          });
                                        } else {
                                          showDialog<dynamic>(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return ErrorDialog(
                                                  message:
                                                      'error_dialog__no_internet'
                                                          .tr,
                                                );
                                              });
                                        }
                            
                                        // widget.onClick(context);
                                      }),
                                ),
                              ),
                            )
                          ],
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

class UserRatingWidget extends StatelessWidget {
  const UserRatingWidget({
    Key? key,
    required this.user,
    this.starCount,
    this.size,
    this.showRatingCount,
  }) : super(key: key);

  final User? user;
  final int? starCount;
  final double? size;
  final bool? showRatingCount;
  @override
  Widget build(BuildContext context) {
    final String? rating =
        user!.overallRating != '' ? user!.overallRating : '0';
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, RoutePaths.ratingList,
                arguments: user!.userId);
          },
          child: SmoothStarRating(
              key: Key(rating ?? '0'),
              rating: double.parse(rating ?? '0'),
              allowHalfRating: false,
              isReadOnly: true,
              size: size ?? 25,
              starCount: starCount ?? 1,
              color: PsColors.warning500,
              borderColor: PsColors.warning500,
              onRated: (double? v) async {},
              spacing: 0.0),
        ),
        const SizedBox(
          width: PsDimens.space6,
        ),
        if (showRatingCount != false)
          Flexible(
            child: Text(
              rating ?? '0',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Utils.isLightMode(context)
                      ? PsColors.achromatic600
                      : PsColors.text50,
                  fontSize: 14),
            ),
          ),
        //         Padding(
        //   padding: const EdgeInsets.only(right: 6.0),
        //   child: Text(
        //     rating ?? '0',
        //     style: Theme.of(context).textTheme.bodyLarge!.copyWith(
        //         color: Utils.isLightMode(context)
        //             ? PsColors.achromatic600 : PsColors.text50,
        //         fontSize: 14),
        //   ),
        // ),
      ],
    );
  }
}
