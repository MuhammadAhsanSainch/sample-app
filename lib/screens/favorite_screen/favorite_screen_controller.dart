import 'package:path_to_water/api_core/custom_exception_handler.dart';
import 'package:path_to_water/api_services/favorite_service.dart';
import 'package:path_to_water/models/favorite_ayat_model.dart';
import 'package:path_to_water/models/favorite_hadith_model.dart';
import 'package:path_to_water/models/favorite_history_model.dart';
import 'package:path_to_water/utilities/app_exports.dart';
import 'package:path_to_water/widgets/custom_dialog.dart';

class FavoriteScreenController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  RxInt currentTabIndex = 0.obs;

  List<FavoriteAyahModel> favoriteAyat = [];
  List<FavoriteHadithModel> favoriteHadith = [];
  List<FavoriteHistoryModel> favoriteHistory = [];

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 3, vsync: this);
  }

  final TextEditingController searchController = TextEditingController();

  void onFavoriteIconTap(String? id) {
    Get.dialog(
      CustomDialog(
        message: "Removing this item will no longer show it in your Favorites list.",
        imageIcon: AppConstants.trashIcon,
        title: "Removed from favorites?",
        btnText: "Remove",
        onButtonTap: () {
          Get.back();
          removeFromFavorite(id);
        },
      ),
    );
  }

  getFavoriteAyat() async {
    try {
      AppGlobals.isLoading(true);
      favoriteAyat = await FavoriteService.getFavoriteAyat();
      update();
    } on Exception catch (e) {
      ExceptionHandler().handleException(e);
    } finally {
      AppGlobals.isLoading(false);
    }
  }

  getFavoriteHadith() async {
    try {
      AppGlobals.isLoading(true);
      favoriteHadith = await FavoriteService.getFavoriteHadith();
      update();
    } on Exception catch (e) {
      ExceptionHandler().handleException(e);
    } finally {
      AppGlobals.isLoading(false);
    }
  }

  getFavoriteHistory() async {
    try {
      AppGlobals.isLoading(true);
      favoriteHistory = await FavoriteService.getFavoriteHistory();
      update();
    } on Exception catch (e) {
      ExceptionHandler().handleException(e);
    } finally {
      AppGlobals.isLoading(false);
    }
  }

  Future<void> removeFromFavorite(String? id) async {
    try {
      if (id.isNullOREmpty) return;
      AppGlobals.isLoading(true);
      await Future.delayed(Duration(milliseconds: 1000));
      switch (currentTabIndex.value) {
        case 0:
          await FavoriteService.removeAyatFromFavorite(id!);
          getFavoriteAyat();
          break;
        case 1:
          await FavoriteService.removeHadithFromFavorite(id!);
          getFavoriteHadith();
          break;
        case 2:
          await FavoriteService.removeHistoryFromFavorite(id!);
          getFavoriteHistory();
          break;
        default:
      }
    } on Exception catch (e) {
      ExceptionHandler().handleException(e);
    } finally {
      AppGlobals.isLoading(false);
    }
  }

  onRefresh() {
    getFavoriteAyat();
    getFavoriteHadith();
    getFavoriteHistory();
  }
}
