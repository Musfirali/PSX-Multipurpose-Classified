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

class UserDateTimePickerWidget extends StatefulWidget {
  const UserDateTimePickerWidget({Key? key, required this.customField})
      : super(key: key);
  final CustomField customField;

  @override
  State<UserDateTimePickerWidget> createState() => _DateTimePickerWidgetState();
}

class _DateTimePickerWidgetState extends State<UserDateTimePickerWidget> {
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
          iconData: Icons.calendar_month,
          title: widget.customField.name!.tr,
          textEditingController: element.value.valueTextController,
          hintText: widget.customField.placeHolder!.tr,
          isStar: true,
          onTap: () async {
            await DatePicker.showDateTimePicker(
              context,
              minTime: DateTime.now(),
              onConfirm: (DateTime date) {
                setState(() {
                  element.value.valueTextController.text =
                      DateFormat.yMMMMd('en_US').format(date);
                });
              },
              locale: LocaleType.en,
            );
          }),
    );
  }
}
