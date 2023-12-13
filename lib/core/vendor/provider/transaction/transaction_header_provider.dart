import '../../api/common/ps_resource.dart';
import '../../api/common/ps_status.dart';
import '../../constant/ps_constants.dart';
import '../../repository/transaction_header_repository.dart';
import '../../utils/utils.dart';
import '../../viewobject/basket.dart';
import '../../viewobject/basket_selected_add_on.dart';
import '../../viewobject/basket_selected_attribute.dart';
import '../../viewobject/common/ps_value_holder.dart';
import '../../viewobject/transaction_header.dart';
import '../../viewobject/user.dart';
import '../common/ps_provider.dart';

class TransactionHeaderProvider extends PsProvider<TransactionHeader> {
  TransactionHeaderProvider(
      {required TransactionHeaderRepository repo, int limit = 0})
      : super(repo, limit, subscriptionType: PsConst.LIST_OBJECT_SUBSCRIPTION) {
    _repo = repo;
  }

  PsResource<List<TransactionHeader>> get transactionHeader => dataList;


  PsResource<TransactionHeader> get transactionSubmitHeader => _transactionSubmit;
  PsResource<TransactionHeader> _transactionSubmit =
      PsResource<TransactionHeader>(PsStatus.NOACTION, '', null);
  late TransactionHeaderRepository _repo;

  Future<PsResource<TransactionHeader>> postRefund(dynamic holder) async {
    return await _repo.postRefund(holder);
  }

  Future<dynamic> postTransactionSubmit(
      User? user,
      List<Basket>? basketList,
      String? clientNonce,
      String? couponDiscount,
      String? taxAmount,
      String? totalDiscount,
      String? subTotalAmount,
      String? shippingAmount,
      String? balanceAmount,
      String? totalItemAmount,
      String? isCod,
      String? isPaypal,
      String? isStripe,
      String? isBank,
      String? isRazor,
      String? isFlutterWave,
      String? isPaystack,
      String? razorId,
      String? flutterWaveId,
      String? isPickUp,
      String? pickAtShop,
      String? deliveryPickupDate,
      String? deliveryPickupTime,
      String? shippingMethodPrice,
      String? shippingMethodName,
      String? memoText,
      PsValueHolder? valueHolder) async {
    final List<String> attributeIdStr = <String>[];
    List<String> attributeNameStr = <String>[];
    final List<String> attributePriceStr = <String>[];
    final List<String> addOnIdStr = <String>[];
    final List<String> addOnNameStr = <String>[];
    final List<String> addOnPriceStr = <String>[];
    double totalItemCount = 0.0;
    for (Basket basket in basketList!) {
      totalItemCount += double.parse(basket.qty!);
    }

    final List<Map<String, dynamic>> detailJson = <Map<String, dynamic>>[];
    for (int i = 0; i < basketList.length; i++) {
      attributeIdStr.clear();
      attributeNameStr.clear();
      attributePriceStr.clear();
      addOnIdStr.clear();
      addOnNameStr.clear();
      addOnPriceStr.clear();
      for (BasketSelectedAttribute basketSelectedAttribute
          in basketList[i].basketSelectedAttributeList!) {
        attributeIdStr.add(basketSelectedAttribute.headerId!);
        attributeNameStr.add(basketSelectedAttribute.name!);
        attributePriceStr.add(basketSelectedAttribute.price!);
      }

      for (BasketSelectedAddOn basketSelectedAddOn
          in basketList[i].basketSelectedAddOnList!) {
        addOnIdStr.add(basketSelectedAddOn.id!);
        addOnNameStr.add(basketSelectedAddOn.name!);
        addOnPriceStr.add(basketSelectedAddOn.price!);
      }

      final DetailMap carJson = DetailMap(
        basketList[i].shopId!,
        basketList[i].productId!,
        basketList[i].product!.title!,
        attributeIdStr.join('#').toString(),
        attributeNameStr.join('#').toString(),
        attributePriceStr.join('#').toString(),
        addOnIdStr.join('#').toString(),
        addOnNameStr.join('#').toString(),
        addOnPriceStr.join('#').toString(),
        basketList[i].selectedColorId ?? '',
        basketList[i].selectedColorValue ?? '',
        'basketList[i].product!.unitPrice!',
        'basketList[i].basketOriginalPrice!',
        'basketList[i].product!.discountValue!',
        'basketList[i].product!.discountAmount!',
        basketList[i].qty!,
        'basketList[i].product!.discountValue!',
        'basketList[i].product!.discountPercent!',
        'basketList[i].product!.currencyShortForm!',
        'basketList[i].product!.currencySymbol!',
        'basketList[i].product!.productUnit!',
        'basketList[i].product!.productMeasurement ?? ',
      );
      attributeNameStr = <String>[];
      detailJson.add(carJson.tojsonData());
    }

    final TransactionSubmitMap newPost = TransactionSubmitMap(
      userId: user!.userId,
      shopId: basketList[0].shopId,
      subTotalAmount: Utils.getPriceTwoDecimal(subTotalAmount!),
      discountAmount: Utils.getPriceTwoDecimal(totalDiscount!),
      couponDiscountAmount: Utils.getPriceTwoDecimal(couponDiscount!),
      taxAmount: Utils.getPriceTwoDecimal(taxAmount!),
      shippingAmount: Utils.getPriceTwoDecimal(shippingAmount!),
      balanceAmount: Utils.getPriceTwoDecimal(balanceAmount!),
      totalItemAmount: Utils.getPriceTwoDecimal(totalItemAmount!),
      contactName: user.name,
      contactPhone: user.userPhone,
      contactEmail: user.userEmail,
      contactAddress: user.userAddress,
      contactAreaId: 'user.area!.id',
      transLat: user.userLat,
      transLng: user.userLng,
      isCod: isCod == PsConst.ONE ? PsConst.ONE : PsConst.ZERO,
      isPickUp: isPickUp == PsConst.ONE ? PsConst.ONE : PsConst.ZERO,
      isPaypal: isPaypal == PsConst.ONE ? PsConst.ONE : PsConst.ZERO,
      isStripe: isStripe == PsConst.ONE ? PsConst.ONE : PsConst.ZERO,
      isBank: isBank == PsConst.ONE ? PsConst.ONE : PsConst.ZERO,
      isRazor: isRazor == PsConst.ONE ? PsConst.ONE : PsConst.ZERO,
      isFlutterWave: isFlutterWave == PsConst.ONE ? PsConst.ONE : PsConst.ZERO,
      isPaystack: isPaystack == PsConst.ONE ? PsConst.ONE : PsConst.ZERO,
      razorId: razorId,
      flutterWaveId: flutterWaveId,
      pickAtShop: pickAtShop,
      deliveryPickupDate: deliveryPickupDate,
      deliveryPickupTime: deliveryPickupTime,
      paymentMethodNonce: clientNonce,
      transStatusId: PsConst.THREE, // 3 = completed
      currencySymbol: basketList[0].product!.itemCurrency!.currencySymbol,
      currencyShortForm: basketList[0].product!.itemCurrency!.currencyShortForm,
      shippingTaxPercent: valueHolder!.shippingTaxLabel,
      taxPercent: valueHolder.overAllTaxLabel,
      memo: memoText ?? '',
      totalItemCount: totalItemCount.toString(),
      details: detailJson,
    );
    isLoading = true;

    isConnectedToInternet = await Utils.checkInternetConnectivity();

    _transactionSubmit = await _repo.postTransactionSubmit(
        newPost.toMap(), isConnectedToInternet, PsStatus.PROGRESS_LOADING);

    return _transactionSubmit;
  }
}

class DetailMap {
  DetailMap(
      this.shopId,
      this.productId,
      this.productName,
      this.productCustomizedId,
      this.productCustomizedName,
      this.productCustomizedPrice,
      this.productAddOnId,
      this.productAddOnName,
      this.productAddOnPrice,
      this.productColorId,
      this.productColorCode,
      this.price,
      this.originalPrice,
      this.discountPrice,
      this.discountAmount,
      this.qty,
      this.discountValue,
      this.discountPercent,
      this.currencyShortForm,
      this.currencySymbol,
      this.productUnit,
      this.productMeasurement);
  String? shopId,
      productId,
      productName,
      productCustomizedId,
      productCustomizedName,
      productCustomizedPrice,
      productAddOnId,
      productAddOnName,
      productAddOnPrice,
      productColorId,
      productColorCode,
      price,
      originalPrice,
      discountPrice,
      discountAmount,
      qty,
      discountValue,
      discountPercent,
      currencyShortForm,
      currencySymbol,
      productUnit,
      productMeasurement;

  Map<String, dynamic> tojsonData() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['shop_id'] = shopId;
    map['product_id'] = productId;
    map['product_name'] = productName;
    map['product_customized_id'] = productCustomizedId;
    map['product_customized_name'] = productCustomizedName;
    map['product_customized_price'] = productCustomizedPrice;
    map['product_addon_id'] = productAddOnId;
    map['product_addon_name'] = productAddOnName;
    map['product_addon_price'] = productAddOnPrice;
    map['product_color_id'] = productColorId;
    map['product_color_code'] = productColorCode;
    map['unit_price'] = price;
    map['original_price'] = originalPrice;
    map['discount_price'] = discountPrice;
    map['discount_amount'] = discountAmount;
    map['qty'] = qty;
    map['discount_value'] = discountValue;
    map['discount_percent'] = discountPercent;
    map['currency_short_form'] = currencyShortForm;
    map['currency_symbol'] = currencySymbol;
    map['product_unit'] = productUnit;
    map['product_unit_value'] = productMeasurement;
    return map;
  }
}

class TransactionSubmitMap {
  TransactionSubmitMap(
      {this.userId,
      this.shopId,
      this.subTotalAmount,
      this.discountAmount,
      this.couponDiscountAmount,
      this.taxAmount,
      this.shippingAmount,
      this.balanceAmount,
      this.totalItemAmount,
      this.contactName,
      this.contactPhone,
      this.contactEmail,
      this.contactAddress,
      this.contactAreaId,
      this.transLat,
      this.transLng,
      this.isCod,
      this.pickAtShop,
      this.deliveryPickupDate,
      this.deliveryPickupTime,
      this.isPaypal,
      this.isStripe,
      this.isBank,
      this.isPickUp,
      this.isRazor,
      this.isFlutterWave,
      this.isPaystack,
      this.razorId,
      this.flutterWaveId,
      this.paymentMethodNonce,
      this.transStatusId,
      this.currencySymbol,
      this.currencyShortForm,
      this.shippingTaxPercent,
      this.taxPercent,
      this.memo,
      this.totalItemCount,
      this.details});

  String? userId;
  String? shopId;
  String? subTotalAmount;
  String? discountAmount;
  String? couponDiscountAmount;
  String? taxAmount;
  String? shippingAmount;
  String? balanceAmount;
  String? totalItemAmount;
  String? contactName;
  String? contactPhone;
  String? contactEmail;
  String? contactAddress;
  String? contactAreaId;
  String? transLat;
  String? transLng;
  String? isPickUp;
  String? isCod;
  String? pickAtShop;
  String? deliveryPickupDate;
  String? deliveryPickupTime;
  String? isPaypal;
  String? isStripe;
  String? isBank;
  String? isRazor;
  String? isFlutterWave;
  String? isPaystack;
  String? razorId;
  String? flutterWaveId;
  String? paymentMethodNonce;
  String? transStatusId;
  String? currencySymbol;
  String? currencyShortForm;
  String? shippingTaxPercent;
  String? taxPercent;
  String? memo;
  String? totalItemCount;
  List<Map<String, dynamic>>? details;

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['user_id'] = userId;
    map['shop_id'] = shopId;
    map['sub_total_amount'] = subTotalAmount;
    map['discount_amount'] = discountAmount;
    map['coupon_discount_amount'] = couponDiscountAmount;
    map['tax_amount'] = taxAmount;
    map['shipping_amount'] = shippingAmount;
    map['balance_amount'] = balanceAmount;
    map['total_item_amount'] = totalItemAmount;
    map['contact_name'] = contactName;
    map['contact_phone'] = contactPhone;
    map['contact_email'] = contactEmail;
    map['contact_address'] = contactAddress;
    map['contact_area_id'] = contactAreaId;
    map['trans_lat'] = transLat;
    map['trans_lng'] = transLng;
    map['is_cod'] = isCod;
    map['pick_at_shop'] = pickAtShop;
    map['delivery_pickup_date'] = deliveryPickupDate;
    map['delivery_pickup_time'] = deliveryPickupTime;
    map['is_paypal'] = isPaypal;
    map['is_stripe'] = isStripe;
    map['is_bank'] = isBank;
    map['is_pickup'] = isPickUp;
    map['is_razor'] = isRazor;
    map['is_flutter_wave'] = isFlutterWave;
    map['is_paystack'] = isPaystack;
    map['razor_id'] = razorId;
    map['flutter_wave_id'] = flutterWaveId;
    map['payment_method_nonce'] = paymentMethodNonce;
    map['trans_status_id'] = transStatusId;
    map['currency_symbol'] = currencySymbol;
    map['currency_short_form'] = currencyShortForm;
    map['shipping_tax_percent'] = shippingTaxPercent;
    map['tax_percent'] = taxPercent;
    map['memo'] = memo;
    map['total_item_count'] = totalItemCount;
    map['details'] = details;

    return map;
  }
}
