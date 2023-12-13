import 'package:flutter/material.dart';

import '../../../../../../../core/vendor/provider/entry/item_entry_provider.dart';
import '../../../../../../vendor_ui/item/entry/component/entry_data/widgets/phone_list_widget.dart';

class CustomPhoneListWidget extends StatefulWidget {
  const CustomPhoneListWidget({
    required this.isMandatory,
  });
  final bool isMandatory;
  @override
  State<StatefulWidget> createState() => _PhoneListWidget();
}

class _PhoneListWidget extends State<CustomPhoneListWidget> {
  late ItemEntryProvider itemEntryProvider;

  @override
  Widget build(BuildContext context) {
    return PhoneListWidget(isMandatory: widget.isMandatory);
  }
}
