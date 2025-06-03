import '../utilities/app_exports.dart';

class CustomBottomBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const CustomBottomBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final images = [
      AppConstants.mail,
      AppConstants.mail,
      AppConstants.mail,
      AppConstants.mail,
    ];

    final labels = [
      'Appointments',
      'Sales',
      'Employees',
      'Messages',
    ];

    return SizedBox(
      height: 70,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          // Background bar
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: Colors.black12)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  for (int i = 0; i < 2; i++)
                    _buildNavItem(
                      image: images[i],
                      label: labels[i],
                      isSelected: selectedIndex == i,
                      onTap: () => onTap(i),
                    ),
                  const SizedBox(width: 65), // Leave space for Home button
                  for (int i = 2; i < 4; i++)
                    _buildNavItem(
                      image: images[i],
                      label: labels[i],
                      isSelected:
                          selectedIndex == i + 1, // shift index for home
                      onTap: () => onTap(i + 1),
                    ),
                ],
              ),
            ),
          ),

          // Floating Home button (Always brown)
          Positioned(
            top: -25,
            child: GestureDetector(
              onTap: () => onTap(2),
              child: Column(
                children: [
                  Container(
                    height: 65,
                    width: 65,
                    decoration: BoxDecoration(
                      color: AppColors.secondary, // always brown
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        AppConstants.mail,
                        width: 24,
                        height: 24,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required String image,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            image,
            width: 20,
            height: 20,
            colorFilter: ColorFilter.mode(isSelected ? AppColors.secondary : AppColors.secondary, BlendMode.srcIn),
          ),
          // Image.asset(
          //   image,
          //   width: 20,
          //   height: 20,
          //   color: isSelected
          //       ? AppTheme.secondaryColor
          //       : AppTheme.darkColor, // brown if selected, grey otherwise
          // ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: isSelected
                  ? AppColors.primary
                  : AppColors.primary, // brown if selected, grey otherwise
            ),
          ),
        ],
      ),
    );
  }
}
