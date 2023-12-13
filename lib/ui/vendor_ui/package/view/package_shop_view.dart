import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../../../core/vendor/api/common/ps_resource.dart';
import '../../../../core/vendor/api/common/ps_status.dart';
import '../../../../core/vendor/constant/ps_constants.dart';
import '../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../core/vendor/provider/package_bought/package_bought_provider.dart';
import '../../../../core/vendor/repository/package_bought_repository.dart';
import '../../../../core/vendor/utils/ps_progress_dialog.dart';
import '../../../../core/vendor/viewobject/api_status.dart';
import '../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../core/vendor/viewobject/holder/package_bought_parameter_holder.dart';
import '../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../../core/vendor/viewobject/package.dart';
import '../../../custom_ui/package/component/package/package_item.dart';
import '../../common/base/ps_widget_with_multi_provider.dart';
import '../../common/dialog/error_dialog.dart';
import '../../common/dialog/success_dialog.dart';
import '../../common/ps_app_bar_widget.dart';
import '../../common/ps_ui_widget.dart';


class PackageShopInAppPurchaseView extends StatefulWidget {
  const PackageShopInAppPurchaseView({required this.androidKeyList, required this.iosKeyList});
  final String? androidKeyList;
  final String? iosKeyList;

  @override
  _PackageShopInAppPurchaseViewState createState() =>
      _PackageShopInAppPurchaseViewState();
}

class _PackageShopInAppPurchaseViewState
    extends State<PackageShopInAppPurchaseView> {
  /// Is the API available on the device
  bool available = true;

  /// The In App Purchase plugin
  final InAppPurchase _iap = InAppPurchase.instance;

  /// Products for sale
  List<ProductDetails> _products = <ProductDetails>[];

  /// Updates to purchases
  late StreamSubscription<List<PurchaseDetails>>? _subscription;

  final String _kConsumableId = 'consumable';
  final bool _kAutoConsume = true;
  String? amount;

  PackageBoughtRepository? repo1;
  PsValueHolder? psValueHolder;
  PackageBoughtProvider? packageBoughtProvider;
   late AppLocalization langProvider;

  /// Initialize data
  Future<void> _initialize() async {
    // Check availability of In App Purchases
    available = await _iap.isAvailable();

    if (available) {
      await _getProducts();

      // Listen to new purchases
      _subscription = _iap.purchaseStream.listen(
          (List<PurchaseDetails> purchaseDetailsList) {
        _listenToPurchaseUpdated(purchaseDetailsList);
      }, onDone: () {
        print('Done Purhcase');
        _subscription?.cancel();
      }, onError: (dynamic error) {
        print(error);
        print('Error Purchase');
        PsProgressDialog.dismissDialog();
        // handle error here.
      });
    }
  }

  Set<String> idListByPlatfrom() {
    String keyListString = '';

    if (Platform.isAndroid && widget.androidKeyList != null) {
      keyListString = widget.androidKeyList!;
    } else if (Platform.isIOS && widget.iosKeyList != null) {
      keyListString = widget.iosKeyList!;
    }
    // ignore: prefer_final_locals
    List<String> keyList = keyListString.split('##');
    keyList.removeLast();
    return keyList.toSet();
  }

  /// Get all products available for sale
  Future<void> _getProducts() async {
    ProductDetailsResponse response;
    response = await _iap.queryProductDetails(idListByPlatfrom());
    setState(() {
      _products = response.productDetails;
    });
  }

  Future<void> _listenToPurchaseUpdated(
      List<PurchaseDetails> purchaseDetailsList) async {  
    for (PurchaseDetails purchaseDetails in purchaseDetailsList) {
      if (Platform.isAndroid) {
        if (!_kAutoConsume && purchaseDetails.productID == _kConsumableId) {
          final InAppPurchaseAndroidPlatformAddition androidAddition =
              _iap.getPlatformAddition<InAppPurchaseAndroidPlatformAddition>();
          await androidAddition.consumePurchase(purchaseDetails);
        }
      }
      if (purchaseDetails.pendingCompletePurchase) {
        await PsProgressDialog.showDialog(context);
        await _iap.completePurchase(purchaseDetails);
      }

      if (purchaseDetails.status == PurchaseStatus.purchased) {
        
        //
        // Call PS Server
        //
        print('NEW PURCHASE');
        print(purchaseDetails.status);
        final Package package = getPackageByIAPKey(purchaseDetails.productID)!;
        final PackgageBoughtParameterHolder packgageBoughtParameterHolder =
            PackgageBoughtParameterHolder(
                userId: psValueHolder!.loginUserId,
                packageId: package.packageId,
                paymentMethod: PsConst.PAYMENT_IN_APP_PURCHASE_METHOD,
                price: amount,
                razorId: '',
                isPaystack: PsConst.ZERO);
        final PsResource<ApiStatus> packageBoughtStatus =
            await packageBoughtProvider!
                .postData(requestPathHolder: RequestPathHolder(loginUserId: psValueHolder!.loginUserId, headerToken: psValueHolder!.headerToken),
                  requestBodyHolder: packgageBoughtParameterHolder);
        PsProgressDialog.dismissDialog();
        if (packageBoughtStatus.status == PsStatus.SUCCESS) {
          showDialog<dynamic>(
              context: context,
              builder: (BuildContext contet) {
                return SuccessDialog(
                  message: 'item_entry__buy_package_success'.tr,
                  onPressed: () {
                    Navigator.pop(context, package.paymentAttributes!.count);
                  },
                );
              });
        } else {
          showDialog<dynamic>(
              context: context,
              builder: (BuildContext context) {
                return ErrorDialog(
                  message: packageBoughtStatus.message,
                );
              });
        }
      }
      PsProgressDialog.dismissDialog();
    }
  }

  /// Purchase a product
  Future<void> _buyProduct(ProductDetails prod) async {
    final ProductDetails productDetails = prod;

    final PurchaseParam purchaseParam =
        PurchaseParam(productDetails: productDetails);

    if (Platform.isIOS) {
      //
    }

    try {
      // if (productDetails.id == _kConsumableId) {
      final bool status = await _iap.buyConsumable(
          purchaseParam: purchaseParam);
      print(status);
      // }
    } catch (e) {
      print('error');
      PsProgressDialog.dismissDialog();
      if (Platform.isIOS) {
        // }
      }
    }
  }

  Package? getPackageByIAPKey(String key) {
    final int index = packageBoughtProvider!.packageList.data!
        .indexWhere((Package package) =>  package.coreKey!.name == key);
    if (index == -1) 
      return null;    
    final Package package =
        packageBoughtProvider!.packageList.data!.elementAt(index);
    return package;
  }

  @override
  void initState() {
    _initialize();
    super.initState();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    repo1 = Provider.of<PackageBoughtRepository>(context);
    psValueHolder = Provider.of<PsValueHolder>(context);
    langProvider = Provider.of<AppLocalization>(context);

    return Scaffold(
      appBar: PsAppbarWidget(appBarTitle: 'item_entry__package_shop'.tr),
      body: PsWidgetWithMultiProvider(
        child: MultiProvider(
            providers: <SingleChildWidget>[
              ChangeNotifierProvider<PackageBoughtProvider?>(
                lazy: false,
                create: (BuildContext context) {
                  packageBoughtProvider = PackageBoughtProvider(repo: repo1);
                  packageBoughtProvider!.loadDataList(
                    requestPathHolder: RequestPathHolder(
                      loginUserId: psValueHolder!.loginUserId,languageCode: langProvider.currentLocale.languageCode
                    )
                  );

                  return packageBoughtProvider;
                },
              ),
            ],
            child: Consumer<PackageBoughtProvider>(
              builder: (BuildContext context, PackageBoughtProvider provider,
                  Widget? child) {
                if (provider.hasData) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        top: PsDimens.space10, 
                        right: PsDimens.space8),
                    child: Stack(
                      children: <Widget>[
                        CustomScrollView(
                            // scrollDirection: Axis.horizontal,
                            // shrinkWrap: false,
                            slivers: <Widget>[
                              SliverList(
                                // gridDelegate:
                                //     const SliverGridDelegateWithMaxCrossAxisExtent(
                                //         maxCrossAxisExtent: 160.0,
                                //         childAspectRatio: 1.6),
                                delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                    final Package? package =
                                        getPackageByIAPKey(_products[index].id);
                                    if (package == null) {
                                      return const SizedBox();
                                    }    
                                    return CustomPackageItem(
                                      package: package,
                                      priceWithCurrency:
                                          _products[index].price,
                                      onTap: () {
                                        amount = _products[index].price;
                                        _buyProduct(_products[index]);
                                      },
                                    );
                                  },
                                  childCount: _products.length,
                                ),
                              ),
                            ]),
                            PSProgressIndicator(provider.packageList.status)
                      ],
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              },
            )),
      ),
    );
  }
}