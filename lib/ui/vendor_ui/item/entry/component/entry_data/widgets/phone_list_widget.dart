import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';

import '../../../../../../../config/route/route_paths.dart';
import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/provider/entry/helper/phone_no_controller.dart';
import '../../../../../../../core/vendor/provider/entry/item_entry_provider.dart';
import '../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../../core/vendor/viewobject/phone_country_code.dart';
import '../../../../../common/ps_button_widget.dart';

class PhoneListWidget extends StatefulWidget {
  const PhoneListWidget({
    required this.isMandatory,
  });
  final bool isMandatory;
  @override
  State<StatefulWidget> createState() => _PhoneListWidget();
}

class _PhoneListWidget extends State<PhoneListWidget> {
  late ItemEntryProvider itemEntryProvider;

  @override
  Widget build(BuildContext context) {
    itemEntryProvider = Provider.of<ItemEntryProvider>(context);
    final PsValueHolder psValueHolder =
        Provider.of<PsValueHolder>(context, listen: false);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(
              top: PsDimens.space12,
              bottom: PsDimens.space12,
              right: PsDimens.space16,
              left: PsDimens.space16),
          child: Row(
            children: <Widget>[
              Text(
                'item_entry__contact_number'.tr,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              if (widget.isMandatory)
                Text('*',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Utils.isLightMode(context)
                            ? PsColors.primary500
                            : PsColors.primary300))
            ],
          ),
        ),
        ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: itemEntryProvider.phoneNumList.length <=
                    psValueHolder.phoneListCount!
                ? itemEntryProvider.phoneNumList.length
                : psValueHolder.phoneListCount,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: PsDimens.space44,
                margin: const EdgeInsets.only(
                    left: PsDimens.space16,
                    right: PsDimens.space16,
                    bottom: PsDimens.space10),
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: Container(
                        height: PsDimens.space44,
                        margin: const EdgeInsets.only(
                            right: PsDimens.space4, left: PsDimens.space4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(PsDimens.space4),
                          border: Border.all(color: PsColors.text400),
                        ),
                        child: Row(
                          children: <Widget>[
                            InkWell(
                              onTap: () async {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                final dynamic result =
                                    await Navigator.pushNamed(
                                        context, RoutePaths.phoneCountryCode);
                                if (result != null &&
                                    result is PhoneCountryCode) {
                                  itemEntryProvider
                                      .phoneNumList[index]
                                      .countryCodeController
                                      .text = result.countryCode!;
                                }
                              },
                              child: Container(
                                width: PsDimens.space60,
                                height: PsDimens.space44,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: PsDimens.space12),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      itemEntryProvider.phoneNumList
                                          .elementAt(index)
                                          .countryCodeController
                                          .text,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                              fontWeight:
                                                  FontWeight.normal),
                                    ),
                                    const Icon(
                                      Icons.keyboard_arrow_down_outlined,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              color: Utils.isLightMode(context)
                                  ? PsColors.text400
                                  : PsColors.text300,
                              width: PsDimens.space1,
                            ),
                            Expanded(
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  maxLines: 1,
                                  controller: itemEntryProvider.phoneNumList
                                      .elementAt(index)
                                      .phoneNumController,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(fontWeight: FontWeight.normal),
                                  decoration: InputDecoration(
                                    hintText: '971234567',
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                            color: PsColors.text400),
                                    contentPadding: const EdgeInsets.only(
                                        right: PsDimens.space12,
                                        left: PsDimens.space12,
                                        bottom: PsDimens.space4),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    if (index == 0)
                      PSButtonWithIconWidget(
                        colorData: Utils.isLightMode(context)
                            ? PsColors.primary500
                            : PsColors.primary300,
                        width: PsDimens.space36,
                        height: PsDimens.space36,
                        icon: Icons.add,
                        onPressed: () {
                          if (itemEntryProvider.phoneNumList.length <
                              psValueHolder.phoneListCount!) {
                            final TextEditingController codeContrller =
                                TextEditingController();
                            codeContrller.text =
                                psValueHolder.defaulPhoneCountryCode;
                            itemEntryProvider.addPhoneNum(PhoneNoController(
                                countryCodeController: codeContrller,
                                phoneNumController: TextEditingController()));
                          } else {
                            Fluttertoast.showToast(
                                msg:
                                    'You can add only ${psValueHolder.phoneListCount} contact numbers.',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: PsColors.accent300,
                                textColor: PsColors.achromatic700);
                          }
                        },
                      )
                    else
                      PSButtonWithIconWidget(
                        colorData: Utils.isLightMode(context)
                            ? PsColors.primary500
                            : PsColors.primary300,
                        width: PsDimens.space36,
                        height: PsDimens.space36,
                        icon: Icons.remove,
                        onPressed: () {
                          itemEntryProvider.removePhoneNum(index);
                        },
                      )
                  ],
                ),
              );
            }),
        const SizedBox(
          height: PsDimens.space4,
        ),
      ],
    );
  }
}
