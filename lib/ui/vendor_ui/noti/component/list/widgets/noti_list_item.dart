import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';

import '../../../../../../config/route/route_paths.dart';
import '../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/provider/noti/noti_provider.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../core/vendor/viewobject/holder/intent_holder/chat_history_intent_holder.dart';
import '../../../../../../core/vendor/viewobject/holder/noti_post_parameter_holder.dart';
import '../../../../../../core/vendor/viewobject/noti.dart';
import '../../../../common/ps_ui_widget.dart';

class NotiListItem extends StatelessWidget {
  const NotiListItem({
    Key? key,
    required this.noti,
    this.animationController,
    this.animation,
  }) : super(key: key);

  final Noti noti;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    final NotiProvider? notiProvider = Provider.of<NotiProvider>(context);
    final PsValueHolder psValueHolder = Provider.of<PsValueHolder>(context);
    final AppLocalization? langProvider = Provider.of<AppLocalization>(context);

    animationController!.forward();
    return AnimatedBuilder(
        animation: animationController!,
        child: Container(
          child: Material(
            child: InkWell(
              onTap: () {
                onTap(context);
              },
              child: Container(
                color: noti.isRead == '0'
                    ? Utils.isLightMode(context)
                        ? PsColors.primary50
                        : PsColors.text700
                    : Utils.isLightMode(context) ? PsColors.achromatic50 : PsColors.achromatic800,
                child: Column(
                  children: <Widget>[
                    Container(
                        padding: const EdgeInsets.only(
                            left: PsDimens.space18,
                            right: PsDimens.space12,
                            top: PsDimens.space12,
                            bottom: PsDimens.space12),
                        child: Column(
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                if (noti.type == PsConst.CHAT_MESSAGE)
                                  Icon(
                                    Icons.mail,
                                    color: PsColors.achromatic500,
                                  )
                                else if (noti.type == PsConst.OFFER_REJECTED)
                                  Icon(
                                    Icons.cancel,
                                    color: PsColors.error500,
                                  )
                                else if (noti.type == PsConst.OFFER_RECEIVED)
                                  Icon(
                                    Icons.sell,
                                    color: PsColors.info500,
                                  )
                                else if (noti.type == PsConst.OFFER_ACCEPTED)
                                  Icon(
                                    Icons.check_circle,
                                    color: PsColors.success500,
                                  )
                                else if (noti.type == PsConst.PUSH_NOTI)
                                  ClipRRect(
                                    child: Container(
                                      width: PsDimens.space24,
                                      height: PsDimens.space24,
                                      child: PsNetworkImage(
                                        photoKey: '',
                                        defaultPhoto: noti.defaultPhoto,
                                        imageAspectRation:
                                            PsConst.Aspect_Ratio_1x,
                                        onTap: () {
                                          onTap(context);
                                        },
                                      ),
                                    ),
                                  ),
                                const SizedBox(
                                  width: PsDimens.space18,
                                ),
                                Flexible(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(noti.message!,
                                            textAlign: TextAlign.start,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall!
                                                .copyWith(
                                                    fontWeight: FontWeight.w400,
                                                    color: Utils.isLightMode(
                                                            context)
                                                        ? PsColors.text800 : PsColors.text50)),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: PsDimens.space4),
                                        alignment: Alignment.topRight,
                                        child: Text(
                                          noti.addedDateStr!,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.right,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                  color: Utils.isLightMode(
                                                          context)
                                                      ? PsColors.text500 : PsColors.text50),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (!Utils.isLoginUserEmpty(psValueHolder))
                                  PopupMenuButton<String>(
                                      child: const Icon(
                                        Icons.more_vert,
                                      ),
                                      onSelected: (Object? value) async {
                                        final NotiPostParameterHolder
                                            notiPostParameterHolder =
                                            NotiPostParameterHolder(
                                                notiId: noti.id,
                                                notiType: noti.type,
                                                userId: notiProvider!
                                                    .psValueHolder!.loginUserId,
                                                deviceToken: notiProvider
                                                    .psValueHolder!
                                                    .deviceToken);
                                        if (value.toString() ==
                                            '/Mark as read') {
                                          await notiProvider.postNoti(
                                              notiPostParameterHolder.toMap(),
                                              notiProvider
                                                  .psValueHolder!.loginUserId,
                                              langProvider!
                                                  .currentLocale.languageCode);
                                        }
                                        if (value.toString() ==
                                            '/Mark as unread') {
                                          await notiProvider.postUnReadNoti(
                                              notiPostParameterHolder.toMap(),
                                              notiProvider
                                                  .psValueHolder!.loginUserId,
                                              langProvider!
                                                  .currentLocale.languageCode);
                                        }
                                        if (value.toString() == '/Delete') {
                                          await notiProvider.postDeleteNoti(
                                              notiPostParameterHolder.toMap(),
                                              notiProvider
                                                  .psValueHolder!.loginUserId,
                                              langProvider!
                                                  .currentLocale.languageCode);
                                        }
                                        await notiProvider.loadDataList(
                                            reset: true);
                                      },
                                      itemBuilder: (BuildContext context) =>
                                          <PopupMenuItem<String>>[
                                            if (noti.isRead != '1')
                                              PopupMenuItem<String>(
                                                height: PsDimens.space40,
                                                child: Text(
                                                  'Mark as read',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall!
                                                      .copyWith(fontSize: 14),
                                                ),
                                                value: '/Mark as read',
                                              ),
                                            if (noti.isRead != '0')
                                              PopupMenuItem<String>(
                                                height: PsDimens.space40,
                                                child: Text(
                                                  'Mark as unread',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall!
                                                      .copyWith(fontSize: 14),
                                                ),
                                                value: '/Mark as unread',
                                              ),
                                            PopupMenuItem<String>(
                                              height: PsDimens.space40,
                                              child: Text(
                                                'Delete',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                        fontSize: 14,
                                                        color:
                                                            Theme.of(context).primaryColor),
                                              ),
                                              value: '/Delete',
                                            ),
                                          ])
                              ],
                            ),
                          ],
                        )),
                    Divider(
                      height: PsDimens.space1,
                      thickness: 1,
                      color: Utils.isLightMode(context)
                          ? PsColors.text100
                          : PsColors.achromatic700,
                    ),
                  ],
                ),
              ),
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

  Future<void> onTap(BuildContext context) async {
    final NotiProvider provider =
        Provider.of<NotiProvider>(context, listen: false);
    final AppLocalization? langProvider =
        Provider.of<AppLocalization>(context, listen: false);
    print(noti.defaultPhoto!.imgPath);
    // dynamic retrunData;
    final NotiPostParameterHolder notiPostParameterHolder =
        NotiPostParameterHolder(
            notiId: noti.id,
            notiType: noti.type,
            userId: provider.psValueHolder!.loginUserId,
            deviceToken: provider.psValueHolder!.deviceToken);
    provider.postNoti(
        notiPostParameterHolder.toMap(),
        provider.psValueHolder!.loginUserId,
        langProvider!.currentLocale.languageCode);
    if (noti.type == 'PUSH_NOTI') {
      await Navigator.pushNamed(
        context,
        RoutePaths.noti,
        arguments: noti,
      );
    } else {
      await Navigator.pushNamed(context, RoutePaths.chatView,
          arguments: ChatHistoryIntentHolder(
            chatFlag: PsConst.CHAT_FROM_SELLER,
            itemId: noti.itemId,
            buyerUserId: noti.buyerUserId,
            sellerUserId: noti.sellerUserId,
            userCoverPhoto: noti.userCoverPhoto,
            userName: noti.userName,
          ));
    }
    await provider.loadDataList(reset: true);
  }
}
