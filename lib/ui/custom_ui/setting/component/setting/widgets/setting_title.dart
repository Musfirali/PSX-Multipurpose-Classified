import 'package:flutter/material.dart';

import '../../../../../vendor_ui/setting/component/setting/widgets/setting_title.dart';

class CustomSettingTitleWidget extends StatelessWidget {
  const CustomSettingTitleWidget({Key? key, required this.title})
      : super(key: key);

  final String title;
  @override
  Widget build(BuildContext context) {
    return SettingTitleWidget(title: title);
  }
}
