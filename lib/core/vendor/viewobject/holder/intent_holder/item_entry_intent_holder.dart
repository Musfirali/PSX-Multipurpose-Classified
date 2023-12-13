import '../../product.dart';

class ItemEntryIntentHolder {
  const ItemEntryIntentHolder({
    required this.flag,
    required this.item,
    this.categoryId,
    this.categoryName,
    this.isFromChat
  });
  
  final String flag;
  final Product? item;
  final String? categoryId;
  final String? categoryName;
  final bool? isFromChat;
}
