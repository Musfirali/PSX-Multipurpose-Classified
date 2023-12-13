import 'package:flutter/material.dart';
import 'package:psxmpc/config/ps_colors.dart';
import '../../../../core/vendor/constant/ps_constants.dart';
import '../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../core/vendor/utils/utils.dart';
import '../../../../core/vendor/viewobject/offline_payment.dart';
import '../../common/ps_ui_widget.dart';

class OfflinePaymentItem extends StatelessWidget {
  const OfflinePaymentItem({
    Key? key,
    required this.offlinePayment,
    this.animationController,
    this.animation,
  }) : super(key: key);

  final OfflinePayment offlinePayment;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    final Widget _dividerWidget = Divider(
      height: PsDimens.space4,
      color: PsColors.achromatic500,
    );
    animationController!.forward();
    return AnimatedBuilder(
        animation: animationController!,
        child: Column(
          children: <Widget>[
            Container(
                color: Utils.isLightMode(context) ? PsColors.achromatic50
              : PsColors.achromatic900,
                margin: const EdgeInsets.only(top: PsDimens.space8),
                child: Ink(
                    child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                PsNetworkImageWithUrl(
                                  photoKey: '',
                                  imagePath:
                                      offlinePayment.defaultIcon!.imgPath,
                                  width: PsDimens.space64,
                                  height: PsDimens.space64,
                                  imageAspectRation: PsConst.Aspect_Ratio_1x,
                                  onTap: () {},
                                ),
                                const SizedBox(
                                  width: PsDimens.space12,
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(offlinePayment.title!,
                                          textAlign: TextAlign.start,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .copyWith(
                                                  color: Theme.of(context).primaryColor,
                                                  fontWeight: FontWeight.bold)),
                                      const SizedBox(
                                        height: PsDimens.space8,
                                      ),
                                      Text(
                                        offlinePayment.description!,
                                        textAlign: TextAlign.start,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        )))),
            _dividerWidget
          ],
        ),
        builder: (BuildContext context, Widget? child) {
          return FadeTransition(
            opacity: animation!,
            child: Transform(
                transform: Matrix4.translationValues(
                    0.0, 100 * (1.0 - animation!.value), 0.0),
                child: child),
          );
        });
  }
}
