import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../core/vendor/provider/rating/rating_provider.dart';
import '../../../../../core/vendor/repository/rating_repository.dart';
import '../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../core/vendor/viewobject/rating.dart';
import '../../../../custom_ui/rating/component/dialog/widgets/rating_submit_button.dart';
import '../../../../custom_ui/rating/component/dialog/widgets/rating_title.dart';
import '../../../common/ps_textfield_widget.dart';
import '../../../common/smooth_star_rating_widget.dart';

class RatingInputDialog extends StatefulWidget {
  const RatingInputDialog(
      {Key? key,
      required this.buyerUserId,
      required this.sellerUserId,
      this.rating,
      this.isEdit = true})
      : super(key: key);

  final String? buyerUserId;
  final String? sellerUserId;
  final Rating? rating;
  final bool isEdit;

  @override
  _RatingInputDialogState createState() => _RatingInputDialogState();
}

class _RatingInputDialogState extends State<RatingInputDialog> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  PsValueHolder? psValueHolder;
  RatingRepository? ratingRepo;
  double? rating;
  bool isBindData = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ratingRepo = Provider.of<RatingRepository>(context);
    psValueHolder = Provider.of<PsValueHolder>(context);

    if (isBindData && widget.rating != null) {
      titleController.text = widget.rating!.title!;
      descriptionController.text = widget.rating!.description!;
      isBindData = false;
    }

    return ChangeNotifierProvider<RatingProvider>(
        lazy: false,
        create: (BuildContext context) {
          final RatingProvider provider = RatingProvider(repo: ratingRepo);
          return provider;
        },
        child: Consumer<RatingProvider>(builder:
            (BuildContext context, RatingProvider provider, Widget? child) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)), //this right here
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  CustomRatingTitle(isEdit: widget.isEdit),
                  const SizedBox(
                    height: PsDimens.space16,
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        'How was the experience?'.tr,
                        style:
                            Theme.of(context).textTheme.bodyMedium!.copyWith(),
                      ),
                      if (widget.rating == null)
                        SmoothStarRating(
                            isRTl:
                                Directionality.of(context) == TextDirection.rtl,
                            allowHalfRating: false,
                            rating: 0.0,
                            starCount: 5,
                            size: PsDimens.space40,
                            color: PsColors.warning500,
                            onRated: (double? rating1) {
                              setState(() {
                                rating = rating1;
                              });
                            },
                            borderColor: PsColors.achromatic500.withAlpha(100),
                            spacing: 0.0)
                      else
                        SmoothStarRating(
                            isRTl:
                                Directionality.of(context) == TextDirection.rtl,
                            allowHalfRating: false,
                            rating: double.parse(widget.rating!.rating!),
                            starCount: 5,
                            size: PsDimens.space40,
                            color: PsColors.warning500,
                            onRated: (double? rating1) {
                              setState(() {
                                rating = rating1;
                              });
                            },
                            borderColor: PsColors.achromatic500.withAlpha(100),
                            spacing: 0.0),
                      PsTextFieldWidget(
                          titleText: 'rating_entry__title'.tr,
                          hintText: 'Enter Title'.tr,
                          textEditingController: titleController),
                      PsTextFieldWidget(
                          height: PsDimens.space80,
                          keyboardType: TextInputType.multiline,
                          titleText: 'rating_entry__message'.tr,
                          hintText: 'Enter Description'.tr,
                          textEditingController: descriptionController),
                      // Divider(
                      //   color: PsColors.achromatic500,
                      //   height: 0.5,
                      // ),
                      const SizedBox(
                        height: PsDimens.space16,
                      ),
                      CustomRatingSubmitButton(
                        descriptionController: descriptionController,
                        titleController: titleController,
                        rating: rating,
                        buyerUserId: widget.buyerUserId,
                        sellerUserId: widget.sellerUserId,
                      ),
                      const SizedBox(
                        height: PsDimens.space16,
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        }));
  }
}
