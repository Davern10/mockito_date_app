import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:mockito_dating_app/models/date_fb_model.dart';
import 'package:mockito_dating_app/ui/global_widgets/circular_progress.dart';
import 'package:mockito_dating_app/ui/global_widgets/on_error_list.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:mockito_dating_app/helpers/get.dart';
import 'package:mockito_dating_app/ui/utils/colors.dart';
import 'package:mockito_dating_app/ui/utils/dialogs.dart';
import 'package:mockito_dating_app/ui/routes/routes.dart';
import 'package:mockito_dating_app/models/user_model.dart';
import 'package:mockito_dating_app/ui/utils/responsive.dart';
import 'package:mockito_dating_app/ui/utils/font_styles.dart';
import 'package:mockito_dating_app/data/providers/remote/fb_serv_date_user.dart';
import 'package:mockito_dating_app/ui/utils/string_extension.dart';
import 'package:mockito_dating_app/ui/pages/date/date_controller.dart';
import 'package:mockito_dating_app/ui/global_widgets/view_item_fb.dart';
import 'package:mockito_dating_app/ui/pages/date/widgets/files_page.dart';
import 'package:mockito_dating_app/ui/global_widgets/rounded_button.dart';

class DatePage extends StatefulWidget {
  const DatePage({Key? key}) : super(key: key);

  @override
  State<DatePage> createState() => _DatePageState();
}

class _DatePageState extends State<DatePage> {
  @override
  Widget build(BuildContext context) {
    // TODO ROUTER WITH USE OF ARGMTS FROM ROUTER
    final arguments = ModalRoute.of(context)?.settings.arguments as Map;
    final dateCtrl = DateController(context: context);
    final responsive = Responsive.of(context);
    final dateInit = dateCtrl.initialDate;
    final dateTime = dateCtrl.timePicker;
    final user = Get.i.find<UserModel>();
    final wp = responsive.wp(100);
    final hp = responsive.hp(100);

    DateFB dateFB = DateFB();
    FBServices fireBase = FBServices();
    return ChangeNotifierProvider.value(
      value: dateCtrl,
      child: Consumer<DateController>(
        builder: (_, __, ___) {
          return Scaffold(
            resizeToAvoidBottomInset: true,
            body: SafeArea(
              child: Container(
                width: wp,
                height: hp,
                padding: EdgeInsets.symmetric(horizontal: wp * 0.03),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: GestureDetector(
                    onTap: () => FocusScope.of(context).unfocus(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //? TITLE / DATE & HOUR / BUTTON BACK
                        DatePageHeader(wp: wp, hp: hp, dateCtrl: dateCtrl),
                        //? CALENDAR DATE
                        SizedBox(
                          height: hp * 0.3,
                          child: CalendarDatePicker(
                            initialDate: dateInit,
                            currentDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(9999),
                            onDateChanged: (value) async {
                              dateCtrl.dateChange = value;
                            },
                          ),
                        ),
                        //? IMAGE / DESCRIPTION
                        Container(
                          padding: EdgeInsets.symmetric(vertical: hp * 0.02),
                          width: wp,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              //? IMAGE
                              Padding(
                                padding: EdgeInsets.only(right: wp * 0.04),
                                child: Image.network(
                                  arguments['url'],
                                  width: (wp * 0.25),
                                  fit: BoxFit.contain,
                                ),
                              ),
                              //? DESCRIPTION
                              Expanded(
                                child: Text(
                                  'Hola ${user.name.toString().capitalize()} por favor, '
                                  'escoge la fecha y hora de preferencia para tu cita, '
                                  '${arguments['name']} saludos.',
                                  maxLines: 5,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.6),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        //? TIME / ASSETS / SAVE - BUTTONS
                        ButtonBar(
                          alignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                //? PICKTIME BUTTON
                                TextButton.icon(
                                  label: const Text("Hora"),
                                  icon: Icon(
                                    Icons.punch_clock,
                                    size: wp * 0.05,
                                  ),
                                  onPressed: () {
                                    dateCtrl.pickTime();
                                  },
                                ),
                                //? ASSETS PICKFILE'S BUTTON
                                TextButton.icon(
                                  label: const Text("Assets"),
                                  icon: Icon(
                                    Icons.attach_file_sharp,
                                    size: wp * 0.05,
                                  ),
                                  onPressed: () async {
                                    // TODO SELECT FILE'S ASSETS FROM DEVICE
                                    // final result  = await FilePicker.platform.pickFiles();
                                    // final result = await FilePicker.platform.pickFiles(allowMultiple: true);
                                    // final result = await FilePicker.platform.pickFiles(
                                    //   allowMultiple: true,
                                    //   type: FileType.custom,
                                    //   allowedExtensions: ['pdf', 'mp4'],
                                    // );
                                    final result = await FilePicker.platform
                                        .pickFiles(
                                            allowMultiple: true,
                                            type: FileType.image);
                                    if (result == null) return;
                                    openFiles(result.files);
                                    // final file = result.files.first;
                                    // openFile(file);
                                    // debugPrint('FILE ${file.name}');
                                    // debugPrint('FILE ${file.size}');
                                    // debugPrint('FILE ${file.path}');
                                    // debugPrint('FILE ${file.bytes}');
                                    // debugPrint('FILE ${file.extension}');
                                    // final newFile = await saveFilePermanently(file);
                                    // debugPrint('From Path: ${file.path}');
                                    // debugPrint('to Path: ${newFile.path}');
                                  },
                                ),
                                //? SAVE DATE BUTTON
                                TextButton.icon(
                                  label: const Text('Save Date'),
                                  icon: Icon(
                                    Icons.save_alt_sharp,
                                    size: wp * 0.05,
                                  ),
                                  onPressed: () async {
                                    String message = '';
                                    dateFB.name = user.name;
                                    dateFB.email = user.email;
                                    dateFB.number = user.number;
                                    dateFB.lastname = user.lastname;
                                    dateFB.beginDate = DateTime(
                                      dateInit.year,
                                      dateInit.month,
                                      dateInit.day,
                                      dateTime.hour,
                                      dateTime.minute * 0,
                                      0,
                                      0,
                                      0,
                                    );
                                    dateFB.endDate = DateTime(
                                      dateInit.year,
                                      dateInit.month,
                                      dateInit.day,
                                      dateTime.hour + 1,
                                      dateTime.minute * 0,
                                      0,
                                      0,
                                      0,
                                    );

                                    //? VALIDAR SI FECHA EXISTE?
                                    final fechaOcupada =
                                        await fireBase.getUserDateExist(
                                      DateTime(
                                        dateInit.year,
                                        dateInit.month,
                                        dateInit.day,
                                        dateTime.hour,
                                        dateTime.minute * 0,
                                      ),
                                    );

                                    //? EN CASO DE NO ESTAR OCUPADA LA HORA CREAR CITA
                                    if (!fechaOcupada) {
                                      try {
                                        await fireBase.createDateData(dateFB);
                                        // setState(() async {
                                        dateFB = DateFB();
                                        // });
                                        message =
                                            'Cita registrada exitosamente.';
                                      } catch (e) {
                                        message = 'Error: $e';
                                      } finally {
                                        await Dialogs.alert(
                                          description: message,
                                          title: 'Respuesta',
                                          dismissible: false,
                                          okText: 'OK',
                                          context,
                                        );
                                        Navigator.pushNamed(
                                          context,
                                          Routes.home,
                                        );
                                        debugPrint(message);
                                      }
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'La Hora que selecciono ya esta registrada por otra persona.',
                                          ),
                                          duration: Duration(seconds: 1),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        //? LIST DATES BY DAY SELECCTION USER
                        SizedBox(
                          width: wp,
                          height: hp * 0.3,
                          child: Center(
                            child: FutureBuilder<List<DateFB>?>(
                              future: fireBase.getDateData(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<List<DateFB>?> snapshot) {
                                if (snapshot.hasError) {
                                  //? ERROR FROM FIREBASE OR FLUTTER
                                  return OnErrorCharge(
                                      hp: hp, wp: wp, snapshot: snapshot.error);
                                }
                                switch (snapshot.connectionState) {
                                  case ConnectionState.waiting:
                                    //? CIRCULAR PROGRESS INDICATOR
                                    return CircularProgress(hp: hp, wp: wp);
                                  default:
                                    //? LIST ITEMS FIREBASE
                                    final itemsFB =
                                        snapshot.data as List<DateFB>;
                                    return Container(
                                      color: invColor,
                                      height: hp,
                                      width: wp,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: itemsFB.length,
                                        scrollDirection: Axis.vertical,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return DateFormat("dd/MM/yyyy")
                                                      .format(itemsFB[index]
                                                          .beginDate!) ==
                                                  DateFormat("dd/MM/yyyy")
                                                      .format(
                                                    DateTime(
                                                      dateInit.year,
                                                      dateCtrl
                                                          .initialDate.month,
                                                      dateInit.day,
                                                    ),
                                                  )
                                              ? Container(
                                                  width: wp,
                                                  margin: EdgeInsets.only(
                                                    top: hp * 0.011,
                                                  ),
                                                  padding: EdgeInsets.all(
                                                      wp * 0.005),
                                                  decoration: BoxDecoration(
                                                    color: primColor
                                                        .withOpacity(0.22),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      wp * 0.06,
                                                    ),
                                                    border: Border.all(
                                                      width: wp * 0.008,
                                                      color: darkColor1
                                                          .withOpacity(0.44),
                                                    ),
                                                  ),
                                                  child: ListTile(
                                                    //? TITLE NAME
                                                    title: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        const MyIcon(
                                                            icon: Icons
                                                                .person_outline),
                                                        MyText(
                                                          text:
                                                              '${itemsFB[index].name.toString().capitalize()} ${itemsFB[index].lastname.toString().capitalize()}',
                                                        ),
                                                      ],
                                                    ),
                                                    //? SUBTITLE DATE
                                                    subtitle: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        const MyIcon(
                                                            icon: Icons
                                                                .calendar_month_outlined),
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
                                                        if (user.email ==
                                                            itemsFB[index]
                                                                .email) {
                                                          Navigator.of(context)
                                                              .push(
                                                            MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      DateFBView(
                                                                dateFB: itemsFB[
                                                                    index],
                                                              ),
                                                            ),
                                                          );
                                                        }
                                                      } catch (e) {
                                                        debugPrint('Error: $e');
                                                      }
                                                    },
                                                  ))
                                              : const SizedBox(
                                                  width: 0, height: 0);
                                        },
                                      ),
                                    );
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void openFiles(List<PlatformFile> files) => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => FilesPage(
            files: files,
            onOpenedFile: openFile,
          ),
        ),
      );

  void openFile(PlatformFile file) {
    openFile(file);
  }

  Future<File> saveFilePermanently(PlatformFile file) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final newFile = File('${appStorage.path}/${file.name}');

    return File(file.path!).copy(newFile.path);
  }
}

class DatePageHeader extends StatelessWidget {
  const DatePageHeader({
    Key? key,
    required this.wp,
    required this.hp,
    required this.dateCtrl,
  }) : super(key: key);

  final double wp, hp;
  final DateController dateCtrl;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      //? BUTTON BACK
      leading: RoundedButton(
        backgroundColor: darkColor1.withOpacity(0.4),
        borderColor: Colors.transparent,
        flWidth: false,
        onPressed: () {
          Navigator.pushNamed(context, Routes.home);
        },
        label: 'Skip',
      ),
      //? TITLE
      subtitle: Text(
        'Selecciona Fecha y Hora',
        textAlign: TextAlign.center,
        style: MyFontStyles.subSubtitle.copyWith(
          letterSpacing: wp * 0.001,
          fontSize: hp * 0.02,
          color: gColor4,
        ),
      ),
      //? DATE & HOUR
      title: Text(
        '${DateFormat("dd/MM/yyyy\nhh:mm").format(
          DateTime(
            dateCtrl.initialDate.year,
            dateCtrl.initialDate.month,
            dateCtrl.initialDate.day,
            dateCtrl.timePicker.hour,
            dateCtrl.timePicker.minute * 0,
          ),
        )} a ${DateFormat("hh:mm a").format(
          DateTime(
            dateCtrl.timePicker.hour,
            dateCtrl.timePicker.minute * 0,
          ),
        )}',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          letterSpacing: wp * 0.001,
          fontSize: hp * 0.02,
          color: primColor,
        ),
      ),
    );
  }
}
