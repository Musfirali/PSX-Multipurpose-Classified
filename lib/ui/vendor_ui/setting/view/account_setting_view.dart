import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:psxmpc/config/ps_config.dart';

import '../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../core/vendor/provider/delete_task/delete_task_provider.dart';
import '../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../core/vendor/repository/delete_task_repository.dart';
import '../../../../core/vendor/repository/user_repository.dart';
import '../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../custom_ui/setting/component/account/setting_change_password.dart';
import '../../../custom_ui/setting/component/account/setting_delete_account.dart';
import '../../common/ps_admob_banner_widget.dart';
import '../../common/ps_app_bar_widget.dart';

class AccountSettingView extends StatefulWidget {
  @override
  _AccountSettingViewState createState() => _AccountSettingViewState();
}

class _AccountSettingViewState extends State<AccountSettingView>
    with SingleTickerProviderStateMixin {
  UserRepository? userRepository;
  DeleteTaskRepository? deleteTaskRepository;
  late UserProvider notiProvider;
  PsValueHolder? _psValueHolder;

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
    userRepository = Provider.of<UserRepository>(context);
    deleteTaskRepository = Provider.of<DeleteTaskRepository>(context);
    _psValueHolder = Provider.of<PsValueHolder>(context);
    print(
        '............................Build Account Setting UI Again ...........................');
    return MultiProvider(
        providers: <SingleChildWidget>[
          ChangeNotifierProvider<UserProvider?>(
              lazy: false,
              create: (BuildContext context) {
                return UserProvider(
                    repo: userRepository, psValueHolder: _psValueHolder);
              }),
          ChangeNotifierProvider<DeleteTaskProvider?>(
              lazy: false,
              create: (BuildContext context) {
                return DeleteTaskProvider(
                    repo: deleteTaskRepository, psValueHolder: _psValueHolder);
              }),
        ],
        child: Consumer<UserProvider>(builder:
            (BuildContext context, UserProvider provider, Widget? child) {
          return Scaffold(
            appBar: PsAppbarWidget(
              appBarTitle: 'account_setting__title'.tr,
            ),
            body: Column(
              children: <Widget>[
                const SizedBox(
                  height: PsDimens.space18,
                ),
                CustomSettingChangePasswordWidget(),
                CustomSettingDeleteAccountWidget(),
                const SizedBox(
                  height: PsDimens.space32,
                ),
                const PsAdMobBannerWidget(
                  admobSize: AdSize.mediumRectangle,
                ),
              ],
            ),
          );
        }));
  }
}
