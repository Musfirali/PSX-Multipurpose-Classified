class RequestPathHolder {
  RequestPathHolder({
    this.loginUserId,
    this.parentImgId,
    this.imageType,
    this.itemId,
    this.cityId,
    this.coreKeyId,
    this.shopId,
    this.categoryId,
    this.transactionHeaderId,
    this.productId,
    this.commentHeaderId,
    this.shippingId,
    this.scheduleHeaderId,
    this.collectionId,
    this.languageCode,

    this.headerToken
  });

  final String? loginUserId;
  final String? itemId;
  final String? parentImgId;
  final String? imageType;
  final String? cityId;
  final String? coreKeyId;
  final String? shopId;
  final String? categoryId;
  final String? transactionHeaderId;
  final String? productId;
  final String? commentHeaderId;
  final String? shippingId;
  final String? scheduleHeaderId;
  final String? collectionId;
  final String? languageCode;
  //Header Token
  final String? headerToken;
}
