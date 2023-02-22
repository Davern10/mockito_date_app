import 'package:flutter/cupertino.dart';
import 'package:mockito_dating_app/ui/utils/colors.dart';
import 'package:mockito_dating_app/ui/routes/routes.dart';
import 'package:mockito_dating_app/ui/utils/responsive.dart';
import 'package:mockito_dating_app/ui/utils/font_styles.dart';

class SocialLogin extends StatelessWidget {
  const SocialLogin({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    final wp = responsive.wp(100);
    final hp = responsive.hp(100);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //? TITLE
        // Text(
        //   "Or via social media",
        //   style: MyFontStyles.subSubtitle.copyWith(fontSize: hp * 0.02),
        // ),

        //? SOCIAL LOGIN BUTTONS
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   children: [
        //     CircleButton(
        //       size: wp * 0.1,
        //       onPressed: () {},
        //       iconPath: "assets/svg/google.svg",
        //     ),
        //     CircleButton(
        //       size: wp * 0.1,
        //       onPressed: () {},
        //       iconPath: "assets/svg/facebook.svg",
        //     ),
        //     CircleButton(
        //       size: wp * 0.1,
        //       onPressed: () {},
        //       iconPath: "assets/svg/instagram.svg",
        //     ),
        //   ],
        // ),

        //? SUBTEXT-BUTTON REGISTER / SING UP
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                //? ASIDE BUTTON SING UP
                Text(
                  "Dont have an account?",
                  style: MyFontStyles.subSubtitle.copyWith(fontSize: hp * 0.02),
                ),
                //? BUTTON SING UP
                CupertinoButton(
                  child: Text(
                    "Sing Up",
                    style: MyFontStyles.subSubtitle.copyWith(
                      color: obscColor2,
                      fontSize: hp * 0.024,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.register);
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
