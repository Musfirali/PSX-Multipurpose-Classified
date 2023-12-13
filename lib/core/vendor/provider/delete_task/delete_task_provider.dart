import 'dart:async';
import '../../constant/ps_constants.dart';
import '../../repository/delete_task_repository.dart';
import '../../viewobject/common/ps_value_holder.dart';
import '../../viewobject/user_login.dart';
import '../common/ps_provider.dart';

class DeleteTaskProvider extends PsProvider<UserLogin> {
  DeleteTaskProvider(
      {required DeleteTaskRepository? repo, this.psValueHolder, int limit = 0})
      : super(repo, limit, subscriptionType: PsConst.NO_SUBSCRIPTION) {
    _repo = repo;
  }

  DeleteTaskRepository? _repo;
  PsValueHolder? psValueHolder;

  Future<dynamic> deleteTask() async {
    isLoading = true;
    await _repo!.deleteTask();
  }
}
