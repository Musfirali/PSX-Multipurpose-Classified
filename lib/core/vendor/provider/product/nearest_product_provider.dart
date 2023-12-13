import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:psxmpc/core/vendor/provider/common/ps_init_provider.dart';
import 'package:psxmpc/core/vendor/utils/utils.dart';
import 'package:psxmpc/core/vendor/viewobject/common/ps_value_holder.dart';
import 'package:psxmpc/core/vendor/viewobject/holder/request_path_holder.dart';

import '../../api/common/ps_resource.dart';
import '../../constant/ps_constants.dart';
import '../../repository/product_repository.dart';
import '../../viewobject/holder/product_parameter_holder.dart';
import '../../viewobject/product.dart';
import '../common/ps_provider.dart';

class NearestProductProvider extends PsProvider<Product> {
  NearestProductProvider({
    required ProductRepository repo,
    int limit = 0,
  }) : super(repo, limit, subscriptionType: PsConst.LIST_OBJECT_SUBSCRIPTION);

  final ProductParameterHolder productNearestParameterHolder =
      ProductParameterHolder().getNearestParameterHolder();
  PsResource<List<Product>> get productList => super.dataList;

  // Future<void> initSubscription() async {
  //   if (productListStream != null) {
  //     await productListStream?.close();
  //   }
  //   if (subscription != null) {
  //     await subscription?.cancel();
  //   }

  //   productListStream = StreamController<PsResource<List<Product>>>.broadcast();
  //   subscription =
  //       productListStream!.stream.listen((PsResource<List<Product>> resource) {
  //     updateOffset(resource.data!.length);

  //     _productList = resource;
  //     _productList.data = Product().checkDuplicate(resource.data!);

  //     if (resource.status != PsStatus.BLOCK_LOADING &&
  //         resource.status != PsStatus.PROGRESS_LOADING) {
  //       isLoading = false;
  //     }

  //     if (!isDispose) {
  //       notifyListeners();
  //     }
  //   });
  // }

  // Future<dynamic> loadProductList(
  //     String loginUserId, ProductParameterHolder productParameterHolder) async {
  //   isLoading = true;

  //   isConnectedToInternet = await Utils.checkInternetConnectivity();

  //   await _repo.getProductList(
  //       productListStream,
  //       isConnectedToInternet,
  //       loginUserId,
  //       limit,
  //       offset,
  //       PsStatus.PROGRESS_LOADING,
  //       productParameterHolder);

  //   if (daoSubscription != null) {
  //     await daoSubscription.cancel();
  //   }
  //   await initSubscription();
  //   daoSubscription = await _repo.subscribeProductList(
  //       productListStream, PsStatus.PROGRESS_LOADING, productParameterHolder);
  // }

  // Future<dynamic> resetProductList(
  //     String loginUserId, ProductParameterHolder productParameterHolder) async {
  //   isLoading = true;

  //   updateOffset(0);

  //   isConnectedToInternet = await Utils.checkInternetConnectivity();

  //   // daoSubscription = await _repo.getProductList(
  //   //     productListStream,
  //   //     isConnectedToInternet,
  //   //     loginUserId,
  //   //     limit,
  //   //     offset,
  //   //     PsStatus.PROGRESS_LOADING,
  //   //     productParameterHolder);

  //   await _repo.getProductList(
  //       productListStream,
  //       isConnectedToInternet,
  //       loginUserId,
  //       limit,
  //       offset,
  //       PsStatus.PROGRESS_LOADING,
  //       productParameterHolder);

  //   if (daoSubscription != null) {
  //     await daoSubscription.cancel();
  //   }
  //   await initSubscription();
  //   daoSubscription = await _repo.subscribeProductList(
  //       productListStream, PsStatus.PROGRESS_LOADING, productParameterHolder);

  //   isLoading = false;
  // }

  // Future<dynamic> nextProductList(
  //     String loginUserId, ProductParameterHolder productParameterHolder) async {
  //   isConnectedToInternet = await Utils.checkInternetConnectivity();

  //   if (!isLoading && !isReachMaxData) {
  //     super.isLoading = true;

  //     // daoSubscription = await _repo.getProductList(
  //     //     productListStream,
  //     //     isConnectedToInternet,
  //     //     loginUserId,
  //     //     limit,
  //     //     offset,
  //     //     PsStatus.PROGRESS_LOADING,
  //     //     productParameterHolder);
  //     await _repo.getProductList(
  //         productListStream,
  //         isConnectedToInternet,
  //         loginUserId,
  //         limit,
  //         offset,
  //         PsStatus.PROGRESS_LOADING,
  //         productParameterHolder);
  //   }
  // }
}

SingleChildWidget initNearestProductProvider(
    BuildContext context, bool mounted, Function function,
    {Widget? widget}) {
  final PsValueHolder valueHolder = Provider.of<PsValueHolder>(context);
  final ProductRepository repo = Provider.of<ProductRepository>(context);
  // final AppLocalization langProvider = Provider.of<AppLocalization>(context);
  return psInitProvider<NearestProductProvider>(
      widget: widget,
      initProvider: () {
        return NearestProductProvider(
            repo: repo, limit: valueHolder.recentItemLoadingLimit!);
      },
      onProviderReady: (NearestProductProvider _nearestProductProvider) {
        Position? _currentPosition;

        final String? loginUserId = Utils.checkUserLoginId(valueHolder);
        Geolocator.checkPermission().then((LocationPermission permission) {
          if (permission == LocationPermission.denied) {
            Geolocator.requestPermission()
                .then((LocationPermission permission) {
              if (permission == LocationPermission.denied) {
                //permission denied, do nothing
              } else {
                Geolocator.getCurrentPosition(
                        desiredAccuracy: LocationAccuracy.medium,
                        forceAndroidLocationManager: false)
                    .then((Position position) {
                  if (mounted) {
                    // setState(() {
                    _currentPosition = position;
                    // });
                    _nearestProductProvider.productNearestParameterHolder.lat =
                        _currentPosition?.latitude.toString();
                    _nearestProductProvider.productNearestParameterHolder.lng =
                        _currentPosition?.longitude.toString();
                    _nearestProductProvider.productNearestParameterHolder.mile =
                        valueHolder.mile;
                    _nearestProductProvider.loadDataList(
                      requestPathHolder: RequestPathHolder(
                          loginUserId: loginUserId,
                          languageCode: valueHolder.languageCode),
                      requestBodyHolder:
                          _nearestProductProvider.productNearestParameterHolder,
                    );
                  }
                }).catchError((Object e) {
                  //
                });
              }
            });
          } else {
            Geolocator.getCurrentPosition(
                    desiredAccuracy: LocationAccuracy.medium,
                    forceAndroidLocationManager: false)
                .then((Position position) {
              if (mounted) {
                // setState(() {
                _currentPosition = position;
                // });
                _nearestProductProvider.productNearestParameterHolder.lat =
                    _currentPosition?.latitude.toString();
                _nearestProductProvider.productNearestParameterHolder.lng =
                    _currentPosition?.longitude.toString();
                _nearestProductProvider.productNearestParameterHolder.mile =
                    valueHolder.mile;
                _nearestProductProvider.loadDataList(
                  requestPathHolder: RequestPathHolder(
                      loginUserId: loginUserId,
                      languageCode: valueHolder.languageCode),
                  requestBodyHolder:
                      _nearestProductProvider.productNearestParameterHolder,
                );
              }
            }).catchError((Object e) {
              //
            });
          }
        });
        function(_nearestProductProvider);
      });
}
