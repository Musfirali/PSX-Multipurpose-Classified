import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../core/vendor/provider/product/item_entry_provider.dart';
import '../../../../../core/vendor/viewobject/custom_field.dart';
import '../../../../../core/vendor/viewobject/selected_object.dart';

class CheckBoxWidget extends StatefulWidget {
  const CheckBoxWidget({
    Key? key,
    required this.customField,
  }) : super(key: key);
  final CustomField customField;

  @override
  State<CheckBoxWidget> createState() => _CheckBoxWidgetState();
}

class _CheckBoxWidgetState extends State<CheckBoxWidget> {
  late MapEntry<CustomField, SelectedObject> element;

  void _handleOnChange(bool? value) {
    setState(() {
      // _isSelected = value;
      if (value == true) {
        element.value.valueTextController.text = PsConst.ONE;
      } else {
        element.value.valueTextController.text = PsConst.ZERO;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final ItemEntryFieldProvider itemEntryFieldProvider =
        Provider.of<ItemEntryFieldProvider>(context);
    element = itemEntryFieldProvider.textControllerMap.entries.firstWhere(
        (MapEntry<CustomField, SelectedObject> element) =>
            element.key.coreKeyId == widget.customField.coreKeyId);

    if (element.value.valueTextController.text.isEmpty) {
      element.value.valueTextController.text = PsConst.ZERO;
    }

    return Container(
      margin: const EdgeInsets.only(left: PsDimens.space1),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Checkbox(
              activeColor: Theme.of(context).primaryColor,
              value: element.value.valueTextController.text == PsConst.ONE,
              onChanged: _handleOnChange,
            ),
            Text(
              widget.customField.name!.tr,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(
              width: PsDimens.space60,
            )
          ]),
    );
  }
}
