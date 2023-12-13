import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import '../api/custom_ps_api_service.dart';
import '../db/c_user_dao.dart';
import '../repository/search_user_repository.dart';

List<SingleChildWidget> customIndependentProviders = <SingleChildWidget>[
  Provider<CustomPsApiService>.value(value: CustomPsApiService()),
  Provider<CUserDao>.value(value: CUserDao()),
];

List<SingleChildWidget> customDependentProviders = <SingleChildWidget>[
  ProxyProvider2<CustomPsApiService, CUserDao, SearchUserRepository>(
    update: (_, CustomPsApiService psApiService, CUserDao userDao,
            SearchUserRepository? itemTypeRepository) =>
        SearchUserRepository(psApiService: psApiService, userDao: userDao),
  ),
];
