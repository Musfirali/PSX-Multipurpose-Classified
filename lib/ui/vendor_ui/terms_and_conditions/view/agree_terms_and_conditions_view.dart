import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:psxmpc/config/ps_config.dart';

import '../../../../core/vendor/provider/about_us/about_us_provider.dart';
import '../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../core/vendor/repository/about_us_repository.dart';
import '../../../../core/vendor/utils/utils.dart';
import '../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../component/agree/agree_terms_and_conditions_widget.dart';

class AgreeTermsAndCondition extends StatefulWidget {
  @override
  _AgreeTermsAndConditionState createState() {
    return _AgreeTermsAndConditionState();
  }
}

class _AgreeTermsAndConditionState extends State<AgreeTermsAndCondition>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  Animation<double>? animation;

  @override
  void dispose() {
    animationController.dispose();
    animation = null;
    super.dispose();
  }

  @override
  void initState() {
    animationController =
        AnimationController(duration: PsConfig.animation_duration, vsync: this);
    animation = Tween<double>(
      begin: 0.0,
      end: 10.0,
    ).animate(animationController);
    super.initState();
  }

  late AboutUsProvider aboutUsProvider;

  late AboutUsRepository repo1;
  PsValueHolder? psValueHolder;
  late AppLocalization langProvider;

  @override
  Widget build(BuildContext context) {
    repo1 = Provider.of<AboutUsRepository>(context);
    langProvider = Provider.of<AppLocalization>(context);
    psValueHolder = Provider.of<PsValueHolder>(context);

    return Scaffold(
      body: MultiProvider(
        providers: <SingleChildWidget>[
          ChangeNotifierProvider<AboutUsProvider?>(
              lazy: false,
              create: (BuildContext context) {
                final String? loginUserId =
                    Utils.checkUserLoginId(psValueHolder!);
                aboutUsProvider = AboutUsProvider(
                  repo: repo1,
                );
                aboutUsProvider.loadData(
                  requestPathHolder: RequestPathHolder(
                      loginUserId: loginUserId,
                      languageCode: langProvider.currentLocale.languageCode),
                );
                return aboutUsProvider;
              }),
        ],
        child: Consumer<AboutUsProvider>(builder:
            (BuildContext context, AboutUsProvider provider, Widget? child) {
          /**
          * UI SECTION
          */
          return AgreeTermsAndConditionWidget();
        }),
      ),
    );
  }
}
