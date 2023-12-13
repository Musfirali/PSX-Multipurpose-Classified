import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_config.dart';

import '../../../../core/vendor/provider/common/notification_provider.dart';
import '../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../core/vendor/repository/Common/notification_repository.dart';
import '../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../custom_ui/setting/component/setting/setting_view.dart';
import '../../common/base/ps_widget_with_appbar.dart';

class SettingContainerView extends StatefulWidget {
  @override
  _SettingContainerViewState createState() => _SettingContainerViewState();
}

class _SettingContainerViewState extends State<SettingContainerView>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  NotificationRepository? notiRepository;
  NotificationProvider? notiProvider;
  PsValueHolder? _psValueHolder;

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

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    notiRepository = Provider.of<NotificationRepository>(context);
    _psValueHolder = Provider.of<PsValueHolder>(context);
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
        '............................Build Setting Container UI Again ............................');
    return WillPopScope(
        onWillPop: _requestPop,
        child: PsWidgetWithAppBar<NotificationProvider>(
            appBarTitle: 'more__app_setting'.tr,
            initProvider: () {
              return NotificationProvider(
                  repo: notiRepository, psValueHolder: _psValueHolder);
            },
            onProviderReady: (NotificationProvider provider) {
              notiProvider = provider;
            },
            builder: (BuildContext context, NotificationProvider provider,
                Widget? child) {
              return CustomSettingView(
                animationController: animationController,
              );
            }));
  }
}
