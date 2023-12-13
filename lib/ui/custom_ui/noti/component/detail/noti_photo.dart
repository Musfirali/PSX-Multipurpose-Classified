import 'package:flutter/material.dart';

import '../../../../../core/vendor/viewobject/default_photo.dart';
import '../../../../vendor_ui/noti/component/detail/noti_photo.dart';

class CustomNotiPhoto extends StatelessWidget {
  const CustomNotiPhoto({required this.defaultPhoto});
  final DefaultPhoto defaultPhoto;

  @override
  Widget build(BuildContext context) {
    return NotiPhoto(defaultPhoto: defaultPhoto);
  }
}
