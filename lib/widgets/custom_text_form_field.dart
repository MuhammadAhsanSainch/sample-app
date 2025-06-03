import '../utilities/app_exports.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final EdgeInsetsGeometry? outerPadding;
  final Widget? prefixIcon;
  final String upperLabel;
  final String upperLabelReqStar;
  final String hintValue;
  final String? Function(String?)? validator;
  final TextInputType type;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;
  final bool obscureText;
  final bool enableInteractiveSelection;
  final bool enableSuggestions;
  final int? maxLength;
  const CustomTextFormField({
    super.key,
    required this.controller,
    this.outerPadding,
    this.prefixIcon,
    required this.upperLabel,
    required this.upperLabelReqStar,
    required this.hintValue,
    this.validator,
    required this.type,
    this.inputFormatters,
    this.onChanged,
    this.obscureText = false, // Default to not obscure
    this.enableInteractiveSelection = true, // Default to true
    this.enableSuggestions = true, // Default to true
    this.maxLength,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool obscureText;

  @override
  void initState() {
    super.initState();
    obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    bool isTablet = Get.context?.isTablet ?? false;
    return Padding(
      padding: widget.outerPadding ??  EdgeInsets.only(left: 2.0.w, top: 10.h),
      child: Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomText(widget.upperLabel,style: AppTextTheme.bodyLarge,fontSize: isTablet ? 0.5 : 1,),
              CustomText(
                widget.upperLabelReqStar,
                color: Colors.red,
                style: AppTextTheme.bodyLarge,
                fontSize: isTablet ? 0.5 : 1,
              ),
            ],
          ),
          TextFormField(
            controller: widget.controller,
            obscureText: obscureText,
            obscuringCharacter: '*',
            keyboardType: widget.type,
            inputFormatters: widget.inputFormatters,
            validator: widget.validator,
            onChanged: widget.onChanged,
            enableInteractiveSelection: widget.enableInteractiveSelection,
            enableSuggestions: widget.enableSuggestions,
            maxLength: widget.maxLength,
            style: TextStyle(fontSize: isTablet ? 20 : 18,color: AppColors.primary,fontFamily: AppFonts.primary),
            decoration: InputDecoration(
              prefixIconConstraints: BoxConstraints(minWidth: 50),
              hintText: widget.hintValue,
              hintStyle: TextStyle(fontSize: isTablet ? 20 : 18,color: AppColors.borderDark,fontFamily: AppFonts.primary),
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: widget.prefixIcon,
              ),
              suffixIcon: (widget.obscureText)
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          obscureText = !obscureText;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.only(right:  20.0),
                        child: SvgPicture.asset(
                          obscureText ? AppConstants.eyeSlash : AppConstants.eye,
                        ),
                      ),
                    )
                  : null,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                      50)), // You can customize the border
            ),
          ),
        ],
      ),
    );
  }
}
