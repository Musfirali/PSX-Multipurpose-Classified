import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../../core/vendor/provider/product/product_provider.dart';
import '../../../../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../../core/vendor/viewobject/holder/intent_holder/user_intent_holder.dart';
import '../../../../../../../../core/vendor/viewobject/product.dart';
import '../../../../../../../../core/vendor/viewobject/user.dart';
import '../../../../../../config/route/route_paths.dart';
import '../../../../common/bluemark_icon.dart';
import '../../../../common/ps_ui_widget.dart';
import '../../../../common/user_rating_widget.dart';

class SellerInfoTileView extends StatefulWidget {
  @override
  State<SellerInfoTileView> createState() => _SellerInfoTileViewState();
}

class _SellerInfoTileViewState extends State<SellerInfoTileView> {
  late UserProvider userProvider;

  @override
  Widget build(BuildContext context) {
    final ItemDetailProvider provider =
        Provider.of<ItemDetailProvider>(context);

    final User? productOwner = provider.productOwner;
    if (productOwner == null)
      return const SliverToBoxAdapter(child: SizedBox());

    return SliverToBoxAdapter(
      child: InkWell(
        onTap: () {
          onSellerInfoClick(context, provider.product);
        },
        child: Container(
          margin: const EdgeInsets.only(
              left: PsDimens.space16,
              right: PsDimens.space16,
              top: PsDimens.space16),
          decoration: BoxDecoration(
            color: Utils.isLightMode(context)
                ? PsColors.text50
                : PsColors.achromatic700,
            borderRadius:
                const BorderRadius.all(Radius.circular(PsDimens.space4)),
          ),
          child: Padding(
              padding: const EdgeInsets.only(
                  top: PsDimens.space16,
                  bottom: PsDimens.space16,
                  left: PsDimens.space16,
                  right: PsDimens.space16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //image
                  Container(
                    width: 50,
                    height: 50,
                    child: PsNetworkCircleImageForUser(
                      photoKey: '',
                      imagePath: provider.product.user!.userCoverPhoto,
                      boxfit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    width: PsDimens.space16,
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            //username
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 4.0, bottom: 4.0),
                                child: Text(
                                    provider.product.user!.name == ''
                                        ? 'default__user_name'.tr
                                        : provider.product.user!.name ?? '',
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!,)
                              ),
                            ),
                            if (productOwner.isVefifiedBlueMarkUser)
                              const BluemarkIcon()
                          ],
                        ),
                        //phone
                        if (productOwner.showPhone &&
                            provider.productOwner!.hasPhone)
                          Visibility(
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.phone,
                                    color: Utils.isLightMode(context)
                                        ? PsColors.text900
                                        : PsColors.text50),
                                const SizedBox(
                                  width: PsDimens.space8,
                                ),
                                InkWell(
                                  child: Text(
                                    provider.product.user!.userPhone ?? '',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge,
                                  ),
                                  onTap: () async {
                                    if (await canLaunchUrl(Uri.parse(
                                        'tel://${provider.product.user!.userPhone}'))) {
                                      await launchUrl(Uri.parse(
                                          'tel://${provider.product.user!.userPhone}'));
                                    } else {
                                      throw 'Could not Call Phone Number 1';
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        if (productOwner.showEmail)
                          Visibility(
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.email,
                                    color: Utils.isLightMode(context)
                                        ? PsColors.text900
                                        : PsColors.text50),
                                const SizedBox(
                                  width: PsDimens.space8,
                                ),
                                Text(
                                  provider.product.user!.userEmail ?? '',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge,
                                ),
                              ],
                            ),
                          ),
                        UserRatingWidget(
                          user: provider.product.user,
                        ),
                        if (provider.product.user!.userAboutMe != '')
                          Text(provider.product.user!.userAboutMe ?? '',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      color: Utils.isLightMode(context)
                                          ? PsColors.text500
                                          : PsColors.text50)),
                      ],
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }

  void onSellerInfoClick(BuildContext context, Product product) {
    Navigator.pushNamed(context, RoutePaths.userDetail,
        arguments: UserIntentHolder(
            userId: product.addedUserId, userName: product.user?.name ?? ''));
  }
}
