import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/vendor/provider/common/notification_provider.dart';

class CustomCameraOnOffSwitch extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CustomCameraOnOffSwitchState();
}

class _CustomCameraOnOffSwitchState extends State<CustomCameraOnOffSwitch> {
  bool isCustomCameraSwitched = false;
  @override
  Widget build(BuildContext context) {
    final NotificationProvider notiProvider =
        Provider.of<NotificationProvider>(context);
    if (notiProvider.psValueHolder!.isCustomCamera) {
      isCustomCameraSwitched = true;
    } else {
      isCustomCameraSwitched = false;
    }
    return Switch(
        value: isCustomCameraSwitched,
        onChanged: (bool value) {
          if (mounted) {
            setState(() async {
              if (value) {
                isCustomCameraSwitched = value;
                notiProvider.psValueHolder!.isCustomCamera = true;
                await notiProvider.replaceCustomCameraSetting(true);
              } else {
                isCustomCameraSwitched = value;
                notiProvider.psValueHolder!.isCustomCamera = false;
                await notiProvider.replaceCustomCameraSetting(false);
              }
            });
          }
        },
        activeTrackColor: Theme.of(context).primaryColor,
        activeColor: Theme.of(context).primaryColor);
  }
}
