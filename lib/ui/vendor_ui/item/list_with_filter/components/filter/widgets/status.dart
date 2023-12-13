import 'package:flutter/material.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../config/ps_colors.dart';
import '../../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/provider/product/search_product_provider.dart';
import '../../../../../../../core/vendor/utils/utils.dart';

class StatusRadioView extends StatefulWidget {
  const StatusRadioView({
    required this.searchProductProvider,
  });

  final SearchProductProvider searchProductProvider;

  @override
  State<StatefulWidget> createState() => _StatusRadioViewState();
}

class _StatusRadioViewState extends State<StatusRadioView> {
  dynamic updateStatus(String status) {
    setState(() {
      widget.searchProductProvider.itemIsSoldOut = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
            top: PsDimens.space4,
            left: PsDimens.space16,
            right: PsDimens.space16,
          ),
          child: Text('Status'.tr,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Utils.isLightMode(context) ? PsColors.text900 : PsColors.text300)),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            const SizedBox(
              width: PsDimens.space8,
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Radio<String?>(
                    value: widget.searchProductProvider.itemIsSoldOut,
                    groupValue: PsConst.ONE,
                    onChanged: (String? name) {
                      updateStatus(PsConst.ONE);
                    },
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    activeColor: Theme.of(context).primaryColor,
                  ),
                  Expanded(
                    child: Text(
                      'Sold Out'.tr,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontWeight: FontWeight.w400),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Radio<String?>(
                    value: widget.searchProductProvider.itemIsSoldOut,
                    groupValue: PsConst.ZERO,
                    onChanged: (String? name) {
                      updateStatus(PsConst.ZERO);
                    },
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    activeColor: Theme.of(context).primaryColor,
                  ),
                  Expanded(
                    child: Text(
                      'Available'.tr,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontWeight: FontWeight.w400),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
