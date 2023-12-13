class ItemListIntentHolder {
  const ItemListIntentHolder({
    required this.userId,
    required this.status,
    required this.title,
    this.isSoldOutList = false
  });
  final String? userId;
  final String status;
  final String title;
  final bool isSoldOutList;
}
