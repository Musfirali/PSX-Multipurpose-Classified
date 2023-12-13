import 'package:flutter/material.dart';
import 'package:psxmpc/config/ps_config.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../custom_ui/contact/component/contact_us_view.dart';
import '../../common/ps_app_bar_widget.dart';

class ContactUsContainerView extends StatefulWidget {
  @override
  _ContactUsContainerViewState createState() => _ContactUsContainerViewState();
}

class _ContactUsContainerViewState extends State<ContactUsContainerView>
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
          appBarTitle: 'home__menu_drawer_contact_us'.tr,
        ),
        body: CustomContactUsView(
          animationController: animationController,
        ),
      ),
    );
  }
}
