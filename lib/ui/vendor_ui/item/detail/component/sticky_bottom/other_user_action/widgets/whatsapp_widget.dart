import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/core/vendor/viewobject/product.dart';
import 'package:psxmpc/core/vendor/viewobject/user_relation.dart';
import 'package:remixicon/remixicon.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../../core/vendor/provider/product/product_provider.dart';
import '../../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../common/ps_button_widget.dart';

class WhatsAppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ItemDetailProvider provider =
        Provider.of<ItemDetailProvider>(context);

    final Product product = provider.product;
    const String userWhatsapp = 'ps-usr00012';
    final int index = product.user!.userRelation!.indexWhere(
        (UserRelation element) => element.coreKeyId == userWhatsapp);

    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: PSButtonWithIconWidget(
          colorData: Theme.of(context).primaryColor,
          hasShadow: false,
          icon: Remix.whatsapp_line,
          textColor: Utils.isLightMode(context)
              ? PsColors.achromatic50
              : PsColors.text800,
          iconColor: Utils.isLightMode(context)
              ? PsColors.achromatic50
              : PsColors.text800,
          titleText: 'product_detail__whatsapp'.tr,
          onPressed: () async {
            //if (provider.productOwner!.hasPhone) {
            if (await canLaunchUrl(Uri.parse(
                'whatsapp://send?phone=${product.user!.userRelation?.elementAt(index).selectedValues?[0].value}'))) {
              await launchUrl(Uri.parse(
                  'whatsapp://send?phone=${product.user!.userRelation?.elementAt(index).selectedValues?[0].value}'));
            } else {
              const String whatsappDownloadUrl =
                  'https://play.google.com/store/apps/details?id=com.whatsapp';
              const String whatsappDownloadUrlIos =
                  'https://apps.apple.com/us/app/whatsapp-messenger/id310633997';
              if (Platform.isIOS) {
                if (await canLaunchUrl(Uri.parse(whatsappDownloadUrlIos))) {
                  await launchUrl(Uri.parse(whatsappDownloadUrlIos));
                } else {
                  throw 'Could not launch $whatsappDownloadUrlIos';
                }
              } else {
                if (await canLaunchUrl(Uri.parse(whatsappDownloadUrl))) {
                  await launchUrl(Uri.parse(whatsappDownloadUrl));
                } else {
                  throw 'Could not launch $whatsappDownloadUrl';
                }
              }
              // throw 'Could not send Phone Number 1';
            }
          },
        ),
      ),
    );
  }
}
