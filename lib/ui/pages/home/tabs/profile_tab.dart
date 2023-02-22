import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mockito_dating_app/helpers/get.dart';
import 'package:mockito_dating_app/models/user_model.dart';
import 'package:mockito_dating_app/ui/utils/colors.dart';
import 'package:mockito_dating_app/ui/utils/dialogs.dart';
import 'package:mockito_dating_app/ui/routes/routes.dart';
import 'package:mockito_dating_app/ui/utils/responsive.dart';
import 'package:mockito_dating_app/ui/utils/font_styles.dart';
import 'package:mockito_dating_app/data/providers/remote/fb_serv_date_user.dart';
import 'package:mockito_dating_app/ui/utils/string_extension.dart';
import 'package:mockito_dating_app/data/repositories/auth_repository.dart';
import 'package:mockito_dating_app/data/repositories/preferences_repository.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({Key? key}) : super(key: key);

  //? SING OUT FUNCTION
  void _signOut(BuildContext context) async {
    final isOk = await Dialogs.confirm(context, title: "ACTION REQUIRED");
    if (isOk) {
      Get.i.remove<UserModel>();
      await Get.i.find<AuthRepository>().signOut();
      await Get.i.find<PrefsRepository>().setOnboardAndWelcomeReady(false);
      Navigator.pushNamedAndRemoveUntil(context, Routes.login, (_) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    final user = Get.i.find<UserModel>();
    final wp = responsive.wp(100);
    final hp = responsive.hp(100);
    return Center(
      child: Container(
        color: invColor,
        height: hp,
        width: wp,
        child: ListView(
          children: [
            //? CIRCLE AVATAR
            Align(
              child: ClipOval(
                child: Image.asset(
                  width: hp * 0.1,
                  height: hp * 0.1,
                  fit: BoxFit.cover,
                  'assets/images/cute_smile.png',
                ),
                // CachedNetworkImage(
                //   width: 22 * 5,
                //   height: 22 * 5,
                //   fit: BoxFit.cover,
                //   imageUrl:
                //       "https://cdn-icons-png.flaticon.com/512/2922/2922558.png",
                // ),
              ),
            ),
            //? USER DATA FORM
            CupertinoFormSection.insetGrouped(
              margin: const EdgeInsets.all(10).copyWith(top: 5),
              backgroundColor: invColor,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  // stops: [0.2, 0.6, 0.9],
                  end: Alignment.centerRight,
                  begin: Alignment.centerLeft,
                  colors: [
                    primColor.withOpacity(0.1),
                    primColor.withOpacity(0.3),
                  ],
                ),
              ),
              //? TITLE USER INFO
              header: Text(
                "Información Personal",
                style: MyFontStyles.subtitleColor.copyWith(
                  fontWeight: FontWeight.bold,
                  color: obscColor2,
                ),
              ),
              children: [
                //? USER ID FORM
                MyFormRow(
                  label: 'ID :',
                  myIcon: Icons.qr_code_outlined,
                  isButton: false,
                  labelButton: user.id ?? 'NOT DATA',
                ),
                //? USER EMAIL FORM
                MyFormRow(
                  label: 'Correo :',
                  myIcon: Icons.email_outlined,
                  isButton: false,
                  labelButton: user.email ?? 'NOT DATA',
                ),
                //? USER NAME FORM
                MyFormRow(
                  label: 'Nombre :',
                  myIcon: Icons.person_outline,
                  isButton: false,
                  labelButton:
                      '${user.name.toString().capitalize()} ${user.lastname.toString().capitalize()}',
                ),
                //? USER NUMBER FORM
                MyFormRow(
                  label: 'Telefono :',
                  myIcon: Icons.phone_android_outlined,
                  isButton: false,
                  labelButton: user.number ?? 'NOT DATA',
                ),
              ],
            ),
            //? MY ACCOUNT FORM
            CupertinoFormSection.insetGrouped(
              margin: const EdgeInsets.all(10).copyWith(top: 5),
              backgroundColor: invColor,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  // stops: [0.2, 0.6, 0.9],
                  end: Alignment.centerRight,
                  begin: Alignment.centerLeft,
                  colors: [
                    primColor.withOpacity(0.1),
                    primColor.withOpacity(0.3),
                  ],
                ),
              ),
              //? TITLE ACCOUNT
              header: Text(
                "Cuenta & Sesion",
                style: MyFontStyles.subtitleColor.copyWith(
                  fontWeight: FontWeight.bold,
                  color: obscColor2,
                ),
              ),
              //? CONTENT
              children: [
                //? DELETE ACCOUNT BUTTON
                MyFormRow(
                  label: 'Cancelar Cuenta :',
                  isButton: true,
                  onPressed: () {},
                  labelButton: 'Delete',
                  myIcon: Icons.delete_forever_outlined,
                  style: MyFontStyles.subSubtitle.copyWith(
                    color: darkColor1.withOpacity(0.88),
                    fontWeight: FontWeight.bold,
                    letterSpacing: wp * 0.003,
                  ),
                ),
                //? SING OUT BUTTON
                MyFormRow(
                  label: 'Cerrar Sesion :',
                  isButton: true,
                  onPressed: () => _signOut(context),
                  labelButton: 'Sign Out',
                  myIcon: Icons.power_settings_new,
                  style: MyFontStyles.subSubtitle.copyWith(
                    fontWeight: FontWeight.bold,
                    letterSpacing: wp * 0.003,
                    color: darkColor1,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
