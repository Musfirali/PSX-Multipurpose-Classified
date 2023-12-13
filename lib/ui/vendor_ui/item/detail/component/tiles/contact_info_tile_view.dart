import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/core/vendor/viewobject/common/ps_value_holder.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/product/product_provider.dart';
import '../../../../../../core/vendor/utils/utils.dart';

class ContactListWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ContactListWidgetWidget();
}

class _ContactListWidgetWidget extends State<ContactListWidget> {
  @override
  Widget build(BuildContext context) {
    final PsValueHolder valueHolder =
        Provider.of<PsValueHolder>(context, listen: false);
    final ItemDetailProvider provider =
        Provider.of<ItemDetailProvider>(context);
    final List<String> phoneList =
        provider.product.phoneNumList?.split('#') ?? <String>[];
    phoneList.removeWhere((String phone) => phone == '');
    return SliverToBoxAdapter(
        child: provider.hasData && phoneList.isNotEmpty
            ? Container(
                margin: const EdgeInsets.only(
                    left: PsDimens.space16,
                    right: PsDimens.space16,
                    top: PsDimens.space16),
                decoration: BoxDecoration(
                  color: Utils.isLightMode(context)
                          ? PsColors.text50
                          : PsColors.achromatic700,
                  borderRadius:
                      const BorderRadius.all(Radius.circular(PsDimens.space4)),
                ),
                child: Column(
                  children: <Widget>[
                    if (provider.product.phoneNumList != '')
                      Container(
                        margin: const EdgeInsets.only(
                            top: PsDimens.space8,
                            right: PsDimens.space16,
                            left: PsDimens.space16),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.phone,
                              size: 25,
                              color: Utils.isLightMode(context)
                                  ? PsColors.text800
                                  : PsColors.text50,
                            ),
                            const SizedBox(
                              width: PsDimens.space4,
                            ),
                            Text(
                              'Contact',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      color: Utils.isLightMode(context)
                                          ? PsColors.text800
                                          : PsColors.text50,
                                      fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, bottom: 8),
                        itemCount:
                            phoneList.length <= valueHolder.phoneListCount!
                                ? phoneList.length
                                : valueHolder.phoneListCount,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            margin: const EdgeInsets.only(top: 16),
                            child: Row(
                              children: <Widget>[
                                Flexible(
                                  child: Row(
                                    children: <Widget>[
                                      InkWell(
                                        child: Ink(
                                          color: Utils.isLightMode(context)
                                              ? PsColors.achromatic50
                                              : PsColors.achromatic900,
                                          child: Text(
                                            phoneList.elementAt(index),
                                            // .countryCodeController
                                            // .text,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.normal),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    InkWell(
                                      child: Icon(Icons.call,
                                          size: 25,
                                          color: Utils.isLightMode(context)
                                              ? PsColors.primary500
                                              : PsColors.primary300),
                                      onTap: () async {
                                        if (await canLaunchUrl(Uri.parse(
                                            'tel://${phoneList[index]}'))) {
                                          await launchUrl(Uri.parse(
                                              'tel://${phoneList[index]}'));
                                        } else {
                                          throw 'Could not Call Phone Number 1';
                                        }
                                      },
                                    ),
                                    const SizedBox(width: PsDimens.space10),
                                    InkWell(
                                        onTap: () async {
                                          if (await canLaunchUrl(Uri.parse(
                                              'sms://${phoneList[index]}'))) {
                                            await launchUrl(Uri.parse(
                                                'sms://${phoneList[index]}'));
                                          } else {
                                            throw 'Could not send Phone Number 1';
                                          }
                                        },
                                        child: Icon(Icons.sms,
                                            size: 25,
                                            color: Utils.isLightMode(context)
                                                ? PsColors.primary500
                                                : PsColors.primary300)),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }),
                  ],
                ),
              )
            : const SizedBox());
  }
}
