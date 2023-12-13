import 'package:flutter/material.dart';
import 'package:psxmpc/ui/vendor_ui/common/custom_ui/detail_ui_type/detail_checkbox.dart';
import 'package:psxmpc/ui/vendor_ui/common/custom_ui/detail_ui_type/detail_multi_select.dart';
import 'package:psxmpc/ui/vendor_ui/common/custom_ui/detail_ui_type/detail_text.dart';
import 'package:psxmpc/ui/vendor_ui/common/custom_ui/ui_type/image.dart';

import '../../../../core/vendor/constant/ps_constants.dart';
import '../../../../core/vendor/viewobject/custom_field.dart';

class PsDetailCustomWidget extends StatefulWidget {
  const PsDetailCustomWidget({
    Key? key,
    required this.customField,
    required this.valueTextController,
    required this.idTextController,
  }) : super(key: key);
  final CustomField customField;
  final TextEditingController valueTextController;
  final TextEditingController idTextController;

  @override
  State<PsDetailCustomWidget> createState() => _PsDetailCustomWidgetState();
}

class _PsDetailCustomWidgetState extends State<PsDetailCustomWidget> {
  Widget buildCustomUi() {
    switch (widget.customField.uiType?.coreKeyId) {
      case PsConst.DROP_DOWN_BUTTON:
        return DetailTextWidget(
          customField: widget.customField,
        );

      case PsConst.TEXT:
        return DetailTextWidget(
          customField: widget.customField,
        );

      case PsConst.RADIO_BUTTON:
        return DetailTextWidget(
          customField: widget.customField,
        );

      case PsConst.CHECK_BOX:
        return DetailCheckBoxWidget(
          customField: widget.customField,
        );

      case PsConst.DATETIME_PICKER:
        return DetailTextWidget(
          customField: widget.customField,
        );

      case PsConst.TEXT_AREA:
        return DetailTextWidget(
          customField: widget.customField,
        );

      case PsConst.NUMBER:
        return DetailTextWidget(
          customField: widget.customField,
        );

      case PsConst.MULTI_SELECTION:
        return DetailMultiSelectionWidget(
          customField: widget.customField,
        );

      case PsConst.IMAGE:
        return const ImageWidget();

      case PsConst.DATE_ONLY_PICKER:
        return DetailTextWidget(
          customField: widget.customField,
        );

      case PsConst.TIME_ONLY_PICKER:
        return DetailTextWidget(
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
