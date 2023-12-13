import '../../api/common/ps_resource.dart';
import '../../constant/ps_constants.dart';
import '../../repository/tansaction_detail_repository.dart';
import '../../viewobject/transaction_detail.dart';
import '../common/ps_provider.dart';

class TransactionDetailProvider extends PsProvider<TransactionDetail> {
  TransactionDetailProvider(
      {required TransactionDetailRepository repo, int limit = 0})
      : super(repo, limit, subscriptionType: PsConst.LIST_OBJECT_SUBSCRIPTION);

  PsResource<List<TransactionDetail>> get transactionDetail => dataList;
}
