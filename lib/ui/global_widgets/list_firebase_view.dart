import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:mockito_dating_app/helpers/get.dart';
import 'package:mockito_dating_app/models/date_fb_model.dart';
import 'package:mockito_dating_app/models/user_model.dart';
import 'package:mockito_dating_app/ui/global_widgets/circular_progress.dart';
import 'package:mockito_dating_app/ui/global_widgets/on_error_list.dart';
import 'package:mockito_dating_app/ui/utils/colors.dart';
import 'package:mockito_dating_app/ui/utils/responsive.dart';
import 'package:mockito_dating_app/data/providers/remote/fb_serv_date_user.dart';
import 'package:mockito_dating_app/ui/utils/string_extension.dart';
import 'package:mockito_dating_app/ui/global_widgets/view_item_fb.dart';

class DateListFBPage extends StatelessWidget {
  const DateListFBPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    final user = Get.i.find<UserModel>();
    final fireBase = FBServices();
    final wp = responsive.wp(100);
    final hp = responsive.hp(100);
    return Container(
      color: invColor,
      height: hp,
      width: wp,
      child: Center(
        child: FutureBuilder<List<DateFB>?>(
          future: fireBase.getDateData(),
          builder:
              (BuildContext context, AsyncSnapshot<List<DateFB>?> snapshot) {
            if (snapshot.hasError) {
              //? ERROR FROM FIREBASE OR FLUTTER
              return OnErrorCharge(hp: hp, wp: wp, snapshot: snapshot.error);
            }
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                //? CIRCULAR PROGRESS INDICATOR
                return CircularProgress(hp: hp, wp: wp);
              default:
                //? LIST ITEMS FIREBASE
                final itemsFB = snapshot.data as List<DateFB>;
                return Container(
                  color: invColor,
                  height: hp,
                  width: wp,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: itemsFB.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      return itemsFB[index].beginDate!.isAfter(DateTime.now())
                          ? Container(
                              width: wp,
                              margin: EdgeInsets.only(top: hp * 0.011),
                              padding: EdgeInsets.all(wp * 0.005),
                              decoration: BoxDecoration(
                                color: primColor.withOpacity(0.22),
                                borderRadius: BorderRadius.circular(wp * 0.06),
                                border: Border.all(
                                  width: wp * 0.008,
                                  color: darkColor1.withOpacity(0.44),
                                ),
                              ),
                              child: ListTile(
                                //? TITLE NAME
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const MyIcon(icon: Icons.person_outline),
                                    MyText(
                                      text:
                                          '${itemsFB[index].name.toString().capitalize()} ${itemsFB[index].lastname.toString().capitalize()}',
                                    ),
                                  ],
                                ),
                                //? SUBTITLE DATE
                                subtitle: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const MyIcon(
                                        icon: Icons.calendar_month_outlined),
                                    MyText(
                                      text:
                                          '${DateFormat("dd/MM/yyyy - hh:mm").format(itemsFB[index].beginDate!)} a ${DateFormat("hh:mm a").format(itemsFB[index].endDate!)}',
                                    ),
                                  ],
                                ),
                                //? LEADING 4 DIG.CODE
                                leading: MyText(
                                  text:
                                      '${itemsFB[index].id.toString().substring(0, 4).toUpperCase()}\n${itemsFB[index].id.toString().substring(itemsFB[index].id.length - 4, itemsFB[index].id.length).toUpperCase()}',
                                ),
                                //? ON PRESS DATE
                                onTap: () {
                                  try {
                                    if (user.email == itemsFB[index].email) {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => DateFBView(
                                            dateFB: itemsFB[index],
                                          ),
                                        ),
                                      );
                                    }
                                  } catch (e) {
                                    debugPrint('Error: $e');
                                  }
                                },
                              ),
                            )
                          : const SizedBox(height: 0, width: 0);
                    },
                  ),
                );
            }
          },
        ),
      ),
    );
  }
}
