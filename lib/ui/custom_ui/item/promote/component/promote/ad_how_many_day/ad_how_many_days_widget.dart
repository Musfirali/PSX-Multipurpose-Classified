import 'package:flutter/material.dart';

import '../../../../../../../core/vendor/provider/token/token_provider.dart';
import '../../../../../../../core/vendor/viewobject/product.dart';
import '../../../../../../vendor_ui/item/promote/component/promote/ad_how_many_day/ad_how_many_days_widget.dart';

class CustomAdsHowManyDayWidget extends StatefulWidget {
  const CustomAdsHowManyDayWidget(
      {Key? key, 
      required this.product, 
      required this.tokenProvider})
      : super(key: key);

  final Product product;
  final TokenProvider? tokenProvider;

  @override
  State<StatefulWidget> createState() {
    return AdsHowManyDayWidgetState();
  }
}

class AdsHowManyDayWidgetState extends State<CustomAdsHowManyDayWidget> {
  @override
  Widget build(BuildContext context) {
    return AdsHowManyDayWidget(
        product: widget.product, tokenProvider: widget.tokenProvider);
  }
}
