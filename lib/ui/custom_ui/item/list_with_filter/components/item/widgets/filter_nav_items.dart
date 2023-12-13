import 'package:flutter/material.dart';

import '../../../../../../vendor_ui/item/list_with_filter/components/item/widgets/filter_nav_items.dart';

class CustomFilterNavItems extends StatefulWidget {
  const CustomFilterNavItems({
    Key? key,
    this.changeAppBarTitle,
  }) : super(key: key);
  final Function? changeAppBarTitle;

  @override
  State<CustomFilterNavItems> createState() => _CustomFilterNavItemsState();
}

class _CustomFilterNavItemsState extends State<CustomFilterNavItems> {
  @override
  Widget build(BuildContext context) {
    return const FilterNavItems();
  }
}
