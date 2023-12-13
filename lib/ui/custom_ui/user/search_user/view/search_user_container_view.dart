import 'package:flutter/material.dart';

import '../../../../vendor_ui/user/search_user/view/search_user_container_view.dart';

class CustomSearchUserContainerView extends StatefulWidget {
  const CustomSearchUserContainerView({
    required this.searchKeyword,
  });

  final String searchKeyword;

  @override
  _CustomSearchUserContainerViewState createState() =>
      _CustomSearchUserContainerViewState();
}

class _CustomSearchUserContainerViewState
    extends State<CustomSearchUserContainerView> {
      
  @override
  Widget build(BuildContext context) {
    return SearchUserContainerView(searchKeyword: widget.searchKeyword);
  }
}
