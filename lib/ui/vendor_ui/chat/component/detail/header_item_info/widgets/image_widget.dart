import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../config/route/route_paths.dart';
import '../../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/provider/product/product_provider.dart';
import '../../../../../../../core/vendor/viewobject/holder/intent_holder/product_detail_intent_holder.dart';
import '../../../../../../../core/vendor/viewobject/product.dart';
import '../../../../../common/ps_ui_widget.dart';

class ImageWidget extends StatelessWidget {
  void goToProductDetail(BuildContext context, Product product) {
    final ProductDetailIntentHolder holder = ProductDetailIntentHolder(
        productId: product.id,
        heroTagImage: product.id! + PsConst.HERO_TAG__IMAGE,
        heroTagTitle: product.id! + PsConst.HERO_TAG__TITLE);
    Navigator.pushNamed(context, RoutePaths.productDetail, arguments: holder);
  }

  @override
  Widget build(BuildContext context) {
    final ItemDetailProvider itemDetailProvider =
        Provider.of<ItemDetailProvider>(context);
    final Product product = itemDetailProvider.product;
    return SizedBox(
        width: 72,
        height: 50,
        child: Padding(
          padding: Directionality.of(context) == TextDirection.rtl
              ? const EdgeInsets.only(left: PsDimens.space12)
              : const EdgeInsets.only(right: PsDimens.space12),
          child: PsNetworkImage(
            photoKey: '',
            defaultPhoto: product.defaultPhoto,
            imageAspectRation: PsConst.Aspect_Ratio_1x,
            boxfit: BoxFit.cover,
            onTap: () {
              goToProductDetail(context, product);
            },
          ),
        ));
  }
}
