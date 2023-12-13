import '../../api/common/ps_resource.dart';
import '../../constant/ps_constants.dart';
import '../../repository/transaction_status_repository.dart';
import '../../viewobject/transaction_status.dart';
import '../common/ps_provider.dart';

class TransactionStatusProvider extends PsProvider<TransactionStatus> {
  TransactionStatusProvider(
      {required TransactionStatusRepository repo, int limit = 0})
      : super(repo, limit, subscriptionType: PsConst.LIST_OBJECT_SUBSCRIPTION);

  PsResource<List<TransactionStatus>> get transactionStatus => dataList;
}
