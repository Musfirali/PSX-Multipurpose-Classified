import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';

import '../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/provider/rating/rating_provider.dart';
import '../../../../../../core/vendor/utils/ps_progress_dialog.dart';
import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../core/vendor/viewobject/holder/rating_holder.dart';
import '../../../../common/dialog/warning_dialog_view.dart';
import '../../../../common/ps_button_widget.dart';

class RatingSubmitButton extends StatelessWidget {
  const RatingSubmitButton(
      {Key? key,
      required this.titleController,
      required this.descriptionController,
      required this.rating,
      required this.buyerUserId,
      required this.sellerUserId})
      : super(key: key);

  final TextEditingController titleController, descriptionController;
  final double? rating;
  final String? buyerUserId;
  final String? sellerUserId;

  @override
  Widget build(BuildContext context) {
    final PsValueHolder? psValueHolder = Provider.of<PsValueHolder>(context);
    final RatingProvider provider = Provider.of<RatingProvider>(context);
    late RatingParameterHolder commentHeaderParameterHolder;
    final AppLocalization? langProvider = Provider.of<AppLocalization>(context);
    return Padding(
      padding:
          const EdgeInsets.only(left: PsDimens.space8, right: PsDimens.space8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          SizedBox(
            width: PsDimens.space80,
            height: PsDimens.space36,
            child: PSButtonWidget(
              hasShadow: false,
              colorData: PsColors.achromatic500,
              width: double.infinity,
              titleText: 'rating_entry__cancel'.tr,
              onPressed: () async {
                Navigator.pop(context);
              },
            ),
          ),
          const SizedBox(
            width: PsDimens.space8,
          ),
          SizedBox(
            width: PsDimens.space80,
            height: PsDimens.space36,
            child: PSButtonWidget(
              hasShadow: true,
              colorData: Theme.of(context).primaryColor,
              width: double.infinity,
              titleText: 'rating_entry__submit'.tr,
              onPressed: () async {
                if (titleController.text.isNotEmpty &&
                    descriptionController.text.isNotEmpty &&
                    rating != null &&
                    rating.toString() != '0.0') {
                  if (buyerUserId == psValueHolder!.loginUserId) {
                    commentHeaderParameterHolder = RatingParameterHolder(
                        fromUserId: buyerUserId,
                        toUserId: sellerUserId,
                        title: titleController.text,
                        description: descriptionController.text,
                        rating: rating.toString(),
                        type: PsConst.RATING_TYPE_USER);
                  }
                  if (sellerUserId == psValueHolder.loginUserId) {
                    commentHeaderParameterHolder = RatingParameterHolder(
                        fromUserId: sellerUserId,
                        toUserId: buyerUserId,
                        title: titleController.text,
                        description: descriptionController.text,
                        rating: rating.toString(),
                        type: PsConst.RATING_TYPE_USER);
                  }

                  await PsProgressDialog.showDialog(context);
                  await provider.postRating(
                      commentHeaderParameterHolder.toMap(),
                      psValueHolder.loginUserId ?? '',
                      psValueHolder.headerToken!,
                      langProvider!.currentLocale.languageCode);
                  PsProgressDialog.dismissDialog();

                  Navigator.of(context).pop();
                  Fluttertoast.showToast(
                      msg: 'Rating Successed!!!',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: PsColors.accent300,
                      textColor: PsColors.achromatic700);
                } else {
                  print('There is no comment');

                  showDialog<dynamic>(
                      context: context,
                      builder: (BuildContext context) {
                        return WarningDialog(
                          message: 'rating_entry__error'.tr,
                          onPressed: () {},
                        );
                      });
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
