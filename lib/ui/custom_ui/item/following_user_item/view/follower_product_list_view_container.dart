import 'package:flutter/material.dart';

import '../../../../../core/vendor/viewobject/holder/follower_uer_item_list_parameter_holder.dart';
import '../../../../vendor_ui/item/following_user_item/view/follower_product_list_view_container.dart';

class CustomFollowerItemListView extends StatefulWidget {
  const CustomFollowerItemListView(
      {required this.loginUserId, required this.holder});

  final String loginUserId;
  final FollowUserItemParameterHolder holder;

  @override
  UserItemFollowerListViewState createState() {
    return UserItemFollowerListViewState();
  }
}

class UserItemFollowerListViewState extends State<CustomFollowerItemListView> {
  @override
  Widget build(BuildContext context) {
    return FollowerItemListView(
      holder: widget.holder,
      loginUserId: widget.loginUserId,
    );
  }
}
