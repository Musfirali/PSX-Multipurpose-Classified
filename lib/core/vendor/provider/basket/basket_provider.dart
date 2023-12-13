import '../../api/common/ps_resource.dart';
import '../../api/common/ps_status.dart';
import '../../constant/ps_constants.dart';
import '../../repository/basket_repository.dart';
import '../../viewobject/basket.dart';
import '../common/ps_provider.dart';
import 'helper/checkout_calculation_helper.dart';

class BasketProvider extends PsProvider<Basket> {
  BasketProvider({required BasketRepository repo, int limit = 0})
      : super(repo, limit, subscriptionType: PsConst.LIST_OBJECT_SUBSCRIPTION) {
    _repo = repo;
  }

  PsResource<List<Basket>> get basketList => dataList;
  final CheckoutCalculationHelper checkoutCalculationHelper =
      CheckoutCalculationHelper();
  late BasketRepository _repo;

  Future<dynamic> addBasket(Basket basket) async {
    await _repo.addBasket(
      dataListStreamController!,
      PsStatus.PROGRESS_LOADING,
      basket,
    );
  }

  Future<dynamic> updateBasket(Basket product) async {
    await _repo.updateBasket(
      dataListStreamController!,
      product,
    );
  }

  Future<dynamic> deleteBasketByProduct(Basket product) async {
    await _repo.deleteBasketByProduct(dataListStreamController!, product);
  }

  Future<dynamic> deleteWholeBasketList() async {
    await _repo.deleteWholeBasketList(dataListStreamController!);
  }
}
