import '../utilities/app_exports.dart';

class CustomText extends StatelessWidget {
  final String? text;
  final double? fontSize;
  final int? maxLine;
  final Color? color;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;
  final TextStyle? style;

  const CustomText(
    this.text, {
    super.key,
    this.fontSize = 14,
    this.maxLine = 1,
    this.color,
    this.fontWeight = FontWeight.normal,
    this.textAlign,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? "",
      style:
          style ??
          TextStyle(
            color: color ?? AppColors.textPrimary,
            fontWeight: fontWeight ?? FontWeight.normal,
            fontFamily: AppFonts.primary,
            fontSize: fontSize,
            letterSpacing: 0,
          ),
      overflow: TextOverflow.ellipsis,
      maxLines: maxLine,
      softWrap: true,
      textAlign: textAlign ?? TextAlign.start,
    );
  }
}
