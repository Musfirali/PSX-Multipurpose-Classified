import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';
import 'package:psxmpc/core/vendor/provider/user/user_feild_provider.dart';

import '../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../core/vendor/viewobject/custom_field.dart';
import '../../../../../core/vendor/viewobject/selected_object.dart';

class UserCheckBoxWidget extends StatefulWidget {
  const UserCheckBoxWidget({
    Key? key,
    required this.customField,
  }) : super(key: key);
  final CustomField customField;

  @override
  State<UserCheckBoxWidget> createState() => _UserCheckBoxWidgetState();
}

class _UserCheckBoxWidgetState extends State<UserCheckBoxWidget> {
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
    final UserFieldProvider userFieldProvider =
        Provider.of<UserFieldProvider>(context);
    element = userFieldProvider.textControllerMap.entries.firstWhere(
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
