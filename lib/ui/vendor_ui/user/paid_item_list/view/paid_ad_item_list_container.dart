import 'package:flutter/material.dart';
import 'package:psxmpc/config/ps_config.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../custom_ui/user/paid_item_list/component/vertical/paid_ad_item_list_view.dart';
import '../../../common/ps_app_bar_widget.dart';

class PaidItemListContainerView extends StatefulWidget {
  @override
  _PaidItemListContainerViewState createState() =>
      _PaidItemListContainerViewState();
}

class _PaidItemListContainerViewState extends State<PaidItemListContainerView>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;
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
        appBar: PsAppbarWidget(
          appBarTitle: 'more__paid_ads_title'.tr,
        ),
        body: CustomPaidAdItemListView(
          animationController: animationController,
        ),
      ),
    );
  }
}
