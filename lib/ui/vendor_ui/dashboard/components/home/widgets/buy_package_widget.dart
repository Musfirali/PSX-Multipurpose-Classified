import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../../config/route/route_paths.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/utils/ps_animation.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';

class BuyPackageWidget extends StatefulWidget {
  const BuyPackageWidget({
    Key? key,
    required this.animationController,
  }) : super(key: key);

  final AnimationController? animationController;

  @override
  State<StatefulWidget> createState() => HomeBuyPackageWidgetState();
}

class HomeBuyPackageWidgetState extends State<BuyPackageWidget> {
  @override
  Widget build(BuildContext context) {
    final PsValueHolder? valueHolder = Provider.of<PsValueHolder>(context);
    return SliverToBoxAdapter(
        child: AnimatedBuilder(
            animation: widget.animationController!,
            child: Container(
              margin: const EdgeInsets.only(
                top: PsDimens.space4,
                left: PsDimens.space16,
                right: PsDimens.space16,
              ),
              child: Stack(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(PsDimens.space4),
                    child: Image.asset(
                      'assets/images/buy_package_background.png',
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 1,
                    bottom: 1,
                    left: 1,
                    right: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Choose the package that is suitable for you.'.tr,
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: PsColors.primary50),
                              maxLines: 2,
                            ),
                          ),
                          VerticalDivider(
                            color: Theme.of(context).primaryColor,
                            thickness: 0.18,
                          ),
                          InkWell(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius:
                                      BorderRadius.circular(PsDimens.space4),
                                ),
                                alignment: Alignment.center,
                                height: 46,
                                width: 100,
                                child: Text(
                                  'Buy Now'.tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      ?.copyWith(
                                          color: PsColors.primary50,
                                          fontWeight: FontWeight.w500),
                                ),
                              ),
                              onTap: () async {
                                if (await Utils.checkInternetConnectivity()) {
                                  Utils.navigateOnUserVerificationView(context,
                                      () async {
                                    await Navigator.pushNamed(
                                        context, RoutePaths.buyPackage,
                                        arguments: <String, dynamic>{
                                          'android': valueHolder!
                                              .packageAndroidKeyList,
                                          'ios': valueHolder.packageIOSKeyList
                                        });
                                  });
                                }
                              }),
                          // PSButtonWidgetRoundCorner(
                          //     colorData: PsColors.buttonColor,
                          //     hasShadow: false,
                          //     width: 100,
                          //     titleText: 'Buy Now'.tr,
                          //     onPressed: () async {
                          //       if (await Utils.checkInternetConnectivity()) {
                          //         Utils.navigateOnUserVerificationView(context,
                          //             () async {
                          //           await Navigator.pushNamed(
                          //               context, RoutePaths.buyPackage,
                          //               arguments: <String, dynamic>{
                          //                 'android':
                          //                     valueHolder!.packageAndroidKeyList,
                          //                 'ios': valueHolder.packageIOSKeyList
                          //               });
                          //         });
                          //       }
                          //     }),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            builder: (BuildContext context, Widget? child) {
              return FadeTransition(
                  opacity: curveAnimation(widget.animationController!),
                  child: Transform(
                      transform: Matrix4.translationValues(
                          0.0,
                          100 *
                              (1.0 -
                                  curveAnimation(widget.animationController!)
                                      .value),
                          0.0),
                      child: child));
            }));
  }
}
