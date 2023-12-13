import '../../api/common/ps_resource.dart';
import '../../constant/ps_constants.dart';
import '../../repository/offline_payment_method_repository.dart';
import '../../viewobject/offline_payment.dart';
import '../common/ps_provider.dart';

class OfflinePaymentProvider extends PsProvider<OfflinePayment> {
  OfflinePaymentProvider({
    required OfflinePaymentMethodRepository repo,
    int limit = 0,
  }) : super(repo, limit, subscriptionType: PsConst.LIST_OBJECT_SUBSCRIPTION);

  PsResource<List<OfflinePayment>> get agentList => super.dataList;
}
  // Future<dynamic> getOfflinePaymentList() async {
  //   isConnectedToInternet = await Utils.checkInternetConnectivity();
  //   isLoading = true;

  //   await _repo!.getOfflinePaymentList(
  //     dataStreamController!,
  //     isConnectedToInternet,
  //     limit,
  //     offset,
  //     PsStatus.BLOCK_LOADING,
  //   );
  // }

  // Future<dynamic> nextOfflinePaymentList() async {
  //   isConnectedToInternet = await Utils.checkInternetConnectivity();
  //   if (!isLoading && !isReachMaxData) {
  //     super.isLoading = true;

  //     await _repo!.getNextPageOfflinePaymentList(
  //       dataStreamController!,
  //       isConnectedToInternet,
  //       limit,
  //       offset,
  //       PsStatus.PROGRESS_LOADING,
  //     );
  //   }
  // }

  // Future<void> resetOfflinePaymentList() async {
  //   isConnectedToInternet = await Utils.checkInternetConnectivity();
  //   isLoading = true;

  //   updateOffset(0);

  //   await _repo!.getOfflinePaymentList(
  //     dataStreamController!,
  //     isConnectedToInternet,
  //     limit,
  //     offset,
  //     PsStatus.BLOCK_LOADING,
  //   );

  //   isLoading = false;
  // }
