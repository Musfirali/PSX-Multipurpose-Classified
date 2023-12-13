import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../config/route/route_paths.dart';
import '../../../../../core/vendor/provider/language/language_provider.dart';
import '../../../common/ps_dropdown_base_widget.dart';

class ChooseLanguageDropDownWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LanguageProvider provider = Provider.of<LanguageProvider>(context);
    return PsDropdownBaseWidget(
        title: '',
        selectedText: provider.getLanguage().name,
        icon: Icons.keyboard_arrow_right,
        onTap: () async {
          await Navigator.pushNamed(context, RoutePaths.languageList,
              arguments: true);
        });
  }
}
