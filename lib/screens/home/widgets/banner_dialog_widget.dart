import 'package:path_to_water/utilities/app_exports.dart';

class BannerDialogWidget extends StatelessWidget {
  final String? url;
  const BannerDialogWidget({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
        side: BorderSide(color: AppColors.strokeColor, width: 2),
      ),

      clipBehavior: Clip.hardEdge,
      backgroundColor: Colors.transparent,
      child: Stack(
        clipBehavior: Clip.none, // Allow close button to overflow if needed
        children: [
          SizedBox(
            height: 470.h,
            child: CustomImageView(
              url: url,
              fit: BoxFit.fill,
              placeHolderWidget: SizedBox.shrink(),
            ),
          ),
          Positioned(
            top: 14.h,
            right: 14.h,
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
