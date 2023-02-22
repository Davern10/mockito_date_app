import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:mockito_dating_app/helpers/get.dart';
import 'package:mockito_dating_app/models/user_model.dart';
import 'package:mockito_dating_app/ui/routes/routes.dart';
import 'package:mockito_dating_app/ui/utils/dialogs.dart';
import 'package:mockito_dating_app/ui/utils/responsive.dart';
import 'package:mockito_dating_app/ui/utils/font_styles.dart';
import 'package:mockito_dating_app/ui/global_widgets/input_text.dart';
import 'package:mockito_dating_app/ui/pages/login/login_controller.dart';
import 'package:mockito_dating_app/ui/global_widgets/rounded_button.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  //? SUBMIT LOGIN SEND FUNCTION / MESSAGE
  void _submit(BuildContext context) async {
    final controller = context.read<LoginController>();
    ProgressDialog.show(context);

    final UserModel? user = await controller.submit();
    Navigator.pop(context);

    if (user == null) {
      Dialogs.alert(
        context,
        title: 'ERROR',
        description: 'Invalid Email or Password, please confirm',
      );
    } else {
      Get.i.put<UserModel>(user);
      Navigator.pushNamedAndRemoveUntil(
        context,
        Routes.home,
        (_) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<LoginController>(context, listen: false);
    final responsive = Responsive.of(context);
    final wp = responsive.wp(100);
    final hp = responsive.hp(100);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          children: [
            //? INPUT E-MAIL
            InputText(
              label: "E-mail",
              suffixIcon: true,
              inputSize: hp * 0.022,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              prefixIcon: Icons.email_outlined,
              validator: (text) {
                return (text.contains("@") && text.endsWith(".com"))
                    ? null
                    : 'Invalid E-mail';
              },
              onChanged: controller.onEmailChanged,
            ),
            //? INPUT PASSWORD
            InputText(
              label: "Password",
              suffixIcon: true,
              obscureText: true,
              inputSize: hp * 0.025,
              textInputAction: TextInputAction.send,
              onSubmitted: (text) => _submit(context),
              onChanged: controller.onPasswordChanged,
              prefixIcon: Icons.lock_open_outlined,
              validator: (text) {
                return (text.trim().length > 3) ? null : 'Invalid Password';
              },
            ),
            //? FORGOT PAGE BUTTON
            Align(
              alignment: Alignment.centerRight,
              child: CupertinoButton(
                child: Text(
                  "Forgot your password",
                  style: MyFontStyles.subtitleColor.copyWith(
                    fontSize: hp * 0.024,
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, Routes.forgotPassword);
                },
              ),
            ),
          ],
        ),
        //? LOGIN BUTTON
        RoundedButton(
          label: "Login",
          fontSize: hp * 0.028,
          flWidth: false,
          onPressed: () {
            _submit(context);
          },
        ),
      ],
    );
  }
}
