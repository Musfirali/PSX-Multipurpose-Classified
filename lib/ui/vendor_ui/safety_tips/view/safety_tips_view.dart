import 'package:flutter/material.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../core/vendor/constant/ps_dimens.dart';
import '../../common/ps_app_bar_widget.dart';
import '../../common/ps_html_text_widget.dart';

class SafetyTipsView extends StatefulWidget {
  const SafetyTipsView({
    Key? key,
    required this.safetyTips,
  }) : super(key: key);

  final String? safetyTips;
  @override
  _SafetyTipsViewState createState() => _SafetyTipsViewState();
}

class _SafetyTipsViewState extends State<SafetyTipsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PsAppbarWidget(
          appBarTitle: 'safety_tips__app_bar_name'.tr,
        ),
        body: Padding(
          padding: const EdgeInsets.all(PsDimens.space10),
          child: SingleChildScrollView(
            child: PsHTMLTextWidget(
              htmlData: widget.safetyTips ?? '',
            ),
          ),
        ));
  }
}
