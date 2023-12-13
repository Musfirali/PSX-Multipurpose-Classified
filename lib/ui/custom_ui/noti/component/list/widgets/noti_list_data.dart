import 'package:flutter/material.dart';

import '../../../../../vendor_ui/noti/component/list/widgets/noti_list_data.dart';

class CustomNotiListData extends StatefulWidget {
  const CustomNotiListData({required this.animationController});
  final AnimationController animationController;
  @override
  State<StatefulWidget> createState() => _NotiListDataState();
}

class _NotiListDataState extends State<CustomNotiListData> {
  @override
  Widget build(BuildContext context) {
    return NotiListData(animationController: widget.animationController);
  }
}
