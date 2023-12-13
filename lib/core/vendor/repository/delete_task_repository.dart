import 'dart:async';

import '../db/chat_history_dao.dart';
import '../db/chat_history_map_dao.dart';
import '../db/favourite_product_dao.dart';
import '../db/history_dao.dart';
import '../db/package_bought_transaction_dao.dart';
import '../db/paid_ad_item_dao.dart';
import '../db/search_history_dao.dart';
import '../db/sub_category_dao.dart';
import '../db/user_login_dao.dart';
import '../db/user_unread_message_dao.dart';
import 'Common/ps_repository.dart';

class DeleteTaskRepository extends PsRepository {
  Future<dynamic> deleteTask() async {
    final FavouriteProductDao _favProductDao = FavouriteProductDao.instance;
    final UserLoginDao _userLoginDao = UserLoginDao.instance;
    final HistoryDao _historyDao = HistoryDao.instance;
    final PaidAdItemDao _paidAdItemDao = PaidAdItemDao.instance;
    final PackageTransactionDao _packageDao = PackageTransactionDao.instance;
    final UserUnreadMessageDao _userUnreadMessageDao =
        UserUnreadMessageDao.instance;
    final ChatHistoryDao _chatHistoryDao = ChatHistoryDao.instance;    
    final ChatHistoryMapDao _chatHistoryMapDao = ChatHistoryMapDao.instance;
    final SubCategoryDao _subCategoryDao = SubCategoryDao();
    final SearchHistoryDao _searchHistoryDao = SearchHistoryDao.instance;
  
    await _favProductDao.deleteAll();
    await _userUnreadMessageDao.deleteAll();
    await _paidAdItemDao.deleteAll();
    await _packageDao.deleteAll();
    await _userLoginDao.deleteAll();
    await _historyDao.deleteAll();
    await _chatHistoryDao.deleteAll();
    await _chatHistoryMapDao.deleteAll();
    await _subCategoryDao.deleteAll();
    await _searchHistoryDao.deleteAll();
  }
}
