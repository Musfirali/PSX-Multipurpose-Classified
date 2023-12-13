// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_credit_card/credit_card_model.dart';
// import 'package:flutter_credit_card/credit_card_widget.dart';
// import 'package:flutter_paystack/flutter_paystack.dart';
// import '/config/ps_config.dart';
// import 'package:theme_manager/theme_manager.dart';

// class PayStackView extends StatefulWidget {
//   const PayStackView(
//       {Key? key,
//       required this.amount,
//       required this.email,
//       required this.payStackKey,
//       required this.callback})
//       : super(key: key);

//   final String amount;
//   final String payStackKey;
//   final String email;
//   final Function callback;

//   @override
//   State<StatefulWidget> createState() {
//     return PayStackViewState();
//   }
// }

// class PayStackViewState extends State<PayStackView> {
//   String cardNumber = '';
//   String expiryDate = '';
//   String cardHolderName = '';
//   String cvvCode = '';
//   bool isCvvFocused = false;
//   final PaystackPlugin plugin = PaystackPlugin();
//   @override
//   void initState() {
//     plugin.initialize(publicKey: widget.payStackKey);
//     super.initState();
//   }

//   PaymentCard callCard(String cardNumber, String expiryDate,
//       String cardHolderName, String cvvCode) {
//     final List<String> monthAndYear = expiryDate.split('/');
//     return PaymentCard(
//         number: cardNumber,
//         expiryMonth: int.parse(monthAndYear[0]),
//         expiryYear: int.parse(monthAndYear[1]),
//         name: cardHolderName,
//         cvc: cvvCode);
//   }

//   void setError(dynamic error) {
//     showDialog<dynamic>(
//         context: context,
//         builder: (BuildContext context) {
//           return ErrorDialog(
//             message: error.toString()),
//           );
//         });
//   }

//   dynamic callWarningDialog(BuildContext context, String text) {
//     showDialog<dynamic>(
//         context: context,
//         builder: (BuildContext context) {
//           return WarningDialog(
//             message: text),
//             onPressed: () {},
//           );
//         });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return PsWidgetWithAppBarWithNoProvider(
//       appBarTitle: 'item_promote__pay_stack'),
//       child: Column(
//         children: <Widget>[
//           Expanded(
//             child: SingleChildScrollView(
//                 child: Column(
//               children: <Widget>[
//                 CreditCardWidget(
//                   cardNumber: cardNumber,
//                   expiryDate: expiryDate,
//                   cardHolderName: cardHolderName,
//                   cvvCode: cvvCode,
//                   showBackView: isCvvFocused,
//                   height: 175,
//                   width: MediaQuery.of(context).size.width,
//                   animationDuration: PsConfig.animation_duration,
//                   onCreditCardWidgetChange: (dynamic data) {},
//                 ),
//                 PsCreditCardFormForPayStack(
//                   onCreditCardModelChange: onCreditCardModelChange,
//                 ),
//                 Container(
//                   margin: const EdgeInsets.only(
//                       left: PsDimens.space12, right: PsDimens.space12),
//                   child: PSButtonWidget(
//                     hasShadow: true,
//                     width: double.infinity,
//                     titleText: 'credit_card__pay'),
//                     onPressed: () async {
//                       if (cardNumber.isEmpty) {
//                         callWarningDialog(
//                             context,
//                             Utils.getString(
//                                 context, 'warning_dialog__input_number'));
//                       } else if (expiryDate.isEmpty) {
//                         callWarningDialog(
//                             context,
//                             Utils.getString(
//                                 context, 'warning_dialog__input_date'));
//                       } else if (cardHolderName.isEmpty) {
//                         callWarningDialog(
//                             context,
//                             Utils.getString(
//                                 context, 'warning_dialog__input_holder_name'));
//                       } else if (cvvCode.isEmpty) {
//                         callWarningDialog(
//                             context,
//                             Utils.getString(
//                                 context, 'warning_dialog__input_cvv'));
//                       } else {
//                         bool isLight = Utils.isLightMode(context);

//                         if (!isLight) {
//                           await ThemeManager.of(context)
//                               .setBrightnessPreference(
//                                   BrightnessPreference.light);
//                         }

//                         final Charge charge = Charge()
//                           ..amount = (double.parse(
//                                       Utils.getPriceTwoDecimal(widget.amount)) *
//                                   100)
//                               .round()
//                           ..email = widget.email
//                           ..reference = _getReference()
//                           ..card = callCard(
//                               cardNumber, expiryDate, cardHolderName, cvvCode);
//                         try {
//                           final CheckoutResponse response =
//                               await plugin.checkout(
//                             context,
//                             method: CheckoutMethod.card,
//                             charge: charge,
//                             fullscreen: false,
//                             // logo: MyLogo(),
//                           );
//                           if (!isLight) {
//                             await ThemeManager.of(context)
//                                 .setBrightnessPreference(
//                                     BrightnessPreference.dark);
//                             isLight = true;
//                           }
//                           widget.callback(response);
//                         } catch (e) {
//                           print('Check console for error');
//                           widget.callback(null);
//                           rethrow;
//                         }
//                         if (!isLight) {
//                           await ThemeManager.of(context)
//                               .setBrightnessPreference(
//                                   BrightnessPreference.dark);
//                         }
//                       }
//                     },
//                   ),
//                 ),
//                 const SizedBox(height: PsDimens.space40)
//               ],
//             )),
//           ),
//         ],
//       ),
//     );
//   }

//   String _getReference() {
//     String platform;
//     if (Platform.isIOS) {
//       platform = 'iOS';
//     } else {
//       platform = 'Android';
//     }

//     return 'ChargedFrom${platform}_${DateTime.now().millisecondsSinceEpoch}';
//   }

//   void onCreditCardModelChange(CreditCardModel? creditCardModel) {
//     if (creditCardModel != null) {
//       setState(() {
//         cardNumber = creditCardModel.cardNumber;
//         expiryDate = creditCardModel.expiryDate;
//         cardHolderName = creditCardModel.cardHolderName;
//         cvvCode = creditCardModel.cvvCode;
//         isCvvFocused = creditCardModel.isCvvFocused;
//       });
//     }
//   }
// }
