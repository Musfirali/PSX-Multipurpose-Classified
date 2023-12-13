import 'buyadpost_transaction.dart';
import 'product.dart';
import 'promotion_transaction.dart';
import 'search_history.dart';

class Selection {
  Selection(
      {this.isSelected = false,
      this.product,
      this.history,
      this.promotionTransaction,
      this.packageTransaction});
  bool isSelected;
  Product? product;
  SearchHistory? history;
  PromotionTransaction? promotionTransaction;
  PackageTransaction? packageTransaction;
}
