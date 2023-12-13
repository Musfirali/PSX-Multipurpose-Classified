import 'package:flutter/material.dart';

import '../../../../vendor_ui/location/component/select_township/township_search_widget.dart';

class CustomTownshipSearchWidget extends StatelessWidget {
  const CustomTownshipSearchWidget({required this.searchController});
  final TextEditingController searchController;
  @override
  Widget build(BuildContext context) {
    return TownshipSearchWidget(
      searchController: searchController,
    );
  }
}
