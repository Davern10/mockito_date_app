import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'forgot_passwprd_controller.dart';
import 'widgets/forgot_password_form.dart';
import 'package:mockito_dating_app/ui/utils/colors.dart';
import 'package:mockito_dating_app/ui/utils/responsive.dart';
import 'package:mockito_dating_app/ui/utils/font_styles.dart';
import 'package:mockito_dating_app/ui/utils/app/app_utils.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    final wp = responsive.wp(100);
    final hp = responsive.hp(100);
    return ChangeNotifierProvider<ForgotPasswordController>(
        create: (_) => ForgotPasswordController(),
        builder: (_, __) {
          //? APPBAR
          final AppBar appBar = AppBar(
            backgroundColor: invColor,
            bottomOpacity: 0,
            elevation: 0,
            leading: IconButton(
              color: primColor,
              icon: Icon(Icons.arrow_back, size: hp * 0.06),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          );
          // final data = MediaQuery.of(_);
          // final padding = data.padding;
          // final size = data.size;
          return Scaffold(
            extendBodyBehindAppBar: true,
            //? CALL APPBAR
            appBar: appBar,
            //? BODY
            body: SingleChildScrollView(
              child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Container(
                  alignment: Alignment.center,
                  color: invColor,
                  height: hp,
                  width: wp,
                  // height: size.height - padding.top - padding.bottom - (appBar.preferredSize.height),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //? TITLE
                      Text(
                        "Forgot your password!",
                        style: MyFontStyles.titles.copyWith(
                          fontSize: hp * 0.07,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      //? SUBTITLE
                      Padding(
                        padding: EdgeInsets.only(
                          top: hp * 0.015,
                        ),
                        child: Text(
                          "Fill the details & created your account",
                          style: MyFontStyles.subSubtitle,
                        ),
                      ),
                      //? IMAGE
                      Padding(
                        padding: EdgeInsets.only(
                          top: hp * 0.04,
                          bottom: hp * 0.04,
                        ),
                        child: AppUtils.isHtml
                            ? Image.network(
                                "assets/svg/login.svg",
                                width: hp * 0.4,
                              )
                            : SvgPicture.asset(
                                "assets/svg/login.svg",
                                width: hp * 0.3,
                              ),
                      ),
                      //? FORGOT PASS FORM
                      const ForgotPasswordForm(),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
