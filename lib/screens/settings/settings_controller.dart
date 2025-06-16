import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:image_picker/image_picker.dart';
import 'package:path_to_water/utilities/app_exports.dart';

import '../../api_core/custom_exception_handler.dart';
import '../../api_services/profile_services.dart';
import '../../widgets/custom_dialog.dart';

class SettingsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final TextEditingController fullNameTFController = TextEditingController();
  final TextEditingController userNameTFController = TextEditingController();
  final TextEditingController emailTFController = TextEditingController();
  final TextEditingController dOBTFController = TextEditingController();
  final TextEditingController genderTFController = TextEditingController();
  final TextEditingController currentPassTFController = TextEditingController();
  final TextEditingController newPassTFController = TextEditingController();
  final TextEditingController confirmNewTFController = TextEditingController();

  RxBool isNotification = false.obs;

  // Function to pick an image
  File? imageFile;
  final ImagePicker _picker = ImagePicker();
  final profileImgKey = ''.obs;
  final profilePicture = ''.obs;

  Future uploadImage(Map<String, dynamic> reqBody) async {
    var map = reqBody;
    if (map["file"] != null) {
      map["file"] = await dio.MultipartFile.fromFile(map["file"]);
    }
    // return NetworkService.handleApiCall(
    //   AppUrl.apiService.uploadMedia(dio.FormData.fromMap(map)),
    //   errorMessagePrefix: 'uploadImage',
    // ).then((value) {
    //   if (value['status'] == true) {
    //     profileImgKey.value = value['data']['key'];
    //     update();
    //   }
    // });
  }

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 800,
      maxHeight: 800,
      imageQuality: 80,
    );
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      await uploadImage({'file': imageFile?.path});
      log('profileImageKey: $profileImgKey');
      update();
    }
  }

  Future<void> pickDate() async {
    var date = await AppGlobals().selectDate(Get.context!);
    dOBTFController.text = AppGlobals.formatDate(date);
  }

  Future getProfile() async {
    try {
      AppGlobals.isLoading(true);
      final res = await ProfileServices.getProfile();
      if (res != null) {
        fullNameTFController.text = res.name ?? '';
        userNameTFController.text = res.userName ?? '';
        emailTFController.text = res.email ?? '';
        dOBTFController.text = AppGlobals.formatDate(DateTime.parse(res.dob ?? ''));
        genderTFController.text = res.gender?.toTitleCase() ?? 'Choose One';
      }
    } on Exception catch (e) {
      ExceptionHandler().handleException(e);
    } catch (e) {
      log(e.toString());
    } finally {
      AppGlobals.isLoading(false);
    }
  }

  Future updateProfile() async {
    try {
      AppGlobals.isLoading(true);
      final res = await ProfileServices.updateProfile({
        "name": fullNameTFController.text,
        "gender": genderTFController.text.toUpperCase(),
        "dob": AppGlobals.toISOFormatDate(dOBTFController.text),
        // "logo": "url"
      });
      if (res != null) {
        fullNameTFController.text = res.name ?? '';
        userNameTFController.text = res.userName ?? '';
        emailTFController.text = res.email ?? '';
        dOBTFController.text = AppGlobals.formatDate(
          DateTime.parse(res.dob ?? ''),
        );
        genderTFController.text = res.gender?.toTitleCase() ?? 'Choose One';
        Get.dialog(
          CustomDialog(
            title: "Profile Saved",
            message:
            "Your changes have been saved successfully.",
            imageIcon: AppConstants.celebrationIcon,
            showCloseIcon: false,
            btnText: "Close",
            onButtonTap: () {
              Get.close(2);
            },
          ),
        );
      }
    } on Exception catch (e) {
      ExceptionHandler().handleException(e);
    } catch (e) {
      log(e.toString());
    } finally {
      AppGlobals.isLoading(false);
    }
  }

  Future changePassword() async {
    try {
      AppGlobals.isLoading(true);
      final res = await ProfileServices.updateProfile({
        "name": fullNameTFController.text,
        "gender": genderTFController.text.toUpperCase(),
        "dob": AppGlobals.toISOFormatDate(dOBTFController.text),
        // "logo": "url"
      });
      if (res != null) {
        fullNameTFController.text = res.name ?? '';
        userNameTFController.text = res.userName ?? '';
        emailTFController.text = res.email ?? '';
        dOBTFController.text = AppGlobals.formatDate(
          DateTime.parse(res.dob ?? ''),
        );
        genderTFController.text = res.gender?.toTitleCase() ?? 'Choose One';
        Get.dialog(
          CustomDialog(
            title: "Profile Saved",
            message:
            "Your changes have been saved successfully.",
            imageIcon: AppConstants.celebrationIcon,
            showCloseIcon: false,
            btnText: "Close",
            onButtonTap: () {
              Get.close(2);
            },
          ),
        );
      }
    } on Exception catch (e) {
      ExceptionHandler().handleException(e);
    } catch (e) {
      log(e.toString());
    } finally {
      AppGlobals.isLoading(false);
    }
  }

  @override
  void onInit() {
    super.onInit();
    getProfile();
  }
}
