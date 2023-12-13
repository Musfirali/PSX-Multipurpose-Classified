import 'package:flutter/material.dart';

import '../../../../../../../../core/vendor/provider/app_info/app_info_provider.dart';
import '../../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../../core/vendor/provider/promotion/item_promotion_provider.dart';
import '../../../../../../../../core/vendor/provider/token/token_provider.dart';
import '../../../../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../../../../core/vendor/viewobject/product.dart';
import '../../../../../../../vendor_ui/item/promote/component/promote/ad_how_many_day/widgets/paypal_button.dart';

class CustomPayPalButton extends StatelessWidget {
  const CustomPayPalButton(
      {required this.product,
        required this.amount, 
        required this.howManyDay, 
        required this.selectedDate,
        required this.selectedTime,
        required this.tokenProvider,
        required this.provider,
        required this.appProvider,
        required this.userProvider,
        required this.langProvider
      });
  final Product product;
  final String howManyDay;
  final String amount;
  final String selectedDate;
  final DateTime selectedTime;
  final TokenProvider? tokenProvider;
  final ItemPromotionProvider? provider;
  final AppInfoProvider? appProvider;
  final UserProvider? userProvider;
  final AppLocalization? langProvider ;
  
  @override
  Widget build(BuildContext context) {
    return PayPalButton(
        howManyDay: howManyDay,
        amount: amount,
        selectedDate: selectedDate,
        selectedTime: selectedTime,
        product: product,
        tokenProvider:tokenProvider,
        provider: provider,
        appProvider: appProvider,userProvider: userProvider,langProvider: langProvider,);
  }
}
