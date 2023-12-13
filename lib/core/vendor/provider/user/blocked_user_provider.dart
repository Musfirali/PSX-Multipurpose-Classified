import 'dart:async';

import '../../api/common/ps_resource.dart';
import '../../api/common/ps_status.dart';
import '../../constant/ps_constants.dart';
import '../../repository/blocked_user_repository.dart';
import '../../viewobject/blocked_user.dart';
import '../../viewobject/common/ps_value_holder.dart';
import '../common/ps_provider.dart';

class BlockedUserProvider extends PsProvider<BlockedUser> {
  BlockedUserProvider({
    required BlockedUserRepository repo,
    this.valueHolder,
    int limit = 0,
  }) : super(repo, limit, subscriptionType: PsConst.LIST_OBJECT_SUBSCRIPTION) {
    _repo = repo;
  }
  BlockedUserRepository? _repo;
  PsValueHolder? valueHolder;

  PsResource<List<BlockedUser>> get blockedUserList => super.dataList;

  Future<dynamic> deleteUserFromDB(String? loginUserId) async {
    await _repo!.postDeleteUserFromDB(super.dataListStreamController!,
        loginUserId, PsStatus.PROGRESS_LOADING);
  }
}
