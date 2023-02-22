import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mockito_dating_app/models/date_fb_model.dart';
import 'package:mockito_dating_app/ui/utils/colors.dart';
import 'package:mockito_dating_app/ui/utils/responsive.dart';
import 'package:mockito_dating_app/ui/utils/font_styles.dart';
import 'package:mockito_dating_app/data/providers/remote/fb_serv_date_user.dart';
import 'package:mockito_dating_app/ui/utils/string_extension.dart';

class DateFBView extends StatelessWidget {
  const DateFBView({Key? key, required this.dateFB}) : super(key: key);
  final DateFB dateFB;

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    final wp = responsive.wp(100);
    final hp = responsive.hp(100);
    return Scaffold(
      //? APPBAR
      appBar: AppBar(
        title: Text(
          '${DateFormat("dd/MM/yyyy - hh:mm").format(dateFB.beginDate!)} a ${DateFormat("hh:mm a").format(dateFB.endDate!)}',
        ),
      ),
      //? BODY
      body: Container(
        color: invColor,
        height: hp,
        width: wp,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            //? FORMAT VIEW ITEMS FROM FIREBASE
            children: [
              //? PAYMENT FORM
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
                      primColor.withOpacity(0.05),
                      primColor.withOpacity(0.3),
                    ],
                  ),
                ),
                //? TITLE PAYMENT
                header: Text(
                  "Información de cita",
                  style: MyFontStyles.subtitleColor.copyWith(
                    fontWeight: FontWeight.bold,
                    color: obscColor2,
                  ),
                ),
                //? CONTENT PAYMENT
                children: [
                  //? DATE
                  MyFormRow(
                    label: 'Cita :',
                    isButton: false,
                    myIcon: Icons.calendar_month_outlined,
                    labelButton:
                        '${DateFormat("dd/MM/yyyy - hh:mm").format(dateFB.beginDate!)} a ${DateFormat("hh:mm a").format(dateFB.endDate!)}',
                  ),
                  //? ID
                  MyFormRow(
                    label: 'ID :',
                    isButton: false,
                    myIcon: Icons.qr_code_outlined,
                    labelButton: '${dateFB.id}',
                  ),
                  //? EMAIL
                  MyFormRow(
                    label: 'Correo :',
                    isButton: false,
                    myIcon: Icons.email_outlined,
                    labelButton: '${dateFB.email}',
                  ),
                  //? NAME
                  MyFormRow(
                    isButton: false,
                    label: 'Nombre :',
                    myIcon: Icons.person_outline,
                    labelButton:
                        '${dateFB.name.toString().capitalize()} ${dateFB.lastname.toString().capitalize()}',
                  ),
                  //? NUMBER
                  MyFormRow(
                    isButton: false,
                    label: 'Telefono :',
                    myIcon: Icons.phone_android_outlined,
                    labelButton: '${dateFB.number}',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
