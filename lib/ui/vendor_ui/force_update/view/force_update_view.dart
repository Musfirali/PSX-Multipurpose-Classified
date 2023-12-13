import 'package:flutter/material.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../core/vendor/viewobject/holder/intent_holder/version_update_intent_holder.dart';
import '../../../custom_ui/force_update/component/force_update_button.dart';
import '../../common/ps_header_icon_and_dynamic_text_widget.dart';

class ForceUpdateView extends StatelessWidget {
  const ForceUpdateView({required this.version});
  final VersionIntentHolder version;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        PsHeaderIconAndDynamicTextWidget(text: 'force_update__update'.tr),
        Padding(
            padding: const EdgeInsets.only(
                left: PsDimens.space16, right: PsDimens.space16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: PsDimens.space8),
                  child: Text(version.versionTitle!,
                      style: Theme.of(context).textTheme.titleMedium),
                ),
                Container(
                    height: PsDimens.space150,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Text(version.versionMessage!,
                          maxLines: 9,
                          style: Theme.of(context).textTheme.bodyLarge),
                    )),
                CustomForceUpdateButton(),
              ],
            ))
      ],
    );
  }
}
