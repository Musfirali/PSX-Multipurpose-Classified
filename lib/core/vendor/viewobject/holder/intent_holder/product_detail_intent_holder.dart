import '../../basket_selected_add_on.dart';
import '../../basket_selected_attribute.dart';

class ProductDetailIntentHolder {
  const ProductDetailIntentHolder(
      {this.id,
      required this.productId,
      this.heroTagImage,
      this.heroTagTitle,
      this.intentBasketSelectedAddOnList,
      this.intentBasketSelectedAttributeList,
      this.intentQty});

  final String? id;
  final String? productId;
  final String? heroTagImage;
  final String? heroTagTitle;
  final List<BasketSelectedAttribute>? intentBasketSelectedAttributeList;
  final List<BasketSelectedAddOn>? intentBasketSelectedAddOnList;
  final String? intentQty;
}
