import 'package:flutter/material.dart';
import 'package:psxmpc/config/ps_config.dart';
import 'package:psxmpc/ui/custom_ui/item/price_range/component/price_range_item.dart';
import 'package:psxmpc/ui/vendor_ui/common/ps_app_bar_widget.dart';
import '../../../../../../../core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../core/vendor/utils/ps_animation.dart';

class ChoosePriceRangeView extends StatefulWidget {
  const ChoosePriceRangeView({required this.dollarCount});
  final int dollarCount;
  @override
  State<StatefulWidget> createState() {
    return ItemCurrencyViewState();
  }
}

class ItemCurrencyViewState extends State<ChoosePriceRangeView>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  Animation<double>? animation;

  @override
  void dispose() {
    animationController!.dispose();
    animation = null;
    super.dispose();
  }

  @override
  void initState() {
    animationController =
        AnimationController(duration: PsConfig.animation_duration, vsync: this);
    animation = Tween<double>(
      begin: 0.0,
      end: 10.0,
    ).animate(animationController!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<bool> _requestPop() {
      animationController!.reverse().then<dynamic>(
        (void data) {
          if (!mounted) {
            return Future<bool>.value(false);
          }
          Navigator.pop(context, true);
          return Future<bool>.value(true);
        },
      );
      return Future<bool>.value(false);
    }

    print(
        '............................Build UI Again ............................');

    return WillPopScope(
      onWillPop: _requestPop,
      child: Scaffold(
        appBar:  PsAppbarWidget(appBarTitle: 'select_price_range'.tr,),
        body: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: 5,
            itemBuilder: (BuildContext context, int index) {
              return CustomPriceRangeItem(
                dollarCount: index + 1,
                isSelected: widget.dollarCount == index + 1,
                animationController: animationController,
                animation:
                    curveAnimation(animationController!, count: 5, index: index),
              );
            }),
      ),
    );
  }
}
