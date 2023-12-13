import 'package:flutter/material.dart';

import '../../../../../../../core/vendor/provider/entry/item_entry_provider.dart';
import '../../../../../../vendor_ui/item/entry/component/entry_data/widgets/terms_and_policy_checkbox.dart';

class CustomTermsAndPolicyCheckbox extends StatefulWidget {
  const CustomTermsAndPolicyCheckbox();

  @override
  BusinessModeCheckboxState<CustomTermsAndPolicyCheckbox> createState() =>
      BusinessModeCheckboxState<CustomTermsAndPolicyCheckbox>();
}

class BusinessModeCheckboxState<T extends CustomTermsAndPolicyCheckbox>
    extends State<CustomTermsAndPolicyCheckbox> {
  late ItemEntryProvider provider;
  
  @override
  Widget build(BuildContext context) {
    return const TermsAndPolicyCheckbox();
  }
}
