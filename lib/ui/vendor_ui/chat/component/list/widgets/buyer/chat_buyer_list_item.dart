import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../../../config/route/route_paths.dart';
import '../../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/provider/chat/buyer_chat_history_list_provider.dart';
import '../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../core/vendor/viewobject/chat_history.dart';
import '../../../../../../../core/vendor/viewobject/holder/intent_holder/chat_history_intent_holder.dart';
import '../../../../../../../core/vendor/viewobject/holder/intent_holder/product_detail_intent_holder.dart';
import '../../../../../../../core/vendor/viewobject/holder/intent_holder/user_intent_holder.dart';
import '../../../../../../../core/vendor/viewobject/product.dart';
import '../../../../../common/ps_ui_widget.dart';

class ChatBuyerListItem extends StatelessWidget {
  const ChatBuyerListItem({
    Key? key,
    required this.chatHistory,
    this.animationController,
    this.animation,
  }) : super(key: key);

  final ChatHistory chatHistory;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    animationController?.forward();

    const Widget _spacingWidget = SizedBox(
      height: PsDimens.space2,
    );
    final Widget _dividerWidget = Divider(
      height: PsDimens.space1,
      color: Utils.isLightMode(context) ? PsColors.text300 : PsColors.text50,
      thickness: 0.2,
    );
    return AnimatedBuilder(
        animation: animationController!,
        child: InkWell(
          onTap: () {
            onTap(context);
          },
          child: Column(
            children: <Widget>[
              // _dividerWidget,
              Container(
                color: chatHistory.hasSellerUnreadCount
                    ? Utils.isLightMode(context)
                        ? PsColors.primary50
                        : PsColors.text700
                    : Utils.isLightMode(context)
                        ? PsColors.achromatic50
                        : PsColors.achromatic800,
                padding: const EdgeInsets.symmetric(
                    horizontal: PsDimens.space19, vertical: PsDimens.space8),
                child: Stack(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            Container(
                              width: PsDimens.space64,
                              height: PsDimens.space64,
                              child: PsNetworkCircleImageForUser(
                                photoKey: '',
                                imagePath: chatHistory.buyer!.userCoverPhoto,
                                boxfit: BoxFit.cover,
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, RoutePaths.userDetail,
                                      arguments: UserIntentHolder(
                                          userId: chatHistory.buyer!.userId,
                                          userName: chatHistory.buyer!.name));
                                },
                              ),
                            ),
                            Positioned(
                              bottom: 1,
                              right: 1,
                              child: Container(
                                width: PsDimens.space24,
                                height: PsDimens.space24,
                                child: PsNetworkCircleImage(
                                  photoKey: '',
                                  imagePath:
                                      chatHistory.item!.defaultPhoto?.imgPath,
                                  boxfit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: PsDimens.space16,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  chatHistory.buyer?.name == ''
                                      ? 'default__user_name'.tr
                                      : chatHistory.buyer?.name ?? '',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(
                                          fontSize: 14,
                                          color: Utils.isLightMode(context)
                                              ? PsColors.primary500
                                              : PsColors.primary300,
                                          fontWeight: FontWeight.w600),
                                ),

                                // if (chatHistory.seller!.isVefifiedBlueMarkUser)
                                //   const BluemarkIcon()
                              ],
                            ),
                            _spacingWidget,
                            Text(
                              chatHistory.item!.title!,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                            ),
                            _spacingWidget,
                            Text(
                              chatHistory.latestChatMessage ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      color: Utils.isLightMode(context)
                                          ? PsColors.text500
                                          : PsColors.text50,
                                      fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: 1,
                      right: Directionality.of(context) == TextDirection.ltr
                          ? 1
                          : 0,
                      left: Directionality.of(context) == TextDirection.ltr
                          ? 0
                          : 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            chatHistory.addedDateStr!,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    color: Utils.isLightMode(context)
                                        ? PsColors.text900
                                        : PsColors.text50),
                          ),
                          const SizedBox(height: PsDimens.space4),
                          if (chatHistory.hasSellerUnreadCount)
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: Utils.isLightMode(context)
                                    ? PsColors.primary500
                                    : PsColors
                                        .primary300, //PsColors.primary500,
                                borderRadius:
                                    BorderRadius.circular(PsDimens.space28),
                              ),
                              child: Center(
                                child: Text(chatHistory.sellerUnreadCount!,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                            color: Utils.isLightMode(context)
                                                ? PsColors.achromatic50
                                                : PsColors.achromatic800,
                                            fontSize: 10)),
                              ),
                            )
                          else
                            Icon(Icons.done_all,
                                color: Utils.isLightMode(context)
                                    ? PsColors.text50
                                    : PsColors.text300,
                                size: 16)
                        ],
                      ),
                    )
                  ],
                ),
              ),
              _dividerWidget
            ],
          ),
        ),
        builder: (BuildContext context, Widget? child) {
          return FadeTransition(
              opacity: animation!,
              child: Transform(
                  transform: Matrix4.translationValues(
                      0.0, 100 * (1.0 - animation!.value), 0.0),
                  child: child));
        });
  }

  Future<void> onTap(BuildContext context) async {
    final BuyerChatHistoryListProvider _provider =
        Provider.of<BuyerChatHistoryListProvider>(context, listen: false);
    await Navigator.pushNamed(context, RoutePaths.chatView,
        arguments: ChatHistoryIntentHolder(
            chatFlag: PsConst.CHAT_FROM_BUYER,
            itemId: chatHistory.item!.id,
            buyerUserId: chatHistory.buyerUserId,
            sellerUserId: chatHistory.sellerUserId,
            userCoverPhoto: chatHistory.buyer!.userCoverPhoto,
            userName: chatHistory.buyer!.name,
            itemDetail: chatHistory.item));
    _provider.loadDataList(reset: true);
  }

  void goToProductDetail(BuildContext context, Product product) {
    final ProductDetailIntentHolder holder = ProductDetailIntentHolder(
        productId: product.id,
        heroTagImage: product.id! + PsConst.HERO_TAG__IMAGE,
        heroTagTitle: product.id! + PsConst.HERO_TAG__TITLE);
    Navigator.pushNamed(context, RoutePaths.productDetail, arguments: holder);
  }
}
