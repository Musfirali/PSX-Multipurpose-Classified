import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';

import '../../../../../../config/route/route_paths.dart';
import '../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/chat/get_chat_history_provider.dart';
import '../../../../../../core/vendor/provider/product/product_provider.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../core/vendor/viewobject/holder/intent_holder/product_detail_intent_holder.dart';
import '../../../../../custom_ui/chat/component/detail/header_item_info/widgets/image_widget.dart';
import '../../../../../custom_ui/chat/component/detail/header_item_info/widgets/product_info.dart';

class HeaderItemInfoWidget extends StatefulWidget {
  const HeaderItemInfoWidget({
    Key? key,
    required this.insertDataToFireBase,
    required this.sessionId,
    required this.chatFlag,
    required this.isUserOnline,
    required this.tagKey,
    required this.buyerUserId,
    required this.sellerUserId,
  }) : super(key: key);

  final Function insertDataToFireBase;
  final String? sessionId;
  final String chatFlag;
  final String? isUserOnline;
  final String tagKey;
  final String? buyerUserId;
  final String? sellerUserId;

  @override
  _HeaderItemInfoWidgetState createState() => _HeaderItemInfoWidgetState();
}

class _HeaderItemInfoWidgetState extends State<HeaderItemInfoWidget> {
  ItemDetailProvider? itemDetailProvider;
  GetChatHistoryProvider? getChatHistoryProvider;

  void goToProductDetail(BuildContext context) {
    final String productId = itemDetailProvider!.product.id ?? '';
    final ProductDetailIntentHolder holder = ProductDetailIntentHolder(
        productId: productId,
        heroTagImage: widget.tagKey + productId + PsConst.HERO_TAG__IMAGE,
        heroTagTitle: widget.tagKey + productId + PsConst.HERO_TAG__TITLE);
    Navigator.pushNamed(context, RoutePaths.productDetail, arguments: holder);
  }

  @override
  Widget build(BuildContext context) {
    itemDetailProvider =
        Provider.of<ItemDetailProvider>(context, listen: false);
    return Align(
      alignment: Alignment.topCenter,
      child: GestureDetector(
        onTap: () {
          goToProductDetail(context);
        },
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: Utils.isLightMode(context)
                  ? PsColors.primary50
                  : Utils.isLightMode(context) ? PsColors.achromatic50
              : PsColors.achromatic900),
          padding: const EdgeInsets.all(PsDimens.space12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CustomImageWidget(),
              CustomProductInfo(chatFlag: widget.chatFlag),
            ],
          ),
        ),
      ),
    );
  }
}
