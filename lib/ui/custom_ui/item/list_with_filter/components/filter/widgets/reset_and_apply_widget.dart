import 'package:flutter/material.dart';

import '../../../../../../vendor_ui/item/list_with_filter/components/filter/widgets/reset_and_apply_widget.dart';

class CustomResetAndApplyWidget extends StatelessWidget {
  const CustomResetAndApplyWidget({
    Key? key,
    required this.handleApply,
    required this.handleReset,
  }) : super(key: key);
  final Function handleReset;
  final Function handleApply;
  
  @override
  Widget build(BuildContext context) {
    return ResetAndApplyWidget(
      handleApply: handleApply,
      handleReset: handleReset,
    );
  }
}
