import 'package:flutter/material.dart';
import 'package:psxmpc/config/ps_config.dart';

import '../../../vendor_ui/language/view/onboard_language_container_view.dart';

class CustomOnBoardLanguageContainerView extends StatefulWidget {
  @override
  _LanguageSettingContainerViewState createState() =>
      _LanguageSettingContainerViewState();
}

class _LanguageSettingContainerViewState
    extends State<CustomOnBoardLanguageContainerView>
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
    return OnBoardLanguageContainerView();
  }
}
