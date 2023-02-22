import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mockito_dating_app/ui/utils/colors.dart';
import 'package:mockito_dating_app/ui/utils/responsive.dart';
import 'package:mockito_dating_app/ui/utils/font_styles.dart';
import 'package:mockito_dating_app/ui/pages/register/register_controller.dart';
import 'package:mockito_dating_app/ui/pages/register/widgets/register_form.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    final wp = responsive.wp(100);
    final hp = responsive.hp(100);
    return ChangeNotifierProvider(
      create: (_) => RegisterController(),
      builder: (_, __) {
        // final MediaQueryData data = MediaQuery.of(_);
        // final Size size = data.size;
        // final padding = data.padding;
        return Scaffold(
          extendBodyBehindAppBar: true,
          //? APPBAR
          appBar: AppBar(
            elevation: 0,
            bottomOpacity: 0,
            backgroundColor: invColor,
            leading: IconButton(
              color: primColor,
              icon: Icon(Icons.arrow_back, size: hp * 0.06),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          //? BODY
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SingleChildScrollView(
              child: Container(
                width: wp,
                constraints: BoxConstraints(
                    minHeight:
                        hp), // size.height - padding.top - padding.bottom,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //? REGISTER TEXT CONTENT
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Sing Up!",
                          style:
                              MyFontStyles.titles.copyWith(fontSize: hp * 0.08),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: hp * 0.04),
                          child: Text(
                            "Fill the details & created your account",
                            style: MyFontStyles.subSubtitle
                                .copyWith(fontSize: hp * 0.025),
                          ),
                        ),
                      ],
                    ),
                    //? REGISTER FORM
                    const RegisterForm(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
