
import 'package:flutter/cupertino.dart';
import 'package:path_to_water/utilities/app_exports.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color? bgColor;
  final Widget? leadingWidget;
  final bool? showBackIcon;
  final bool? showMenuIcon;
  final bool? centerTitle;
  final String text;
  final void Function()? onPressed;
  final void Function()? onMenuPressed;
  const CustomAppBar({
    super.key,
    this.bgColor,
    this.leadingWidget,
    this.showBackIcon,
    this.showMenuIcon,
    this.centerTitle,
    required this.text,
    this.onPressed,
    this.onMenuPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: AppGlobals.isDarkMode.value? SystemUiOverlayStyle.light: SystemUiOverlayStyle.dark,
      centerTitle: centerTitle,
      backgroundColor: bgColor ?? AppColors.lightColor,
      forceMaterialTransparency: true,
      surfaceTintColor: AppColors.lightColor,
      elevation: 0,
      leadingWidth: 50,
      leading:
          leadingWidget ??
          (showMenuIcon == true
              ? GestureDetector(
                onTap: onMenuPressed,
                child: Container(
                  decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.primary),
                  margin: EdgeInsets.only(left: 8),
                  padding: EdgeInsets.all(10),
                  height: 20,
                  width: 20,
                  child: CustomImageView(svgPath: AppConstants.menuIcon, color: Colors.white),
                ),
              )
              : showBackIcon == true
              ? GestureDetector(
            onTap: ()=>Get.back(),
            child: Container(
              decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.primary),
              margin: EdgeInsets.only(left: 8),
              padding: EdgeInsets.all(10),
              height: 20,
              width: 20,
              child: Icon(CupertinoIcons.chevron_left,color: Colors.white,),
            ),
          )
              : null),
      title: CustomText(text, fontSize: 18, fontWeight: FontWeight.w500),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 56);
}
