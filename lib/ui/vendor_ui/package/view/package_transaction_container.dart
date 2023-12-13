import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_config.dart';

import '../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../core/vendor/viewobject/selection.dart';
import '../../../custom_ui/package/component/transaction/vertical/package_transaction_view.dart';

class PackageTransactionContainerView extends StatefulWidget {
  @override
  _BuyAdTransactionContainerViewState createState() =>
      _BuyAdTransactionContainerViewState();
}

class _BuyAdTransactionContainerViewState
    extends State<PackageTransactionContainerView>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  late PsValueHolder valueHolder;
  List<Selection> historySelection = <Selection>[];
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
        '............................Build UI Again ............................');
    return WillPopScope(
      onWillPop: _requestPop,
      child: Scaffold(
        body: CustomPackageTransactionList(
          historySelection: historySelection,
        ),
      ),
    );
  }
}
