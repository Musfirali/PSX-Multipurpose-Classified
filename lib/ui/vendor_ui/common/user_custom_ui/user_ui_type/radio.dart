import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';
import 'package:psxmpc/core/vendor/provider/user/user_feild_provider.dart';

import '../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../core/vendor/viewobject/custom_field.dart';
import '../../../../../core/vendor/viewobject/customize_ui_detail.dart';
import '../../../../../core/vendor/viewobject/selected_object.dart';

class UserRadioButtonListWidget extends StatefulWidget {
  const UserRadioButtonListWidget({
    Key? key,
    required this.customField,
  }) : super(key: key);
  final CustomField customField;

  @override
  State<UserRadioButtonListWidget> createState() => _RadioButtonListWidgetState();
}

class _RadioButtonListWidgetState extends State<UserRadioButtonListWidget> {
  // String? _selectedValue = '-1';
  late MapEntry<CustomField, SelectedObject> element;

  // @override
  // void initState() {
  //   super.initState();
  //   _selectedValue = element.value.idTextController.text;
  // }

  void _updateRadioButton(String? value) {
    setState(() {
      // element.value.valueTextController.text = value!;
      element.value.idTextController.text = value!;
    });
  }

  List<Widget> radioButtons() {
    if (widget.customField.customizeUiDetails!.isNotEmpty) {
      return widget.customField.customizeUiDetails!
          .map(
            (CustomizeUiDetail customizeUiDetail) => RadioItem(
                currentValue: element.value.idTextController.text.isEmpty
                    ? '-1'
                    : element.value.idTextController.text,
                title: customizeUiDetail.name!.tr,
                value: customizeUiDetail.id.toString(),
                onUpdate: _updateRadioButton),
          )
          .toList();
    } else {
      return <Widget>[];
    }
  }

  @override
  Widget build(BuildContext context) {
    final UserFieldProvider userFieldProvider =
        Provider.of<UserFieldProvider>(context);
    element = userFieldProvider.textControllerMap.entries.firstWhere(
        (MapEntry<CustomField, SelectedObject> element) =>
            element.key.coreKeyId == widget.customField.coreKeyId);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: Text(widget.customField.name!.tr,
              style: Theme.of(context).textTheme.titleSmall),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const SizedBox(
              width: PsDimens.space8,
            ),
            ...radioButtons(),
            const SizedBox(
              width: PsDimens.space8,
            ),
          ],
        )
      ],
    );
  }
}

class RadioItem extends StatelessWidget {
  const RadioItem({
    Key? key,
    required this.currentValue,
    required this.title,
    required this.value,
    required this.onUpdate,
  }) : super(key: key);
  final String title;
  final String currentValue;
  final String value;
  final Function(String? value) onUpdate;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: <Widget>[
          Radio<String?>(
            value: value,
            groupValue: currentValue,
            onChanged: onUpdate,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            activeColor: Theme.of(context).primaryColor,
          ),
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
