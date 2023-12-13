import 'package:flutter/material.dart';

import '../../../../../../vendor_ui/chat/component/detail/header_item_info/widgets/product_info.dart';

class CustomProductInfo extends StatelessWidget {
  const CustomProductInfo({required this.chatFlag});
  final String chatFlag;
  @override
  Widget build(BuildContext context) {
    return ProductInfo(chatFlag: chatFlag);
  }
}
