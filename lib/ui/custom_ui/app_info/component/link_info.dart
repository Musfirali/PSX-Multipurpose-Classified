import 'package:flutter/material.dart';

import '../../../vendor_ui/app_info/component/link_info.dart';

class CustomLinkInfo extends StatelessWidget {
  const CustomLinkInfo({
    Key? key,
    this.icon,
    this.imageName,
    required this.title,
    required this.link,
  }) : super(key: key);

  final IconData? icon;
  final String? imageName;
  final String title;
  final String? link;

  @override
  Widget build(BuildContext context) {
    return LinkInfo(icon: icon, title: title, link: link, imageName: imageName);
  }
}
