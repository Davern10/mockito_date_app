import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mockito_dating_app/ui/utils/dialogs.dart';
import 'package:mockito_dating_app/ui/utils/responsive.dart';
import 'package:mockito_dating_app/ui/global_widgets/input_text.dart';
import 'package:mockito_dating_app/ui/global_widgets/rounded_button.dart';
import 'package:mockito_dating_app/ui/pages/forgot_password/forgot_passwprd_controller.dart';

class ForgotPasswordForm extends StatelessWidget {
  const ForgotPasswordForm({Key? key}) : super(key: key);

  //? SUBMIT FORGOT PASS FORM
  void _submit(BuildContext context) async {
    ProgressDialog.show(context);
    Navigator.pop(context);

    final controller = context.read<ForgotPasswordController>();
    final sent = await controller.submit();

    if (sent) {
      await Dialogs.alert(
        context,
        title: "GOOD",
        dismissible: false,
        description: "We have sent an email ${controller.email}",
        okText: 'Go To Login',
      );
      Navigator.pop(context);
    } else {
      Dialogs.alert(
        context,
        title: "ERROR",
        key: const Key('Invalid Email'),
        description: "${controller.email} not found, please rewrite the Email",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ForgotPasswordController>();
    final responsive = Responsive.of(context);
    final wp = responsive.wp(100);
    final hp = responsive.hp(100);
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: wp * 0.9),
      child: Column(
        children: [
          //? INPUT E-MAIL
          InputText(
            label: "E-mail",
            suffixIcon: true,
            inputSize: hp * 0.03,
            textInputAction: TextInputAction.send,
            onSubmitted: (text) => _submit(context),
            keyboardType: TextInputType.emailAddress,
            prefixIcon: Icons.email_outlined,
            validator: (text) {
              return (text.contains("@") && text.endsWith(".com"))
                  ? null
                  : 'Invalid E-mail';
            },
            onChanged: controller.onEmailChanged,
          ),
          //? BUTTON SEND
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(top: hp * 0.03, right: wp * 0.03),
              child: RoundedButton(
                fontSize: hp * 0.026,
                label: "Recover",
                flWidth: false,
                onPressed: () {
                  _submit(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
