import 'package:flutter/cupertino.dart';
import 'package:mockito_dating_app/ui/utils/colors.dart';
import 'package:mockito_dating_app/ui/utils/responsive.dart';
import 'package:mockito_dating_app/ui/utils/font_styles.dart';

class RoundedButton extends StatelessWidget {
  final Color textColor, backgroundColor, borderColor;
  final VoidCallback? onPressed;
  final FontWeight? fontWeight;
  final EdgeInsets? padding;
  final double? fontSize;
  final String label;
  final bool flWidth;
  const RoundedButton({
    Key? key,
    this.padding,
    this.fontSize,
    this.flWidth = true,
    this.textColor = darkColor1,
    this.borderColor = obscColor2,
    this.backgroundColor = secoColor,
    this.fontWeight = FontWeight.bold,
    required this.onPressed,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    final wp = responsive.wp(100);
    final hp = responsive.hp(100);
    final fontSize = this.fontSize ?? hp * 0.022;
    final padding = this.padding ??
        EdgeInsets.symmetric(
          horizontal: wp * 0.06,
        ).copyWith(
          top: hp * 0.008,
          bottom: hp * 0.010,
        );
    return CupertinoButton(
      //? CHANGE MARGIN BUTTON
      minSize: hp * 0.05,
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      child: Container(
        padding: padding,
        margin: EdgeInsets.zero,
        width: flWidth ? double.maxFinite : null,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: backgroundColor,
          border: Border.all(
            width: wp * 0.006,
            color: borderColor,
          ),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: MyFontStyles.button.copyWith(
            letterSpacing: fontSize / 11,
            fontWeight: fontWeight,
            fontSize: fontSize,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
