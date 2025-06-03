

import '../utilities/app_exports.dart';

class ThemeSwitcher extends StatefulWidget {
  final bool initialThemeIsDark;
  final ValueChanged<bool>? onChanged; // Added callback for theme change

  const ThemeSwitcher({
    super.key,
    required this.initialThemeIsDark,
    this.onChanged, // Initialize the callback
  });

  @override
  State<ThemeSwitcher> createState() => _ThemeSwitcherState();
}

class _ThemeSwitcherState extends State<ThemeSwitcher> {
  late bool _isDarkMode;

  @override
  void initState() {
    super.initState();
    _isDarkMode = widget.initialThemeIsDark;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isDarkMode = !_isDarkMode;
          // Call the onChanged callback
          widget.onChanged?.call(_isDarkMode);
          log("Theme is now ${_isDarkMode ? 'dark' : 'light'}");
        });
      },
      child: Container(
        width: 100,
        height: 43,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: const Color(0xffE5E7EB),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              left: _isDarkMode ? 45 : 0,
              top: 0,
              bottom: 0,
              child: Container(
                width: 45,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SvgPicture.asset(AppConstants.light),
                SvgPicture.asset(AppConstants.dark),
              ],
            ),
          ],
        ),
      ),
    );
  }
}