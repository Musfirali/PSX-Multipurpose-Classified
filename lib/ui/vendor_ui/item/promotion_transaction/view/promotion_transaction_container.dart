import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_config.dart';

import '../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../custom_ui/item/promotion_transaction/component/promotion_transaction_list_view.dart';

class PromotionTransactionContainerView extends StatefulWidget {
  @override
  _BuyAdTransactionContainerViewState createState() =>
      _BuyAdTransactionContainerViewState();
}

class _BuyAdTransactionContainerViewState
    extends State<PromotionTransactionContainerView>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  late PsValueHolder valueHolder;

  @override
  void initState() {
    animationController =
        AnimationController(duration: PsConfig.animation_duration, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    valueHolder = Provider.of<PsValueHolder>(context, listen: false);

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
        '............................Build Promotion Transaction UI Again ............................');
    return WillPopScope(
      onWillPop: _requestPop,
      child: Scaffold(
        body: CustomPomotionTransactionList(),
      ),
    );
  }
}
