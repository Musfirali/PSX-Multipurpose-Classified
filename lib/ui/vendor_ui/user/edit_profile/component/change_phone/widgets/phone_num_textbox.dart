import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';

import '../../../../../../../config/route/route_paths.dart';
import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../../core/vendor/viewobject/phone_country_code.dart';

class PhoneNumberTextBox extends StatefulWidget {
  const PhoneNumberTextBox(
      {required this.phoneController,
      required this.countryCodeController,
      required this.phoneNum});

  final TextEditingController phoneController;
  final TextEditingController countryCodeController;
  final String phoneNum;

  @override
  State<PhoneNumberTextBox> createState() => _PhoneNumberTextBoxState();
}

class _PhoneNumberTextBoxState extends State<PhoneNumberTextBox> {
  PsValueHolder? psValueHolder;

  @override
  Widget build(BuildContext context) {
    psValueHolder = Provider.of<PsValueHolder>(context);
    const EdgeInsets _marginEdgeInsetsforCard = EdgeInsets.only(
      right: PsDimens.space16,
    );

    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          border: Border.all(color: PsColors.text400)),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                width: 72,
                height: 40,
                decoration: BoxDecoration(
                    border: Border(
                        right:
                            BorderSide(color: Utils.isLightMode(context) ? PsColors.text400 : PsColors.text300))),
                child: InkWell(
                  onTap: () async {
                    final dynamic returnEditPhone = await Navigator.pushNamed(
                        context, RoutePaths.phoneCountryCode);
                    if (returnEditPhone != null) {
                      final PhoneCountryCode returnCountryCode =
                          returnEditPhone as PhoneCountryCode;
                      setState(() {
                        widget.countryCodeController.text =
                            returnCountryCode.countryCode!;
                      });
                    }
                  },
                  highlightColor: PsColors.primary900,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(
                        width: PsDimens.space2,
                      ),
                      Text(
                        widget.countryCodeController.text == ''
                            ? psValueHolder!.defaulPhoneCountryCode
                            : widget.countryCodeController.text,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Utils.isLightMode(context)
                                ? PsColors.text700
                                : PsColors.text100),
                      ),
                      const Icon(Icons.arrow_drop_down_sharp)
                    ],
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                width: 158,
                height: 40,
                margin: _marginEdgeInsetsforCard,
                child: Directionality(
                    textDirection:
                        Directionality.of(context) == TextDirection.ltr
                            ? TextDirection.ltr
                            : TextDirection.rtl,
                    child: TextField(
                      controller: widget.phoneController,
                      textDirection: TextDirection.ltr,
                      textAlign: Directionality.of(context) == TextDirection.ltr
                          ? TextAlign.left
                          : TextAlign.right,
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: Utils.isLightMode(context)
                              ? PsColors.text700
                              : PsColors.text100),
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(
                            left: PsDimens.space12,
                            right: PsDimens.space12,
                            bottom: PsDimens.space8),
                        border: InputBorder.none,
                        hintText: '123456789',
                        hintStyle: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(color: PsColors.text400),
                      ),
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
