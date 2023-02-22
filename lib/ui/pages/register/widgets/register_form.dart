import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mockito_dating_app/ui/routes/routes.dart';
import 'package:mockito_dating_app/ui/utils/dialogs.dart';
import 'package:mockito_dating_app/ui/utils/responsive.dart';
import 'package:mockito_dating_app/ui/global_widgets/input_text.dart';
import 'package:mockito_dating_app/ui/global_widgets/custom_form.dart';
import 'package:mockito_dating_app/ui/global_widgets/rounded_button.dart';
import 'package:mockito_dating_app/ui/pages/register/register_controller.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({Key? key}) : super(key: key);

  //? SUBMIT FUNCTIONS & VALIDATES OF REGISTER
  void _submit(BuildContext context) async {
    final controller = context.read<RegisterController>();
    final isFormOk = controller.formKey.currentState!.validate();

    if (isFormOk!) {
      ProgressDialog.show(context);
      final isOk = await controller.submit();
      Navigator.pop(context);

      if (!isOk!) {
        Dialogs.alert(
          context,
          title: 'ERROR',
          description: 'Register Failed',
        );
      } else {
        await Dialogs.alert(
          context,
          title: 'GOOD',
          dismissible: false,
          description: 'Register Successful',
        );
        Navigator.popUntil(
            context,
            ((R) =>
                R.settings.name == Routes.welcome ||
                R.settings.name == Routes.login));
      }
    } else {
      Dialogs.alert(
        context,
        title: 'ERROR',
        description: 'Invalid Inputs, please confirm',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<RegisterController>();
    final responsive = Responsive.of(context);
    final wp = responsive.wp(100);
    final hp = responsive.hp(100);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: wp * 0.05),
      child: CustomForm(
        key: controller.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //? INPUT NAME
            InputText(
              label: "Name",
              suffixIcon: true,
              key: const Key('register-name'),
              onChanged: controller.onNameChanged,
              textInputAction: TextInputAction.next,
              prefixIcon: Icons.person_outline,
              validator: (text) {
                return (text.trim().length > 1) ? null : "Invalid Name";
              },
            ),
            //? INPUT LASTNAME
            InputText(
              suffixIcon: true,
              label: "Last Name",
              key: const Key('register-lastname'),
              textInputAction: TextInputAction.next,
              onChanged: controller.onlastnameChanged,
              prefixIcon: Icons.person_add_alt_1_outlined,
              validator: (text) {
                return (text.trim().length > 1) ? null : "Invalid Last Name";
              },
            ),
            //? INPUT NUMBER
            InputText(
              suffixIcon: true,
              label: "Number",
              key: const Key('register-number'),
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              onChanged: controller.onNumberChanged,
              prefixIcon: Icons.phone_android_outlined,
              validator: (text) {
                return (text.trim().length >= 10) ? null : "Invalid Number";
              },
            ),
            //? INPUT E-MAIL
            InputText(
              label: "E-mail",
              suffixIcon: true,
              key: const Key('register-email'),
              onChanged: controller.onEmailChanged,
              textInputAction: TextInputAction.next,
              prefixIcon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              validator: (text) {
                return (text.contains("@") && text.endsWith(".com"))
                    ? null
                    : "Invalid E-mail";
              },
            ),
            //? INPUT PASSWORD
            InputText(
              suffixIcon: true,
              obscureText: true,
              label: "Password",
              key: const Key('register-password'),
              textInputAction: TextInputAction.send,
              onChanged: controller.onPasswordChanged,
              onSubmitted: (text) => _submit(context),
              prefixIcon: Icons.lock_open_outlined,
              validator: (text) {
                return (text.trim().length > 3) ? null : "Invalid Password";
              },
            ),
            //? BUTTON SEND
            Padding(
              padding: EdgeInsets.only(top: hp * 0.02),
              child: Align(
                alignment: Alignment.bottomRight,
                child: RoundedButton(
                  fontSize: hp * 0.024,
                  label: "Sing Up",
                  flWidth: false,
                  onPressed: () {
                    _submit(context);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
