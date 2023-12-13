import 'package:flutter/material.dart';

import '../../../../../../../../core/vendor/provider/app_info/app_info_provider.dart';
import '../../../../../../../../core/vendor/provider/promotion/item_promotion_provider.dart';
import '../../../../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../../../../core/vendor/viewobject/product.dart';
import '../../../../../../../vendor_ui/item/promote/component/promote/ad_how_many_day/widgets/razor_button.dart';

class CustomRazorButton extends StatelessWidget {
  const CustomRazorButton(
      {required this.product,
        required this.amount, 
        required this.howManyDay, 
        required this.selectedDate,
        required this.selectedTime,
        required this.provider,
        required this.appProvider,
        required this.userProvider
      });

  final Product product;
  final String howManyDay;
  final String amount;
  final String selectedDate;
  final DateTime selectedTime;
  final ItemPromotionProvider? provider;
  final AppInfoProvider? appProvider;
  final UserProvider? userProvider;
  
  @override
  Widget build(BuildContext context) {
    return RazorButton(
        howManyDay: howManyDay,
        amount: amount,
        selectedDate: selectedDate,
        selectedTime: selectedTime,
        product: product,
        provider: provider,
        appProvider: appProvider,
        userProvider: userProvider,);
  }
}
