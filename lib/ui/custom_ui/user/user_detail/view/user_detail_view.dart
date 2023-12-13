
import 'package:flutter/material.dart';

import '../../../../vendor_ui/user/user_detail/view/user_detail_view.dart';

class CustomUserDetailView extends StatefulWidget {
  const CustomUserDetailView({
    required this.userId,
    required this.userName,
  });
  final String? userId;
  final String? userName;
  @override
  _UserDetailViewState createState() => _UserDetailViewState();
}

class _UserDetailViewState extends State<CustomUserDetailView> {
  
  @override
  Widget build(BuildContext context) {
    return UserDetailView(userId: widget.userId, userName: widget.userName);
  }
}
