import 'package:flutter/material.dart';
import 'package:psxmpc/ui/vendor_ui/common/custom_ui/ui_type/image.dart';
import 'package:psxmpc/ui/vendor_ui/common/user_custom_ui/user_ui_type/checkbox.dart';
import 'package:psxmpc/ui/vendor_ui/common/user_custom_ui/user_ui_type/date_only_picker.dart';
import 'package:psxmpc/ui/vendor_ui/common/user_custom_ui/user_ui_type/datetime_picker.dart';
import 'package:psxmpc/ui/vendor_ui/common/user_custom_ui/user_ui_type/dropdown.dart';
import 'package:psxmpc/ui/vendor_ui/common/user_custom_ui/user_ui_type/multi_select.dart';
import 'package:psxmpc/ui/vendor_ui/common/user_custom_ui/user_ui_type/number.dart';
import 'package:psxmpc/ui/vendor_ui/common/user_custom_ui/user_ui_type/radio.dart';
import 'package:psxmpc/ui/vendor_ui/common/user_custom_ui/user_ui_type/text.dart';
import 'package:psxmpc/ui/vendor_ui/common/user_custom_ui/user_ui_type/textarea.dart';
import 'package:psxmpc/ui/vendor_ui/common/user_custom_ui/user_ui_type/time_only_picker.dart';
import '../../../../core/vendor/constant/ps_constants.dart';
import '../../../../core/vendor/viewobject/custom_field.dart';

class PsUserCustomWidget extends StatefulWidget {
  const PsUserCustomWidget({
    Key? key,
    required this.customField,
    required this.valueTextController,
    required this.idTextController,
  }) : super(key: key);
  final CustomField customField;
  final TextEditingController valueTextController;
  final TextEditingController idTextController;

  @override
  State<PsUserCustomWidget> createState() => _PsCustomWidgetState();
}

class _PsCustomWidgetState extends State<PsUserCustomWidget> {
  Widget buildCustomUi() {
    switch (widget.customField.uiType?.coreKeyId) {
      case PsConst.DROP_DOWN_BUTTON:
        return UserDropDownWidget(
          customField: widget.customField,
        );

      case PsConst.TEXT:
        return UserTextWidget(
          customField: widget.customField,
        );

      case PsConst.RADIO_BUTTON:
        return UserRadioButtonListWidget(
          customField: widget.customField,
        );

      case PsConst.CHECK_BOX:
        return UserCheckBoxWidget(
          customField: widget.customField,
        );

      case PsConst.DATETIME_PICKER:
        return UserDateTimePickerWidget(
          customField: widget.customField,
        );

      case PsConst.TEXT_AREA:
        return UserTextAreaWidget(
          customField: widget.customField,
        );

      case PsConst.NUMBER:
        return UserNumberWidget(
          customField: widget.customField,
        );

      case PsConst.MULTI_SELECTION:
        return UserMultiSelectionWidget(
          customField: widget.customField,
        );

      case PsConst.IMAGE:
        return const ImageWidget();

      case PsConst.DATE_ONLY_PICKER:
        return UserDatePickerWidget(
          customField: widget.customField,
        );

      case PsConst.TIME_ONLY_PICKER:
        return UserTimePickerWidget(
          customField: widget.customField,
        );

      default:
        return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.customField.isVisible,
      child: buildCustomUi(),
    );
  }
}
