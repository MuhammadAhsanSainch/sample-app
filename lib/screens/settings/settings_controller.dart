import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:image_picker/image_picker.dart';
import 'package:path_to_water/utilities/app_exports.dart';
import 'package:path_to_water/widgets/custom_dialog.dart';
class SettingsController extends GetxController with GetSingleTickerProviderStateMixin {
  final TextEditingController fullNameTFController = TextEditingController();
  final TextEditingController userNameTFController = TextEditingController();
  final TextEditingController emailTFController = TextEditingController();
  final TextEditingController dOBTFController = TextEditingController();
  final TextEditingController genderTFController = TextEditingController();

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
    return NetworkService.handleApiCall(
      AppUrl.apiService.uploadMedia(dio.FormData.fromMap(map)),
      errorMessagePrefix: 'uploadImage',
    ).then((value) {
      if (value['status'] == true) {
        profileImgKey.value = value['data']['key'];
        update();
      }
    });
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

  void onFavoriteIconTap() {
    Get.dialog(
      CustomDialog(
        message: "Removing this item will no longer show it in your Favorites list.",
        imageIcon: AppConstants.trashIcon,
        title: "Removed from favorites?",
        btnText: "Remove",
        onButtonTap: () {},
      ),
    );
  }
}