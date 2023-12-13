import 'dart:async';
import '../../constant/ps_constants.dart';
import '../../repository/clear_all_data_repository.dart';
import '../../viewobject/common/ps_value_holder.dart';
import '../../viewobject/product.dart';
import '../common/ps_provider.dart';

class ClearAllDataProvider extends PsProvider<Product> {
  ClearAllDataProvider(
      {required ClearAllDataRepository repo, this.psValueHolder, int limit = 0})
      : super(repo, limit, subscriptionType: PsConst.NO_SUBSCRIPTION) {
    _repo = repo;
  }

  late ClearAllDataRepository _repo;
  PsValueHolder? psValueHolder;

  Future<dynamic> clearAllData() async {
    isLoading = true;
    _repo.clearAllData();
  }
}
