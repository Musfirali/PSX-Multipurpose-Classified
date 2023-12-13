import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../core/vendor/provider/language/language_provider.dart';
import '../../../common/ps_textfield_widget_with_icon.dart';

class LanguageSearchWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LanguageSearchWidgetState();
}

class _LanguageSearchWidgetState extends State<LanguageSearchWidget> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final LanguageProvider _provider = Provider.of<LanguageProvider>(context);
    return PsTextFieldWidgetWithIcon(
        hintText: 'Search'.tr,
        textEditingController: searchController,
        clickSearchButton: () {
          _provider.languageParameterHolder.keyword = searchController.text;
          _provider.loadDataList(
            reset: true,
            requestBodyHolder: _provider.languageParameterHolder,
          );
        },
        clickEnterFunction: () {
          _provider.languageParameterHolder.keyword = searchController.text;
          _provider.loadDataList(
            reset: true,
            requestBodyHolder: _provider.languageParameterHolder,
          );
        });
  }
}
