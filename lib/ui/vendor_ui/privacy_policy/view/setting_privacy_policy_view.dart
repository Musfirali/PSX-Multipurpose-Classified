import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../core/vendor/provider/about_us/about_us_provider.dart';
import '../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../core/vendor/repository/about_us_repository.dart';
import '../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../common/base/ps_widget_with_appbar.dart';
import '../../common/ps_html_text_widget.dart';

class SettingPrivacyPolicyView extends StatefulWidget {
  @override
  _SettingPrivacyPolicyViewState createState() {
    return _SettingPrivacyPolicyViewState();
  }
}

class _SettingPrivacyPolicyViewState extends State<SettingPrivacyPolicyView>
    with SingleTickerProviderStateMixin {


  @override
  void initState() {
    super.initState();
  }

  late AboutUsRepository repo1;
  PsValueHolder? valueHolder;
  late AppLocalization langProvider;
  @override
  Widget build(BuildContext context) {
     langProvider = Provider.of<AppLocalization>(context);
    repo1 = Provider.of<AboutUsRepository>(context);
    valueHolder = Provider.of<PsValueHolder>(context);

    return PsWidgetWithAppBar<AboutUsProvider>(
        appBarTitle: 'privacy_policy__toolbar_name'.tr,
        initProvider: () {
          return AboutUsProvider(
            repo: repo1,
          );
        },
        onProviderReady: (AboutUsProvider provider) {
          provider.loadData(
                  requestPathHolder: RequestPathHolder(
                    loginUserId: valueHolder!.loginUserId,
                    languageCode: langProvider.currentLocale.languageCode
                  ),
                );
        },
        builder:
            (BuildContext context, AboutUsProvider provider, Widget? child) {
          if (provider.hasData) {
            return Padding(
              padding: const EdgeInsets.all(PsDimens.space10),
              child: SingleChildScrollView(
                child: PsHTMLTextWidget(
                    htmlData: provider.aboutUs.data!.privacypolicy!),
              ),
            );
          } else {
            return const SizedBox();
          }
        });
  }
}
