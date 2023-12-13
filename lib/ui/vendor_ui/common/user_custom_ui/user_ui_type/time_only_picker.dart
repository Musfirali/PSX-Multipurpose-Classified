import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';
import 'package:psxmpc/core/vendor/provider/user/user_feild_provider.dart';

import '../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../core/vendor/viewobject/custom_field.dart';
import '../../../../../core/vendor/viewobject/selected_object.dart';
import '../../date_time_picker_with_icon.dart';

class UserTimePickerWidget extends StatefulWidget {
  const UserTimePickerWidget({Key? key, required this.customField})
      : super(key: key);
  final CustomField customField;

  @override
  State<UserTimePickerWidget> createState() => _TimePickerWidgetState();
}

class _TimePickerWidgetState extends State<UserTimePickerWidget> {
  @override
  Widget build(BuildContext context) {
    final UserFieldProvider userFieldProvider =
        Provider.of<UserFieldProvider>(context);
    final MapEntry<CustomField, SelectedObject> element = userFieldProvider
        .textControllerMap.entries
        .firstWhere((MapEntry<CustomField, SelectedObject> element) =>
            element.key.coreKeyId == widget.customField.coreKeyId);

    return Padding(
      padding: const EdgeInsets.only(top: PsDimens.space12),
      child: PsDateTimePickerWithIconWidget(
          iconData: Icons.schedule,
          title: widget.customField.name!.tr,
          textEditingController: element.value.valueTextController,
          isStar: true,
          hintText: widget.customField.placeHolder!.tr,
          onTap: () async {
            await DatePicker.showTimePicker(
              context,
              showSecondsColumn: false,
              onConfirm: (DateTime date) {
                // itemPromotionProvider!.selectedDateTime = date;
                setState(() {
                  element.value.valueTextController.text =
                      DateFormat.Hm('en_US').format(date);
                });
              },
              locale: LocaleType.en,
            );
          }),
    );
  }
}
