import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mockito_dating_app/ui/utils/colors.dart';
import 'package:mockito_dating_app/ui/utils/responsive.dart';
import 'package:mockito_dating_app/ui/utils/font_styles.dart';
import 'package:mockito_dating_app/ui/utils/app/app_utils.dart';
import 'package:mockito_dating_app/ui/global_widgets/circle_bg.dart';
import 'package:mockito_dating_app/ui/pages/login/login_controller.dart';
import 'package:mockito_dating_app/ui/pages/login/widgets/login_form.dart';
import 'package:mockito_dating_app/ui/pages/login/widgets/social_login.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    final circle1 = responsive.hp(44);
    final circle2 = responsive.hp(33);
    final wp = responsive.wp(100);
    final hp = responsive.hp(100);
    return ChangeNotifierProvider<LoginController>(
        create: (_) => LoginController(),
        builder: (_, __) {
          return Scaffold(
            body: SingleChildScrollView(
              child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Container(
                  color: Colors.transparent,
                  height: hp,
                  width: wp,
                  child: Stack(
                    children: <Widget>[
                      //? BACKGROUND CIRCLES
                      CirclesBG(
                        begin: FractionalOffset.bottomCenter,
                        end: FractionalOffset.topCenter,
                        right: 0 - circle1 * 0.22,
                        top: 0 - circle1 * 0.33,
                        color: primColor,
                        cSize: circle1,
                      ),
                      CirclesBG(
                        end: FractionalOffset.bottomCenter,
                        begin: FractionalOffset.topCenter,
                        bottom: 0 - circle1 * 0.33,
                        left: 0 - circle1 * 0.22,
                        color: primColor,
                        cSize: circle1,
                      ),
                      CirclesBG(
                        begin: FractionalOffset.bottomCenter,
                        end: FractionalOffset.topCenter,
                        left: 0 - circle2 * 0.1,
                        top: 0 - circle2 * 0.44,
                        color: darkColor1,
                        cSize: circle2,
                      ),
                      CirclesBG(
                        end: FractionalOffset.bottomCenter,
                        begin: FractionalOffset.topCenter,
                        right: 0 - circle2 * 0.1,
                        bottom: 0 - circle2 * 0.44,
                        color: darkColor1,
                        cSize: circle2,
                      ),
                      //? LOGIN CONTENT
                      SafeArea(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //? TITLE
                            Container(
                              height: hp * 0.15,
                              padding: EdgeInsets.symmetric(
                                horizontal: wp * 0.05,
                              ),
                              //? TITLE TEXT
                              child: Text(
                                "Welcome Back!",
                                textAlign: TextAlign.center,
                                style: MyFontStyles.titles.copyWith(
                                  fontSize: hp * 0.1,
                                ),
                              ),
                            ),
                            //? IMAGE
                            SizedBox(
                              height: hp * 0.22,
                              child: Center(
                                child: AppUtils.isHtml
                                    ? Image.network(
                                        "assets/svg/login.svg",
                                      )
                                    : SvgPicture.asset(
                                        "assets/svg/login.svg",
                                      ),
                              ),
                            ),
                            //? LOGIN FORM
                            Container(
                              height: hp * 0.33,
                              padding: EdgeInsets.symmetric(
                                horizontal: wp * 0.08,
                              ),
                              child: const LoginForm(),
                            ),
                            //? SOCIAL LOGIN BUTTONS
                            Container(
                              height: hp * 0.15,
                              padding: EdgeInsets.symmetric(
                                horizontal: wp * 0.08,
                              ),
                              child: const SocialLogin(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}

class CirclesBG extends StatelessWidget {
  CirclesBG({
    Key? key,
    this.top,
    this.end,
    this.left,
    this.begin,
    this.right,
    this.bottom,
    required this.color,
    required this.cSize,
  }) : super(key: key);

  double? top, left, right, cSize, bottom;
  FractionalOffset? end, begin;
  Color color;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: bottom,
      right: right,
      left: left,
      top: top,
      child: Circle(
        size: cSize as double,
        begin: begin,
        end: end,
        colors: [
          color,
          color.withOpacity(0.55),
          color.withOpacity(0.33),
        ],
      ),
    );
  }
}
