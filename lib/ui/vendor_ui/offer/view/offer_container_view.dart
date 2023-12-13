import 'package:flutter/material.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/config/ps_config.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../core/vendor/utils/utils.dart';
import '../../../custom_ui/offer/component/offer_list_view.dart';
import '../../common/ps_app_bar_widget.dart';

class OfferContainerView extends StatefulWidget {
  @override
  _OfferContainerViewState createState() => _OfferContainerViewState();
}

class _OfferContainerViewState extends State<OfferContainerView>
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

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

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
          appBarTitle: 'more__offer_title'.tr,
        ),
        body: Container(
          color: Utils.isLightMode(context) ? PsColors.achromatic50 : PsColors.achromatic800,
          height: double.infinity,
          child: CustomOfferListView(
            animationController: animationController,
          ),
        ),
      ),
    );
  }
}
