import 'package:flutter/material.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../core/vendor/constant/ps_dimens.dart';
import '../../../core/vendor/utils/utils.dart';

class PsDropdownBaseWidget extends StatelessWidget {
  const PsDropdownBaseWidget(
      {Key? key, this.title, required this.onTap, this.selectedText, this.icon})
      : super(key: key);

  final String? title;
  final String? selectedText;
  final Function onTap;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        if (title != null && title != '')
          Container(
            margin: const EdgeInsets.only(
                left: PsDimens.space16,
                top: PsDimens.space4,
                right: PsDimens.space16),
            child: Row(
              children: <Widget>[
                Text(
                  title!,
                  maxLines: 1,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ),
        Container(
          margin: const EdgeInsets.all(PsDimens.space16),
          child: InkWell(
            onTap: onTap as void Function()?,
            child: Container(
              width: double.infinity,
              height: PsDimens.space44,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(PsDimens.space4),
                border: Border.all(color: PsColors.text200),
              ),
              // child: Ink(
              //   color: PsColors.primary50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding:
                              const EdgeInsets.only(left: PsDimens.space16),
                          child: Text(
                            selectedText == null || selectedText == ''
                                ? 'home_search__not_set'.tr
                                : selectedText!,
                            overflow: TextOverflow.ellipsis,
                            style: selectedText == ''
                                ? Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                        color: Utils.isLightMode(context) ? PsColors.text900: PsColors.text50)
                                : Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: PsDimens.space6),
                    child: Icon(
                      Icons.keyboard_arrow_right,
                    ),
                  ),
                ],
              ),
              // ),
            ),
          ),
        ),
      ],
    );
  }
}
