import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/config/ps_config.dart';
import 'package:psxmpc/core/vendor/api/common/ps_status.dart';
import 'package:psxmpc/core/vendor/constant/ps_constants.dart';
import 'package:psxmpc/core/vendor/db/common/ps_data_source_manager.dart';
import 'package:psxmpc/core/vendor/provider/user/user_feild_provider.dart';
import 'package:psxmpc/core/vendor/repository/user_field_repository.dart';
import 'package:psxmpc/core/vendor/viewobject/custom_field.dart';
import 'package:psxmpc/core/vendor/viewobject/edit_profile_user_relation.dart';
import 'package:psxmpc/core/vendor/viewobject/holder/request_path_holder.dart';
import 'package:psxmpc/core/vendor/viewobject/selected_object.dart';
import 'package:psxmpc/core/vendor/viewobject/selected_value.dart';
import 'package:psxmpc/ui/vendor_ui/common/dialog/warning_dialog_view.dart';
import 'package:psxmpc/ui/vendor_ui/common/ps_app_bar_widget.dart';
import 'package:psxmpc/ui/vendor_ui/common/user_custom_ui/ps_user_cutom_widget.dart';

import '../../../../../core/vendor/api/common/ps_resource.dart';
import '../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../core/vendor/repository/user_repository.dart';
import '../../../../../core/vendor/utils/ps_progress_dialog.dart';
import '../../../../../core/vendor/utils/utils.dart';
import '../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../core/vendor/viewobject/holder/profile_update_view_holder.dart';
import '../../../../../core/vendor/viewobject/user.dart';
import '../../../../../core/vendor/viewobject/user_relation.dart';
import '../../../../custom_ui/user/edit_profile/component/profile/email_checkbox.dart';
import '../../../../custom_ui/user/edit_profile/component/profile/phone_no_checkbox.dart';
import '../../../../custom_ui/user/edit_profile/component/profile/phone_no_widget.dart';
import '../../../../custom_ui/user/edit_profile/component/profile/profile_image_widget.dart';
import '../../../common/dialog/error_dialog.dart';
import '../../../common/dialog/success_dialog.dart';
import '../../../common/ps_textfield_widget.dart';
import '../../../common/ps_ui_widget.dart';

class EditProfileView extends StatefulWidget {
  @override
  _EditProfileViewState createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView>
    with SingleTickerProviderStateMixin {
  UserRepository? userRepository;
  UserProvider? userProvider;
  PsValueHolder? psValueHolder;
  late UserFieldProvider userFieldProvider;
  late UserFieldRepository userFieldRepository;
  late AnimationController animationController;
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController aboutMeController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController customFiledWhatsappTextController = TextEditingController();
  // final TextEditingController idTextController = TextEditingController();

  bool bindDataFirstTime = true;
  late AppLocalization langProvider;
  List<CustomField> customFieldList = <CustomField>[];

  @override
  void initState() {
    animationController =
        AnimationController(duration: PsConfig.animation_duration, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    userRepository = Provider.of<UserRepository>(context);
    psValueHolder = Provider.of<PsValueHolder>(context);
    langProvider = Provider.of<AppLocalization>(context);
    userFieldRepository = Provider.of<UserFieldRepository>(context);

    Future<bool> _requestPop() {
      animationController.reverse().then<dynamic>(
        (void data) {
          if (!mounted) {
            return Future<bool>.value(false);
          }
          Navigator.pop(context, true);
          return Future<bool>.value(true);
        },
      );
      return Future<bool>.value(false);
    }

    return WillPopScope(
      onWillPop: _requestPop,
      child: Scaffold(
        appBar: PsAppbarWidget(
          appBarTitle: 'edit_profile__title'.tr,
          actionWidgets: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () async {
                  onTapSave(context, userProvider!);
                },
                child: Text(
                  'edit_profile__save'.tr,
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor),
                ),
              ),
            ),
          ],
        ),
        body: MultiProvider(
            providers: <SingleChildWidget>[
              ChangeNotifierProvider<UserProvider?>(
                  lazy: false,
                  create: (BuildContext context) {
                    userProvider = UserProvider(
                        repo: userRepository!, psValueHolder: psValueHolder);
                    userProvider!.getUser(
                        userProvider!.psValueHolder!.loginUserId ?? '',
                        langProvider.currentLocale.languageCode);
                    return userProvider;
                  }),
              ChangeNotifierProvider<UserFieldProvider?>(
                  lazy: false,
                  create: (BuildContext context) {
                    userFieldProvider = UserFieldProvider(
                      repo: userFieldRepository,
                    );
                    userFieldProvider.loadData(
                        dataConfig: DataConfiguration(
                            dataSourceType: PsConfig.cacheInItemEntry
                                ? DataSourceType.FULL_CACHE
                                : DataSourceType.SERVER_DIRECT),
                        requestPathHolder: RequestPathHolder(
                            loginUserId: psValueHolder?.loginUserId,
                            languageCode:
                                langProvider.currentLocale.languageCode));

                    return userFieldProvider;
                  }),
            ],
            child: Consumer<UserProvider>(builder: (BuildContext context,
                UserProvider userProvider, Widget? child) {
              if (userProvider.user.data != null) {
                if (!userFieldProvider.hasData &&
                    (userFieldProvider.currentStatus ==
                            PsStatus.BLOCK_LOADING ||
                        userFieldProvider.currentStatus ==
                            PsStatus.PROGRESS_LOADING)) {
                  return Container(
                    margin: const EdgeInsets.only(top: PsDimens.space16),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Utils.isLightMode(context)
                            ? PsColors.text300
                            : PsColors.text50,
                      ),
                    ),
                  );
                } else if (!userFieldProvider.hasData) {
                  return const SizedBox();
                } else {
                  updateCustomFieldList(
                      userFieldProvider.userField.data!.customField ??
                          <CustomField>[]);
                }

                if (bindDataFirstTime) {
                  userNameController.text = userProvider.user.data!.name!;
                  emailController.text = userProvider.user.data!.userEmail!;
                  addressController.text = userProvider.user.data!.userAddress!;
                  if (userProvider.user.data!.hasPhone)
                    phoneController.text = '(' +
                        userProvider.user.data!.userPhone!
                            .replaceFirst(RegExp(r'-'), ')');
                  aboutMeController.text = userProvider.user.data!.userAboutMe!;

                  bindDataFirstTime = false;
                }

                return SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      const CustomImageWidget(),
                      const SizedBox(
                        height: PsDimens.space16,
                      ),
                      PsTextFieldWidget(
                          titleText: 'edit_profile__user_name'.tr,
                          hintText: 'edit_profile__user_name'.tr,
                          textAboutMe: false,
                          textEditingController: userNameController),
                      PsTextFieldWidget(
                          titleText: 'edit_profile__email'.tr,
                          hintText: 'edit_profile__email'.tr,
                          keyboardType: TextInputType.emailAddress,
                          textAboutMe: false,
                          textEditingController: emailController),
                      CustomPhoneNoWidget(phoneController: phoneController),
                      PsTextFieldWidget(
                          titleText: 'edit_profile__about_me'.tr,
                          height: PsDimens.space120,
                          keyboardType: TextInputType.multiline,
                          textAboutMe: true,
                          hintText: 'edit_profile__about_me'.tr,
                          textEditingController: aboutMeController),
                      const SizedBox(
                        height: 2,
                      ),
                      //// Custom user filed
                      ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: customFieldList.length,
                          itemBuilder: (BuildContext context, int index) {
                            final CustomField customField =
                                customFieldList[index];

                    final TextEditingController valueTextController =
                        TextEditingController();
                    final TextEditingController idTextController =
                        TextEditingController();
                            if (customField.coreKeyId != null) {
                              //if (widget.flag == PsConst.EDIT_ITEM) {
                              final CustomField customField =
                                  customFieldList[index];
                              userProvider.user.data!.userRelation
                                  ?.forEach((UserRelation element) {
                                if (element.coreKeyId ==
                                        customField.coreKeyId &&
                                    element.selectedValues!.isNotEmpty) {
                                  if (customField.uiType?.coreKeyId !=
                                      PsConst.MULTI_SELECTION) {
                                    idTextController.text = element
                                            .selectedValues?[0].id
                                            .toString() ??
                                        '';
                                    valueTextController.text =
                                        element.selectedValues?[0].value! ?? '';
                                  } else {
                                    final List<String> idList = <String>[];
                                    final List<String> values = <String>[];
                                    element.selectedValues
                                        ?.forEach((SelectedValue element) {
                                      idList.add(element.id.toString());
                                      values.add(element.value.toString());
                                    });
                                    idTextController.text = idList.join(',');
                                    valueTextController.text = values.join(',');
                                  }
                                }
                              });
                              // }
                              if (!userFieldProvider.textControllerMap
                                  .containsKey(customField)) {
                                print(
                                    'core and custom field ${customField.coreKeyId}');
                                userFieldProvider.textControllerMap.putIfAbsent(
                                  customField,
                                  () => SelectedObject(
                                    valueTextController: valueTextController,
                                    idTextController: idTextController,
                                  ),
                                );
                              }
                            }
                            return PsUserCustomWidget(
                              customField: customField,
                              valueTextController: valueTextController,
                              idTextController: idTextController,
                            );
                          }),
                      CustomEmailCheckboxWidget(),
                      const SizedBox(
                        height: PsDimens.space18,
                      ),
                      CustomPhoneNoCheckboxWidget(),
                      const SizedBox(
                        height: PsDimens.space64,
                      ),
                    ],
                  ),
                );
              } else {
                return Stack(
                  children: <Widget>[
                    const SizedBox(),
                    PSProgressIndicator(userProvider.user.status)
                  ],
                );
              }
            })),
      ),
      //],
    );
  }

  void updateCustomFieldList(List<CustomField> updateList) {
    for (CustomField updateCustomField in updateList) {
      final int index = customFieldList.indexWhere((CustomField element) =>
          element.coreKeyId == updateCustomField.coreKeyId);
      if (index < 0) {
        //add new custom field
        customFieldList.add(updateCustomField);
      } else {
        //update data of old custom field
        customFieldList[index].copy(updateCustomField);
      }
    }
  }

  bool validate() {
    bool isValid = true;
    bool hasOngoingWarning = false;



    // if (customFieldList[6].coreKeyId == userWhatsapp &&
    //     !hasCountryCode(valueTextController.text)) {
    //   showMandatoryAlert('Please include the country code in the number.');
    // }

    userFieldProvider.textControllerMap
        .forEach((CustomField customField, SelectedObject value) {
      print(
          '${customField.coreKeyId}>>> ${value.valueTextController.text}>>> ${value.idTextController.text}');
       
      if (customField.isMandatory &&
          customField.isVisible &&
          !hasOngoingWarning) {
        if (value.valueTextController.text.isEmpty) {
          showMandatoryAlert('${customField.name} is required.');
          hasOngoingWarning = true;
          isValid = false;
          return;
        } else {
          addToProductRelationList(customField, value);
        }
      } else if (customField.isVisible) {
        addToProductRelationList(customField, value);
      }
    });

    if (!isValid) {
      return false;
    }
    return isValid;
  }

  void addToProductRelationList(CustomField customField, SelectedObject value) {
    if (customField.uiType?.coreKeyId == PsConst.DROP_DOWN_BUTTON ||
        customField.uiType?.coreKeyId == PsConst.RADIO_BUTTON ||
        customField.uiType?.coreKeyId == PsConst.MULTI_SELECTION) {
      print('${customField.coreKeyId}>>> adding id text controller ... ');
      final EditProfileUserRelation entryProductRelation =
          EditProfileUserRelation(
        coreKeyId: customField.coreKeyId,
        value: value.idTextController.text,
      );
      userProvider!.userRelationList.add(entryProductRelation);
    } else {
      print('${customField.coreKeyId}>>> adding value text controller ... ');
      final EditProfileUserRelation entryProductRelation =
          EditProfileUserRelation(
        coreKeyId: customField.coreKeyId,
        value: value.valueTextController.text,
      );
       customFiledWhatsappTextController.text = value.valueTextController.text;
      userProvider!.userRelationList.add(entryProductRelation);
    }
  }

  dynamic onTapSave(BuildContext context, UserProvider provider) async {

    const String userWhatsapp = 'ps-usr00012';
    bool hasCountryCode(String number) {
      return RegExp(r'^\+\d{2,}').hasMatch(number);
    }
    
    final bool result = validate();

    if (result == true) {
      if (userNameController.text == '') {
        showDialog<dynamic>(
            context: context,
            builder: (BuildContext context) {
              return ErrorDialog(
                message: 'edit_profile__name_error'.tr,
              );
            });
      } else if (emailController.text == '') {
        showDialog<dynamic>(
            context: context,
            builder: (BuildContext context) {
              return ErrorDialog(
                message: 'edit_profile__email_error'.tr,
              );
            });
     } else if (customFieldList[6].coreKeyId == userWhatsapp &&
        !hasCountryCode(customFiledWhatsappTextController.text) && customFiledWhatsappTextController.text != '') {
        showDialog<dynamic>(
            context: context,
            builder: (BuildContext context) {
              return ErrorDialog(
                message: 'Please include the country code in the number.'.tr,
              );
            });
      } else {
        if (await Utils.checkInternetConnectivity()) {
          String purePhoneNum = phoneController.text.replaceFirst(')', '-');
          purePhoneNum = purePhoneNum.replaceFirst('(', '');
          final ProfileUpdateParameterHolder profileUpdateParameterHolder =
              ProfileUpdateParameterHolder(
            userId: provider.user.data!.userId,
            userName: userNameController.text,
            userEmail: emailController.text.trim(),
            userPhone: purePhoneNum,
            userAboutMe: aboutMeController.text,
            isShowEmail: provider.user.data!.isShowEmail,
            isShowPhone: provider.user.data!.isShowPhone,
            userRelation: userProvider!.userRelationList,
          );
          await PsProgressDialog.showDialog(context);
          final PsResource<User> _apiStatus = await provider.postProfileUpdate(
              profileUpdateParameterHolder.toMap(),
              psValueHolder!.loginUserId!,
              langProvider.currentLocale.languageCode);
          if (_apiStatus.data != null) {
            PsProgressDialog.dismissDialog();
            showDialog<dynamic>(
                context: context,
                builder: (BuildContext contet) {
                  return SuccessDialog(
                    message: 'edit_profile__success'.tr,
                    onPressed: () {},
                  );
                });
          } else {
            PsProgressDialog.dismissDialog();

            showDialog<dynamic>(
                context: context,
                builder: (BuildContext context) {
                  return ErrorDialog(
                    message: _apiStatus.message,
                  );
                });
          }
        } else {
          showDialog<dynamic>(
              context: context,
              builder: (BuildContext context) {
                return ErrorDialog(
                  message: 'error_dialog__no_internet'.tr,
                );
              });
        }
      }
    } else {
      userProvider!.userRelationList.clear();
    }
  }

  void showMandatoryAlert(String message) {
    showDialog<dynamic>(
        context: context,
        builder: (BuildContext context) {
          return WarningDialog(
            message: message,
            onPressed: () {},
          );
        });
  }
}
