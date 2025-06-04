import 'package:path_to_water/utilities/app_exports.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String message;
  final String imageIcon;
  final String btnText;
  final void Function()? onButtonTap;
  const CustomDialog({
    super.key,
    required this.message,
    required this.imageIcon,
    required this.title,
    required this.btnText,
    this.onButtonTap,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
        // side: BorderSide(color: AppColors.strokeColor, width: 2),
      ),

      clipBehavior: Clip.hardEdge,
      backgroundColor: AppColors.dialogBgColor,
      child: Stack(
        clipBehavior: Clip.none, // Allow close button to overflow if needed
        children: [
          Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 150.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    image: DecorationImage(
                      image: AssetImage(
                        AppGlobals.isDarkMode.value
                            ? AppConstants.customDialogBgDarkImage
                            : AppConstants.customDialogBgImage,
                      ),
                      fit: BoxFit.contain,
                    ),
                  ),
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 12.h),
                  child: CustomImageView(imagePath: imageIcon, height: 50.h),
                ),

                8.verticalSpace,
                CustomText(title, fontSize: 20.sp, fontWeight: FontWeight.w600),
                8.verticalSpace,
                CustomText(
                  message,
                  fontWeight: FontWeight.w400,
                  textAlign: TextAlign.center,
                  color: AppGlobals.isDarkMode.value ? AppColors.lightColor : AppColors.grey500,
                  maxLine: 4,
                ),
                12.verticalSpace,
                Row(
                  children: [
                    Expanded(child: CustomRectangleButton(text: btnText, onTap: onButtonTap)),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: 33.h,
            right: 23.h,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(30),
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                  child: Icon(Icons.close, color: Colors.white, size: 20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
