import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../core/vendor/provider/common/notification_provider.dart';
import '../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../core/vendor/repository/Common/notification_repository.dart';
import '../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../custom_ui/setting/component/camera/custom_on_off_switch.dart';
import '../../common/base/ps_widget_with_appbar.dart';

class CameraSettingView extends StatefulWidget {
  @override
  _NotificationSettingViewState createState() =>
      _NotificationSettingViewState();
}

class _NotificationSettingViewState extends State<CameraSettingView>
    with SingleTickerProviderStateMixin {
NotificationRepository? notiRepository;
late NotificationProvider notiProvider;
PsValueHolder? _psValueHolder;    
  @override
  Widget build(BuildContext context) {
    notiRepository = Provider.of<NotificationRepository>(context);
    _psValueHolder = Provider.of<PsValueHolder>(context);
    print(
        '............................Build UI Again ...........................');

    return PsWidgetWithAppBar<NotificationProvider>(
        appBarTitle: 'camera_setting__toolbar_name'.tr,
        initProvider: () {
          return NotificationProvider(
              repo: notiRepository, psValueHolder: _psValueHolder);
        },
        onProviderReady: (NotificationProvider provider) {
          notiProvider = provider;
        },
        builder: (BuildContext context, NotificationProvider provider,
            Widget? child) {
          return Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    left: PsDimens.space8,
                    top: PsDimens.space8,
                    bottom: PsDimens.space8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'camera_setting__custom_camera'.tr,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    CustomCustomCameraOnOffSwitch(),
                  ],
                ),
              ),
            ],
          );
        });
  }
}
