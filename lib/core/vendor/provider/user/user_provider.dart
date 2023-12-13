import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:psxmpc/core/vendor/provider/common/ps_init_provider.dart';
import 'package:psxmpc/core/vendor/viewobject/edit_profile_user_relation.dart';
import 'package:the_apple_sign_in/the_apple_sign_in.dart';

import '../../../../config/route/route_paths.dart';
import '../../../../ui/vendor_ui/common/dialog/email_sent_warning_dialog.dart';
import '../../../../ui/vendor_ui/common/dialog/error_dialog.dart';
import '../../../../ui/vendor_ui/common/dialog/warning_dialog_view.dart';
import '../../../vendor/provider/language/app_localization_provider.dart';
import '../../api/common/ps_resource.dart';
import '../../api/common/ps_status.dart';
import '../../constant/ps_constants.dart';
import '../../repository/user_repository.dart';
import '../../utils/ps_progress_dialog.dart';
import '../../utils/utils.dart';
import '../../viewobject/api_status.dart';
import '../../viewobject/common/ps_value_holder.dart';
import '../../viewobject/holder/apple_login_parameter_holder.dart';
import '../../viewobject/holder/facebook_login_user_holder.dart';
import '../../viewobject/holder/fb_login_parameter_holder.dart';
import '../../viewobject/holder/google_login_parameter_holder.dart';
import '../../viewobject/holder/user_login_parameter_holder.dart';
import '../../viewobject/holder/user_name_status_parameter_holder.dart';
import '../../viewobject/holder/user_parameter_holder.dart';
import '../../viewobject/holder/user_register_parameter_holder.dart';
import '../../viewobject/shipping_city.dart';
import '../../viewobject/shipping_country.dart';
import '../../viewobject/user.dart';
import '../../viewobject/user_name_status.dart';
import '../common/ps_provider.dart';

class UserProvider extends PsProvider<User> {
  UserProvider({
    required UserRepository? repo,
    required this.psValueHolder,
    int limit = 0,
  }) : super(repo, limit,
            subscriptionType: PsConst.SINGLE_OBJECT_SUBSCRIPTION) {
    _repo = repo;
  }

  UserRepository? _repo;
  PsValueHolder? psValueHolder;
  User? holderUser;
  ShippingCountry? selectedCountry;
  ShippingCity? selectedCity;
  bool isCheckBoxSelect = true;
  bool isRememberMeChecked = false;
  String selectedCountryCode = '';
  String selectedCountryName = '';
  UserParameterHolder userParameterHolder =
      UserParameterHolder().getOtherUserData();

  PsResource<User> get user => super.data;

  PsResource<ApiStatus> _apiStatus =
      PsResource<ApiStatus>(PsStatus.NOACTION, '', null);
  PsResource<ApiStatus> get apiStatus => _apiStatus;
  List<EditProfileUserRelation> userRelationList = <EditProfileUserRelation>[];
  StreamController<PsResource<User>>? userListStream;
  final fb_auth.FirebaseAuth _firebaseAuth = fb_auth.FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();


  // Register
  Future<dynamic> postUserRegister(
      Map<dynamic, dynamic> jsonMap, String languageCode) async {
    isLoading = true;

    isConnectedToInternet = await Utils.checkInternetConnectivity();

    return await _repo!.postUserRegister(jsonMap, isConnectedToInternet,
        PsStatus.PROGRESS_LOADING, psValueHolder!.headerToken!, languageCode);
  }

  // Login
  Future<dynamic> postUserLogin(
      Map<dynamic, dynamic> jsonMap, String languageCode) async {
    isLoading = true;

    isConnectedToInternet = await Utils.checkInternetConnectivity();

    return await _repo!.postUserLogin(jsonMap, isConnectedToInternet,
        PsStatus.PROGRESS_LOADING, psValueHolder!.headerToken!, languageCode);
  }

  // Check User Name Exists
  Future<dynamic> checkUserNameExists(Map<dynamic, dynamic> jsonMap) async {
    isLoading = true;

    isConnectedToInternet = await Utils.checkInternetConnectivity();

    return await _repo!.checkUserNameExists(jsonMap, psValueHolder!.headerToken!);
  }

  // Set UserName and Password
  Future<dynamic> setUserNameAndPassword(
      Map<dynamic, dynamic> jsonMap, String languageCode) async {
    isLoading = true;

    isConnectedToInternet = await Utils.checkInternetConnectivity();

    return await _repo!.setUserNameAndPassword(jsonMap, languageCode);
  }

  // Facebook Login
  Future<dynamic> postFBLogin(
      Map<dynamic, dynamic> jsonMap, String languageCode) async {
    isLoading = true;

    isConnectedToInternet = await Utils.checkInternetConnectivity();

    return await _repo!.postFBLogin(jsonMap, isConnectedToInternet,
        PsStatus.PROGRESS_LOADING, psValueHolder!.headerToken!, languageCode);
  }

  // Apple Login
  Future<dynamic> postAppleLogin(
      Map<dynamic, dynamic> jsonMap, String languageCode) async {
    isLoading = true;

    isConnectedToInternet = await Utils.checkInternetConnectivity();

    return await _repo!.postAppleLogin(jsonMap, isConnectedToInternet,
        PsStatus.PROGRESS_LOADING, psValueHolder!.headerToken!, languageCode);
  }

  // Google Login
  Future<dynamic> postGoogleLogin(
      Map<dynamic, dynamic> jsonMap, String languageCode) async {
    isLoading = true;

    isConnectedToInternet = await Utils.checkInternetConnectivity();

    return await _repo!.postGoogleLogin(jsonMap, isConnectedToInternet,
        PsStatus.PROGRESS_LOADING, psValueHolder!.headerToken!, languageCode);
  }

  // Phone Login
  Future<dynamic> postPhoneLogin(
    Map<dynamic, dynamic> jsonMap,
    String languageCode,
  ) async {
    isLoading = true;

    isConnectedToInternet = await Utils.checkInternetConnectivity();

    return await _repo!.postPhoneLogin(jsonMap, isConnectedToInternet,
        PsStatus.PROGRESS_LOADING, psValueHolder!.headerToken!, languageCode);
  }

  // Log Out
  Future<dynamic> userLogout(
      Map<dynamic, dynamic> jsonMap, String languageCode) async {
    isLoading = true;

    isConnectedToInternet = await Utils.checkInternetConnectivity();

    _apiStatus = await _repo!.userLogout(jsonMap, isConnectedToInternet,
        PsStatus.PROGRESS_LOADING, psValueHolder!.headerToken!, languageCode);

    return _apiStatus;
  }

  Future<dynamic> postUserEmailVerify(
      Map<dynamic, dynamic> jsonMap, String languageCode) async {
    isLoading = true;

    isConnectedToInternet = await Utils.checkInternetConnectivity();

    return await _repo!.postUserEmailVerify(jsonMap, isConnectedToInternet,
        PsStatus.PROGRESS_LOADING, languageCode);
  }

  Future<dynamic> postForgotPasswordVerify(
      Map<dynamic, dynamic> jsonMap, String languageCode) async {
    isLoading = true;

    isConnectedToInternet = await Utils.checkInternetConnectivity();

    return await _repo!.postForgotPasswordVerify(jsonMap, isConnectedToInternet,
        PsStatus.PROGRESS_LOADING, languageCode);
  }

  Future<dynamic> postImageUpload(String userId, String platformName,
      File? imageFile, String languageCode) async {
    isLoading = true;

    isConnectedToInternet = await Utils.checkInternetConnectivity();

    return await _repo!.postUserImageUpload(
        userId,
        psValueHolder!.headerToken!,
        platformName,
        imageFile!,
        isConnectedToInternet,
        PsStatus.PROGRESS_LOADING,
        languageCode);
  }

  Future<dynamic> postForgotPassword(
      Map<dynamic, dynamic> jsonMap, String languageCode) async {
    isLoading = true;

    isConnectedToInternet = await Utils.checkInternetConnectivity();

    _apiStatus = await _repo!.postForgotPassword(jsonMap, isConnectedToInternet,
        PsStatus.PROGRESS_LOADING, languageCode);

    return _apiStatus;
  }

  Future<dynamic> postChangePassword(Map<dynamic, dynamic> jsonMap,
      String loginUserId, String languageCode) async {
    isLoading = true;

    isConnectedToInternet = await Utils.checkInternetConnectivity();

    _apiStatus = await _repo!.postChangePassword(jsonMap, isConnectedToInternet,
        PsStatus.PROGRESS_LOADING, loginUserId, languageCode);

    return _apiStatus;
  }

  Future<dynamic> postUpdateForgotPassword(Map<dynamic, dynamic> jsonMap,
      String loginUserId, String languageCode) async {
    isLoading = true;

    isConnectedToInternet = await Utils.checkInternetConnectivity();

    _apiStatus = await _repo!.postUpdateForgotPassword(
        jsonMap,
        isConnectedToInternet,
        PsStatus.PROGRESS_LOADING,
        loginUserId,
        languageCode);

    return _apiStatus;
  }

  Future<dynamic> postProfileUpdate(Map<dynamic, dynamic> jsonMap,
      String loginUserId, String languageCode) async {
    isLoading = true;

    isConnectedToInternet = await Utils.checkInternetConnectivity();

    final PsResource<User> resource = await _repo!.postProfileUpdate(
        jsonMap,
        loginUserId,
        psValueHolder!.headerToken!,
        isConnectedToInternet,
        PsStatus.SUCCESS,
        languageCode);
    return resource;
  }

  Future<dynamic> postUserFollow(
    Map<dynamic, dynamic> jsonMap,
    String loginUserId,
    String languageCode,
  ) async {
    isLoading = true;

    isConnectedToInternet = await Utils.checkInternetConnectivity();

    return await _repo!.postUserFollow(
        jsonMap,
        isConnectedToInternet,
        PsStatus.PROGRESS_LOADING,
        loginUserId,
        psValueHolder!.headerToken!,
        languageCode);
  }

  Future<dynamic> postResendCode(
      Map<dynamic, dynamic> jsonMap, String languageCode) async {
    isLoading = true;

    isConnectedToInternet = await Utils.checkInternetConnectivity();

    _apiStatus = await _repo!.postResendCode(jsonMap, isConnectedToInternet,
        PsStatus.PROGRESS_LOADING, languageCode);

    return _apiStatus;
  }

  Future<dynamic> getUser(String? loginUserId, String languageCode) async {
    isLoading = true;
    isConnectedToInternet = await Utils.checkInternetConnectivity();

    await _repo!.getUser(super.dataStreamController, loginUserId,
        isConnectedToInternet, PsStatus.PROGRESS_LOADING, languageCode);
  }

  Future<dynamic> getUserFromDB(String loginUserId) async {
    isLoading = true;

    await _repo!.getUserFromDB(
        loginUserId, super.dataStreamController!, PsStatus.PROGRESS_LOADING);
  }

  Future<dynamic> getOtherUserData(Map<dynamic, dynamic> jsonMap,
      String? otherUserId, String languageCode) async {
    isLoading = true;

    isConnectedToInternet = await Utils.checkInternetConnectivity();

    await _repo!.getOtherUserData(
        super.dataStreamController,
        jsonMap,
        otherUserId,
        psValueHolder!.headerToken!,
        limit,
        offset!,
        isConnectedToInternet,
        PsStatus.PROGRESS_LOADING,
        languageCode);
  }

  Future<dynamic> userReportItem(
      Map<dynamic, dynamic> jsonMap, String loginUserId) async {
    isLoading = true;

    isConnectedToInternet = await Utils.checkInternetConnectivity();

    _apiStatus = await _repo!.userReportItem(jsonMap, isConnectedToInternet,
        PsStatus.PROGRESS_LOADING, loginUserId, psValueHolder!.headerToken!);

    return _apiStatus;
  }

  Future<dynamic> blockUser(Map<dynamic, dynamic> jsonMap, String loginUserId,
      String languageCode) async {
    isLoading = true;

    isConnectedToInternet = await Utils.checkInternetConnectivity();

    _apiStatus = await _repo!.blockUser(
        jsonMap,
        isConnectedToInternet,
        PsStatus.PROGRESS_LOADING,
        loginUserId,
        psValueHolder!.headerToken!,
        languageCode);

    return _apiStatus;
  }

  Future<dynamic> postUnBlockUser(Map<dynamic, dynamic> jsonMap,
      String loginUserId, String languageCode) async {
    isLoading = true;

    isConnectedToInternet = await Utils.checkInternetConnectivity();

    _apiStatus = await _repo!.postUnBlockUser(
        jsonMap,
        isConnectedToInternet,
        PsStatus.PROGRESS_LOADING,
        loginUserId,
        psValueHolder!.headerToken!,
        languageCode);

    return _apiStatus;
  }

  // Delete User
  Future<dynamic> postDeleteUser(
      Map<dynamic, dynamic> jsonMap, String languageCode) async {
    isLoading = true;

    isConnectedToInternet = await Utils.checkInternetConnectivity();

    _apiStatus = await _repo!.postDeleteUser(
        jsonMap,
        psValueHolder!.loginUserId!,
        isConnectedToInternet,
        PsStatus.PROGRESS_LOADING,
        psValueHolder!.headerToken!,
        languageCode);

    return _apiStatus;
  }

  ///
  /// Firebase Auth
  ///
  Future<fb_auth.User?> getCurrentFirebaseUser() async {
    final fb_auth.FirebaseAuth auth = fb_auth.FirebaseAuth.instance;
    final fb_auth.User? currentUser = auth.currentUser;
    return currentUser;
  }

  Future<void> handleFirebaseAuthError(BuildContext context, String email,
      {bool ignoreEmail = false}) async {
    if (email.isEmpty) {
      return;
    }

    final List<String> providers =
        await _firebaseAuth.fetchSignInMethodsForEmail(email);

    final String provider = providers.single;
    print('provider : $provider');
    // Registered With Email
    if (provider.contains(PsConst.emailAuthProvider) && !ignoreEmail) {
      showDialog<dynamic>(
          context: context,
          builder: (BuildContext context) {
            return WarningDialog(
              message: '[ $email ]\n' + 'auth__email_provider'.tr,
              onPressed: () {},
            );
          });
    }
    // Registered With Google
    else if (provider.contains(PsConst.googleAuthProvider)) {
      showDialog<dynamic>(
          context: context,
          builder: (BuildContext context) {
            return WarningDialog(
              message: '[ $email ]\n' + 'auth__google_provider'.tr,
              onPressed: () {},
            );
          });
    }
    // Registered With Facebook
    else if (provider.contains(PsConst.facebookAuthProvider)) {
      showDialog<dynamic>(
          context: context,
          builder: (BuildContext context) {
            return WarningDialog(
              message: '[ $email ]\n' + 'auth__facebook_provider'.tr,
              onPressed: () {},
            );
          });
    }
    // Registered With Apple
    else if (provider.contains(PsConst.appleAuthProvider)) {
      showDialog<dynamic>(
          context: context,
          builder: (BuildContext context) {
            return WarningDialog(
              message: '[ $email ]\n' + 'auth__apple_provider'.tr,
              onPressed: () {},
            );
          });
    }
  }

  ///
  /// Apple Login Related
  ///
  Future<void> loginWithAppleId(
      BuildContext context,
      Function? onAppleIdSignInSelected,
      Function? callBackAfterLoginSuccess,
      String languageCode) async {
    ///
    /// Check User is Accept Terms and Conditions
    ///
    if (isCheckBoxSelect) {
      ///
      /// Check Connection
      ///
      if (await Utils.checkInternetConnectivity()) {
        ///
        /// Get Firebase User with Apple Id Login
        ///
        final fb_auth.User? firebaseUser =
            await _getFirebaseUserWithAppleId(context);

        if (firebaseUser != null) {
          ///
          /// Got Firebase User
          ///
          Utils.psPrint('User id : ${firebaseUser.uid}');

          ///
          /// Show Progress Dialog
          ///
          await PsProgressDialog.showDialog(context);

          ///
          /// Submit to backend
          ///
          final PsResource<User>? resourceUser =
              await _submitLoginWithAppleId(firebaseUser, languageCode);

          ///
          /// Close Progress Dialog
          ///
          PsProgressDialog.dismissDialog();

          if (resourceUser != null && resourceUser.data != null) {
            ///
            /// Success
            ///
            if (onAppleIdSignInSelected != null) {
              onAppleIdSignInSelected(resourceUser.data!.userId);
            } else if (callBackAfterLoginSuccess != null) {
              callBackAfterLoginSuccess(resourceUser.data);
            }
          } else {
            ///
            /// Error from server
            ///
            showDialog<dynamic>(
                context: context,
                builder: (BuildContext context) {
                  if (resourceUser != null) {
                    return ErrorDialog(
                      message: resourceUser.message,
                    );
                  } else {
                    return ErrorDialog(
                      message: 'login__error_signin'.tr,
                    );
                  }
                });
          }
        }
      } else {
        ///
        /// No Internet Connection
        ///
        showDialog<dynamic>(
            context: context,
            builder: (BuildContext context) {
              return ErrorDialog(
                message: 'error_dialog__no_internet'.tr,
              );
            });
      }
    } else {
      ///
      /// Not yet agree on Privacy Policy
      ///
      showDialog<dynamic>(
          context: context,
          builder: (BuildContext context) {
            return WarningDialog(
              message: 'login__warning_agree_privacy'.tr,
              onPressed: () {},
            );
          });
    }
  }

  Future<PsResource<User>?> _submitLoginWithAppleId(
      fb_auth.User user, String languageCode) async {
    // ignore: unnecessary_null_comparison
    if (user != null) {
      String? email = user.email;
      if (email == null || email == '') {
        // if (user.providerData.isNotEmpty) {
        //   email = user.providerData[0].email;
        // }
        // Apple and Facebook
        if (user.providerData.isNotEmpty) {
          for (int i = 0; i < user.providerData.length; i++) {
            if (user.providerData[i].email != null &&
                user.providerData[i].email!.trim() != '') {
              email = user.providerData[i].email;
            }
          }

          // Email Checking
          email ??= '';
        }
      }
      final AppleLoginParameterHolder appleLoginParameterHolder =
          AppleLoginParameterHolder(
              appleId: user.uid,
              name: user.displayName,
              email: email,
              profilePhotoUrl: user.photoURL,
              deviceToken: psValueHolder!.deviceToken,
              platformName: PsConst.PLATFORM,
              deviceInfo: psValueHolder!.deviceModelName,
              deviceId: psValueHolder!.deviceUniqueId);

      final PsResource<User> _apiStatus =
          await postAppleLogin(appleLoginParameterHolder.toMap(), languageCode);

      if (_apiStatus.data != null) {
        await checkForUserNameNeeded(
            PsConst.APPLE_LOGIN, _apiStatus.data?.userEmail!);
        await replaceAppleLoginUser(true);
        await replaceVerifyUserData('', '', '', '');
        await replaceLoginUserId(_apiStatus.data!.userId!);
        await replaceCurrentLoginMethod(PsConst.APPLE_LOGIN);
      }
      return _apiStatus;
    } else {
      return null;
    }
  }

  Future<fb_auth.User?> _getFirebaseUserWithAppleId(
      BuildContext context) async {
    final List<Scope> scopes = <Scope>[Scope.email, Scope.fullName];

    // 1. perform the sign-in request
    final AuthorizationResult result = await TheAppleSignIn.performRequests(
        <AppleIdRequest>[AppleIdRequest(requestedScopes: scopes)]);
    // 2. check the result
    switch (result.status) {
      case AuthorizationStatus.authorized:
        final AppleIdCredential appleIdCredential = result.credential!;

        final OAuthProvider oAuthProvider = OAuthProvider('apple.com');
        final OAuthCredential credential = oAuthProvider.credential(
          idToken: String.fromCharCodes(appleIdCredential.identityToken!),
          accessToken:
              String.fromCharCodes(appleIdCredential.authorizationCode!),
        );
        fb_auth.UserCredential authResult;
        try {
          authResult = await _firebaseAuth.signInWithCredential(credential);
        } on PlatformException catch (e) {
          print(e);

          handleFirebaseAuthError(context, appleIdCredential.email!);
          // Fail to Login to Firebase, must return null;
          return null;
        }
        fb_auth.User? firebaseUser = authResult.user;
        if (scopes.contains(Scope.fullName)) {
          String? displayName;

          displayName = null;

          if (appleIdCredential.fullName!.givenName != null) {
            displayName = '${appleIdCredential.fullName!.givenName}';
          }

          if (appleIdCredential.fullName!.familyName != null) {
            if (displayName != null) {
              displayName = '$displayName ';
            }

            if (displayName != null) {
              displayName += '${appleIdCredential.fullName!.familyName}';
            } else {
              displayName = '${appleIdCredential.fullName!.familyName}';
            }
          }

          if (displayName != null && displayName != ' ' && displayName != '') {
            await firebaseUser!.updateDisplayName(displayName);
          }
        }

        firebaseUser = _firebaseAuth.currentUser;

        return firebaseUser;
      case AuthorizationStatus.error:
        print(result.error.toString());
        throw PlatformException(
          code: 'ERROR_AUTHORIZATION_DENIED',
          message: result.error.toString(),
        );

      case AuthorizationStatus.cancelled:
        throw PlatformException(
          code: 'ERROR_ABORTED_BY_USER',
          message: 'Sign in aborted by user',
        );
    }
  }

  ///
  /// Google Login Related
  ///
  Future<void> loginWithGoogleId(
      BuildContext context,
      Function? onGoogleIdSignInSelected,
      Function? callBackAfterLoginSuccess,
      String languageCode) async {
    ///
    /// Check User is Accept Terms and Conditions
    ///
    if (isCheckBoxSelect) {
      ///
      /// Check Connection
      ///
      if (await Utils.checkInternetConnectivity()) {
        ///
        /// Get Firebase User with Google Id Login
        ///
        final fb_auth.User? firebaseUser = await _getFirebaseUserWithGoogleId();

        if (firebaseUser != null) {
          ///
          /// Got Firebase User
          ///
          Utils.psPrint('User id : ${firebaseUser.uid}');

          ///
          /// Show Progress Dialog
          ///
          await PsProgressDialog.showDialog(context);

          ///
          /// Submit to backend
          ///
          final PsResource<User>? resourceUser =
              await _submitLoginWithGoogleId(firebaseUser, languageCode);

          ///
          /// Close Progress Dialog
          ///
          PsProgressDialog.dismissDialog();

          if (resourceUser != null && resourceUser.data != null) {
            print('valueHolder::::: ${resourceUser.data!.userEmail}');

            ///
            /// Success
            ///
            if (onGoogleIdSignInSelected != null) {
              onGoogleIdSignInSelected(resourceUser.data!.userId);
            } else if (callBackAfterLoginSuccess != null) {
              callBackAfterLoginSuccess(resourceUser.data!);
            }
          } else {
            ///
            /// Error from server
            ///
            showDialog<dynamic>(
                context: context,
                builder: (BuildContext context) {
                  if (resourceUser != null) {
                    return ErrorDialog(
                      message: resourceUser.message,
                    );
                  } else {
                    return ErrorDialog(
                      message: 'login__error_signin'.tr,
                    );
                  }
                });
          }
        }
      } else {
        ///
        /// No Internet Connection
        ///
        showDialog<dynamic>(
            context: context,
            builder: (BuildContext context) {
              return ErrorDialog(
                message: 'error_dialog__no_internet'.tr,
              );
            });
      }
    } else {
      ///
      /// Not yet agree on Privacy Policy
      ///
      showDialog<dynamic>(
          context: context,
          builder: (BuildContext context) {
            return WarningDialog(
              message: 'login__warning_agree_privacy'.tr,
              onPressed: () {},
            );
          });
    }
  }

  Future<fb_auth.User?> _getFirebaseUserWithGoogleId() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      //for not select any google acc
      if (googleUser == null) {
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final fb_auth.User user =
          (await _firebaseAuth.signInWithCredential(credential)).user!;
      print('signed in' + user.displayName!);
      return user;
    } on Exception {
      print('not select google account');
      return null;
    }
  }

  Future<PsResource<User>?> _submitLoginWithGoogleId(
      fb_auth.User user, String languageCode) async {
    // ignore: unnecessary_null_comparison
    if (user != null) {
      String? email = user.email;
      if (email == null || email == '') {
        // if (user.providerData.isNotEmpty) {
        //   email = user.providerData[0].email;
        // }
        if (user.providerData.isNotEmpty) {
          for (int i = 0; i < user.providerData.length; i++) {
            if (user.providerData[i].email != null &&
                user.providerData[i].email!.trim() != '') {
              email = user.providerData[i].email;
              break;
            }
          }
        } else {
          return null;
        }
      }
      final GoogleLoginParameterHolder googleLoginParameterHolder =
          GoogleLoginParameterHolder(
        googleId: user.uid,
        userName: user.displayName,
        userEmail: email,
        profilePhotoUrl: user.photoURL,
        deviceToken: psValueHolder!.deviceToken,
        platformName: PsConst.PLATFORM,
        deviceInfo: psValueHolder!.deviceModelName,
        deviceId: psValueHolder!.deviceUniqueId,
      );

      final PsResource<User> _apiStatus = await postGoogleLogin(
          googleLoginParameterHolder.toMap(), languageCode);

      if (_apiStatus.data != null) {
        await checkForUserNameNeeded(
            PsConst.GOOGLE_LOGIN, _apiStatus.data?.userEmail!);
        await replaceVerifyUserData('', '', '', '');
        await replaceLoginUserId(_apiStatus.data!.userId!);
        await replaceCurrentLoginMethod(PsConst.GOOGLE_LOGIN);
      }

      return _apiStatus;
    } else {
      return null;
    }
  }

  ///
  /// Facebook Login Related
  ///
  Future<void> loginWithFacebookId(
      BuildContext context,
      Function? onFacebookIdSignInSelected,
      Function? callBackAfterLoginSuccess,
      String languageCode) async {
    ///
    /// Check User is Accept Terms and Conditions
    ///
    if (isCheckBoxSelect) {
      ///
      /// Check Connection
      ///
      if (await Utils.checkInternetConnectivity()) {
        ///
        /// Get Firebase User with Facebook Id Login
        ///
        final FacebookLoginUserHolder? facebookLoginUserHolder =
            await _getFirebaseUserWithFacebookId(context);

        if (facebookLoginUserHolder != null) {
          ///
          /// Got Firebase User
          ///
          Utils.psPrint(
              'User id : ${facebookLoginUserHolder.firebaseUser.uid}');

          ///
          /// Show Progress Dialog
          ///
          await PsProgressDialog.showDialog(context);

          ///
          /// Submit to backend
          ///
          final PsResource<User>? resourceUser =
              await _submitLoginWithFacebookId(
                  facebookLoginUserHolder, languageCode);

          ///
          /// Close Progress Dialog
          ///
          PsProgressDialog.dismissDialog();

          if (resourceUser != null && resourceUser.data != null) {
            ///
            /// Success
            ///
            if (onFacebookIdSignInSelected != null) {
              onFacebookIdSignInSelected(resourceUser.data!.userId);
            } else if (callBackAfterLoginSuccess != null) {
              callBackAfterLoginSuccess(resourceUser.data);
            }
          } else {
            ///
            /// Error from server
            ///
            showDialog<dynamic>(
                context: context,
                builder: (BuildContext context) {
                  if (resourceUser != null) {
                    return ErrorDialog(
                      message: resourceUser.message,
                    );
                  } else {
                    return ErrorDialog(
                      message: 'login__error_signin'.tr,
                    );
                  }
                });
          }
        }
      } else {
        ///
        /// No Internet Connection
        ///
        showDialog<dynamic>(
            context: context,
            builder: (BuildContext context) {
              return ErrorDialog(
                message: 'error_dialog__no_internet'.tr,
              );
            });
      }
    } else {
      ///
      /// Not yet agree on Privacy Policy
      ///
      showDialog<dynamic>(
          context: context,
          builder: (BuildContext context) {
            return WarningDialog(
              message: 'login__warning_agree_privacy'.tr,
              onPressed: () {},
            );
          });
    }
  }

  Future<FacebookLoginUserHolder?> _getFirebaseUserWithFacebookId(
      BuildContext context) async {
    final LoginResult result = await FacebookAuth.instance.login();
    final String token = result.accessToken!.token;
    // Get User Info Based on the Access Token
    final dynamic graphResponse = await http.get(Uri.parse(
        'https://graph.facebook.com/v2.12/me?fields=name,picture.width(800).height(800),first_name,last_name,email&access_token=$token'));
    final dynamic profile = json.decode(graphResponse.body);

    // Firebase Base Login
    // ignore: unnecessary_null_comparison
    if (result != null) {
      final FacebookAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(result.accessToken!.token)
              as FacebookAuthCredential;
      try {
        final fb_auth.User? user =
            (await _firebaseAuth.signInWithCredential(facebookAuthCredential))
                .user;
        print('signed in' + user!.displayName!);

        return FacebookLoginUserHolder(user, profile);
        // return user;
      } on PlatformException catch (e) {
        print(e);

        handleFirebaseAuthError(context, profile['email']);

        return null;
      }
    } else {
      return null;
    }
  }

  Future<PsResource<User>?> _submitLoginWithFacebookId(
      FacebookLoginUserHolder facebookLoginUserHolder,
      String languageCode) async {
    final fb_auth.User user = facebookLoginUserHolder.firebaseUser;
    final dynamic facebookUser = facebookLoginUserHolder.facebookUser;
    // ignore: unnecessary_null_comparison
    if (user != null) {
      String? email = user.email;
      if (email == null || email == '') {
        // if (user.providerData.isNotEmpty) {
        //   email = user.providerData[0].email;
        // }
        if (user.providerData.isNotEmpty) {
          for (int i = 0; i < user.providerData.length; i++) {
            if (user.providerData[i].email != null &&
                user.providerData[i].email!.trim() != '') {
              email = user.providerData[i].email;
            }
          }

          // Email Checking
          email ??= '';
        }
      }
      final FBLoginParameterHolder fbLoginParameterHolder =
          FBLoginParameterHolder(
              facebookId: user.uid,
              name: user.displayName,
              email: email,
              profileImgId: facebookUser['id'],
              deviceToken: psValueHolder!.deviceToken ?? '',
              platformName: PsConst.PLATFORM,
              deviceInfo: psValueHolder!.deviceModelName,
              deviceId: psValueHolder!.deviceUniqueId);

      final PsResource<User> _apiStatus =
          await postFBLogin(fbLoginParameterHolder.toMap(), languageCode);

      if (_apiStatus.data != null) {
        await checkForUserNameNeeded(
            PsConst.FACEBOOK_LOGIN, _apiStatus.data?.userEmail!);
        await replaceVerifyUserData('', '', '', '');
        await replaceLoginUserId(_apiStatus.data!.userId!);
        await replaceCurrentLoginMethod(PsConst.FACEBOOK_LOGIN);
      }

      return _apiStatus;
    } else {
      return null;
    }
  }

  ///
  /// Email Login Related
  ///
  Future<void> loginWithEmailId(
      BuildContext context,
      String email,
      String password,
      Function? onProfileSelected,
      Function? callBackAfterLoginSuccess,
      String languageCode) async {
    ///
    /// Check Connection
    ///
    if (await Utils.checkInternetConnectivity()) {
      ///
      /// Get Firebase User with Email Id Login
      ///

      await signInWithEmailAndPassword(context, email, email);

      ///
      /// Show Progress Dialog
      ///
      await PsProgressDialog.showDialog(context);

      ///
      /// Submit to backend
      ///
      final PsResource<User> resourceUser =
          await _submitLoginWithEmailId(email, password, languageCode);

      ///
      /// Close Progress Dialog
      ///
      PsProgressDialog.dismissDialog();

      // ignore: unnecessary_null_comparison
      if (resourceUser != null && resourceUser.data != null) {
        ///
        /// Success
        ///
        print('valueholder::::${resourceUser.data!.userEmail}');
        if (onProfileSelected != null) {
          onProfileSelected(resourceUser.data!.userId);
        } else if (callBackAfterLoginSuccess != null) {
          callBackAfterLoginSuccess(resourceUser.data);
        }
      } else {
        ///
        /// Error from server
        ///
        showDialog<dynamic>(
            context: context,
            builder: (BuildContext context) {
              // ignore: unnecessary_null_comparison
              if (resourceUser.message != null) {
                return ErrorDialog(
                  message: resourceUser.message,
                );
              } else {
                return ErrorDialog(
                  message: 'login__error_signin'.tr,
                );
              }
            });
      }
    } else {
      ///
      /// No Internet Connection
      ///
      showDialog<dynamic>(
          context: context,
          builder: (BuildContext context) {
            return ErrorDialog(
              message: 'error_dialog__no_internet'.tr,
            );
          });
    }
  }

  Future<fb_auth.User?> signInWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    fb_auth.UserCredential result;
    fb_auth.User? user;
    try {
      final bool isEmailFormatCorrect = Utils.checkEmailFormat(email)!;
      if (isEmailFormatCorrect) {
        result = await _firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        //sign in with default credentials
        result = await _firebaseAuth.signInWithEmailAndPassword(
            email: PsConst.defaultEmail, password: PsConst.defaultPassword);
      }
      user = result.user;
    } on Exception catch (e1) {
      print(e1);

      final fb_auth.User? _user = await createUserWithEmailAndPassword(
          context, email, password,
          ignoreHandleFirebaseAuthError: true);

      //sing in with default credentials
      if (_user == null) {
        try {
          result = await _firebaseAuth.signInWithEmailAndPassword(
              email: PsConst.defaultEmail, password: PsConst.defaultPassword);
          user = result.user;
        } on PlatformException catch (e) {
          print(e);
          final fb_auth.User? _user2 = await createUserWithEmailAndPassword(
              context, PsConst.defaultEmail, PsConst.defaultPassword,
              ignoreHandleFirebaseAuthError: true);

          if (_user2 != null) {
            user = _user2;
          }
        }
      } else {
        user = _user;
      }
    }

    print('signInEmail succeeded: $user');

    return user;
  }

  // Future<PsResource<User>> _submitLoginWithEmailId(
  //     String email, String password, String languageCode) async {
  //   final UserLoginParameterHolder userLoginParameterHolder =
  //       UserLoginParameterHolder(
  //     userEmail: email,
  //     userPassword: password,
  //     deviceToken: psValueHolder!.deviceToken,
  //     platformName: PsConst.PLATFORM,
  //     deviceInfo: psValueHolder!.deviceModelName,
  //     deviceId: psValueHolder!.deviceUniqueId,
  //   );

  //   final PsResource<User> _apiStatus =
  //       await postUserLogin(userLoginParameterHolder.toMap(), languageCode);

  //   if (_apiStatus.data != null) {
  //     await checkForUserNameNeeded(
  //         PsConst.NORMAL_LOGIN, email);
  //     await replaceVerifyUserData('', '', '', '');
  //     await replaceLoginUserId(_apiStatus.data!.userId!);
  //     await replaceCurrentLoginMethod(PsConst.NORMAL_LOGIN);
  //   }
  //   return _apiStatus;
  // }

  Future<PsResource<User>> _submitLoginWithEmailId(
      String email, String password, String languageCode) async {
    final UserLoginParameterHolder userLoginParameterHolder =
        UserLoginParameterHolder(
      userEmail: email,
      userPassword: password,
      deviceToken: psValueHolder!.deviceToken,
      platformName: PsConst.PLATFORM,
      deviceInfo: psValueHolder!.deviceModelName,
      deviceId: psValueHolder!.deviceUniqueId,
    );

    final PsResource<User> _apiStatus =
        await postUserLogin(userLoginParameterHolder.toMap(), languageCode);
 
    String? loginName = email;// input from textbox
    if (_apiStatus.data?.userEmail != null &&  _apiStatus.data?.userEmail != '') {
      loginName = _apiStatus.data?.userEmail!;
    } else if (_apiStatus.data?.userPhone != null &&  _apiStatus.data?.userPhone != '') {
      loginName = _apiStatus.data?.userPhone!;
    }
    if (_apiStatus.data != null) {
      await checkForUserNameNeeded(
          PsConst.NORMAL_LOGIN, loginName);
      await replaceVerifyUserData('', '', '', '');
      await replaceLoginUserId(_apiStatus.data!.userId!);
      await replaceCurrentLoginMethod(PsConst.NORMAL_LOGIN);
    }
    return _apiStatus;
  }

  ///
  /// Email Register Related
  ///
  Future<void> signUpWithEmailId(
      BuildContext context,
      Function? onRegisterSelected,
      String name,
      String userName,
      String email,
      String password,
      Function? callBackAfterLoginSuccess,
      String languageCode) async {
    ///
    /// Check User is Accept Terms and Conditions
    ///
    if (isCheckBoxSelect) {
      ///
      /// Check Connection
      ///
      if (await Utils.checkInternetConnectivity()) {
        ///
        /// Get Firebase User with Email Id Login
        ///
        final fb_auth.User? firebaseUser =
            await createUserWithEmailAndPassword(context, email, email);

        if (firebaseUser != null) {
          ///
          /// Show Progress Dialog
          ///
          await PsProgressDialog.showDialog(context);

          ///
          /// Submit to backend
          ///
          final PsResource<User> resourceUser = await _submitSignUpWithEmailId(
              context, onRegisterSelected, name,userName, email, password, languageCode);

          ///
          /// Close Progress Dialog
          ///
          ///
          PsProgressDialog.dismissDialog();

          if (resourceUser.data != null) {
            ///
            /// Success
            ///

            final User user = resourceUser.data!;
            if (user.needVerify != PsConst.ONE) {
              // Approval Off
              await replaceVerifyUserData('', '', '', '');
              await replaceLoginUserId(resourceUser.data!.userId!);

              if (onRegisterSelected != null) {
                onRegisterSelected(resourceUser.data);
              } else if (callBackAfterLoginSuccess != null) {
                callBackAfterLoginSuccess(resourceUser.data);
              }
            } else {
              // Approval On
              showDialog<dynamic>(
                  context: context,
                  builder: (BuildContext context) {
                    return EmailSentWarningDialog(
                      message: 'register__confirmation'.tr,
                      onPressed: () async {
                        Navigator.pop(context);
                        if (onRegisterSelected != null) {
                          onRegisterSelected(resourceUser.data);
                        } else {
                          await replaceVerifyUserData(
                              resourceUser.data!.userId!,
                              resourceUser.data!.name!,
                              resourceUser.data!.userEmail!,
                              password);

                          psValueHolder!.userIdToVerify = user.userId;
                          psValueHolder!.userNameToVerify = user.name;
                          psValueHolder!.userEmailToVerify = user.userEmail;

                          final dynamic returnData = await Navigator.pushNamed(
                              context, RoutePaths.user_verify_email_container,
                              arguments: resourceUser.data!.userId);

                          if (returnData != null && returnData is User) {
                            final User user = returnData;
                            psValueHolder = Provider.of<PsValueHolder>(context,
                                listen: false);
                            psValueHolder!.loginUserId = user.userId;
                            psValueHolder!.userIdToVerify = '';
                            psValueHolder!.userNameToVerify = '';
                            psValueHolder!.userEmailToVerify = '';
                            psValueHolder!.userPasswordToVerify = '';
                            print(user.userId);

                            Navigator.pop(context, resourceUser.data);
                          }
                        }
                      },
                    );
                  });
            }
            //delete code from here
          } else {
            ///
            /// Error from server
            ///
            showDialog<dynamic>(
                context: context,
                builder: (BuildContext context) {
                  // ignore: unnecessary_null_comparison
                  if (resourceUser != null) {
                    return ErrorDialog(
                      message: resourceUser.message,
                    );
                  } else {
                    return ErrorDialog(
                      message: 'login__error_signin'.tr,
                    );
                  }
                });
          }
        }
      } else {
        ///
        /// No Internet Connection
        ///
        showDialog<dynamic>(
            context: context,
            builder: (BuildContext context) {
              return ErrorDialog(
                message: 'error_dialog__no_internet'.tr,
              );
            });
      }
    } else {
      ///
      /// Not yet agree on Privacy Policy
      ///
      showDialog<dynamic>(
          context: context,
          builder: (BuildContext context) {
            return WarningDialog(
              message: 'login__warning_agree_privacy'.tr,
              onPressed: () {},
            );
          });
    }
  }

  Future<fb_auth.User?> createUserWithEmailAndPassword(
      BuildContext context, String email, String password,
      {bool ignoreHandleFirebaseAuthError = false}) async {
    fb_auth.UserCredential result;
    try {
      result = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on Exception catch (e) {
      print(e);

      final List<String> providers =
          await _firebaseAuth.fetchSignInMethodsForEmail(email);

      final String provider = providers.single;
      print('provider : $provider');
      // Registered With Email
      if (provider.contains(PsConst.emailAuthProvider)) {
        final fb_auth.User? user =
            await signInWithEmailAndPassword(context, email, email);

        if (user == null) {
          if (!ignoreHandleFirebaseAuthError) {
            handleFirebaseAuthError(context, email, ignoreEmail: true);
          }

          // Fail to Login to Firebase, must return null;
          return null;
        } else {
          return user;
        }
      } else {
        if (!ignoreHandleFirebaseAuthError) {
          handleFirebaseAuthError(context, email, ignoreEmail: true);
        }
        return null;
      }
    }

    final fb_auth.User? user = result.user;

    return user;
  }

  Future<PsResource<User>> _submitSignUpWithEmailId(
      BuildContext context,
      Function? onRegisterSelected,
      String name,
      String userName,
      String email,
      String password,
      String languageCode) async {
    final UserRegisterParameterHolder userRegisterParameterHolder =
        UserRegisterParameterHolder(
      name: name,
      userName: userName,
      userEmail: email,
      userPassword: password,
      userPhone: '',
      deviceToken: psValueHolder!.deviceToken,
      platformName: PsConst.PLATFORM,
      deviceInfo: psValueHolder!.deviceModelName,
      deviceId: psValueHolder!.deviceUniqueId,
    );

    final PsResource<User> _apiStatus = await postUserRegister(
        userRegisterParameterHolder.toMap(), languageCode);

    if (_apiStatus.data != null) {
      final User user = _apiStatus.data!;

      //for change email
      await replaceVerifyUserData(_apiStatus.data!.userId!,
          _apiStatus.data!.name!, _apiStatus.data!.userEmail!, password);

      psValueHolder!.userIdToVerify = user.userId;
      psValueHolder!.userNameToVerify = user.name;
      psValueHolder!.userEmailToVerify = user.userEmail;
    }

    return _apiStatus;
  }

  Future<dynamic> postApplyBlueMark(Map<dynamic, dynamic> jsonMap,
      String loginUserId, String languageCode) async {
    isLoading = true;

    isConnectedToInternet = await Utils.checkInternetConnectivity();

    _apiStatus = await _repo!.postApplyBlueMark(
        jsonMap,
        loginUserId,
        psValueHolder!.headerToken!,
        isConnectedToInternet,
        PsStatus.PROGRESS_LOADING,
        languageCode);

    return _apiStatus;
  }

  Future<void> checkForUserNameNeeded(String loginMethod, String? email) async {
    late UserNameStatusParameterHolder holder;
    if (loginMethod == PsConst.PHONE_LOGIN) {
      holder =
          UserNameStatusParameterHolder(loginMethod: loginMethod, userPhone: email);
    } else {
      holder =
          UserNameStatusParameterHolder(loginMethod: loginMethod, email: email);
    }

    final PsResource<UserNameStatus> status =
        await checkUserNameExists(holder.toMap());

    if (status.data != null) {
      await replaceIsUserNameAndPwdNeeded(
          status.data?.message?.isUserNameExisted != PsConst.ONE,
          status.data?.message?.hasPassword != 'true');
    }
  }
}

SingleChildWidget initUserProvider(
  BuildContext context, {
  String? userId,
  Widget? widget,
}) {
  final UserRepository repo = Provider.of<UserRepository>(context);
  final PsValueHolder valueHolder = Provider.of<PsValueHolder>(context);
  return psInitProvider<UserProvider>(
      initProvider: () => UserProvider(repo: repo, psValueHolder: valueHolder),
      onProviderReady: (UserProvider provider) {
        if (provider.psValueHolder!.loginUserId == null ||
            provider.psValueHolder!.loginUserId == '') {
          provider.userParameterHolder.id = userId;
          provider.getUser(userId, valueHolder.languageCode!);
        } else {
          provider.userParameterHolder.id = provider.psValueHolder!.loginUserId;
          provider.getUser(
              provider.psValueHolder!.loginUserId, valueHolder.languageCode!);
        }
        print('..................USER_ID...................');
        print(provider.userParameterHolder.id);
        return provider;
      });
}
