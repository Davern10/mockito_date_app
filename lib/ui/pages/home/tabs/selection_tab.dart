import 'package:flutter/material.dart';
import 'package:mockito_dating_app/helpers/get.dart';
import 'package:mockito_dating_app/models/user_model.dart';
import 'package:mockito_dating_app/ui/global_widgets/image_button.dart';
import 'package:mockito_dating_app/ui/utils/colors.dart';
import 'package:mockito_dating_app/ui/utils/responsive.dart';

class SeleccionTab extends StatefulWidget {
  const SeleccionTab({Key? key}) : super(key: key);

  @override
  State<SeleccionTab> createState() => _SeleccionTabState();
}

class _SeleccionTabState extends State<SeleccionTab> {
  @override
  Widget build(BuildContext context) {
    final user = Get.i.find<UserModel>(); //! AQUIIIIIIIIIIIIIIIIIIIIIIII
    final responsive = Responsive.of(context);
    final wp = responsive.wp(100);
    final hp = responsive.hp(100);
    return Center(
      child: Container(
        color: invColor,
        height: hp,
        width: wp,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //? IMAGES BUTTONS COLUMN-ROW
              Container(
                margin: EdgeInsets.symmetric(vertical: hp * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ButtonImage(
                      wp: wp,
                      hp: hp,
                      text: user.name,
                      image: 'assets/images/happy_smile.png',
                    ),
                    ButtonImage(
                      wp: wp,
                      hp: hp,
                      text: user.name,
                      image: 'assets/images/happy_smile.png',
                    ),
                  ],
                ),
              ),
              //? ROW BOTTON'S IMAGE 2
              Container(
                margin: EdgeInsets.symmetric(vertical: hp * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ButtonImage(
                      wp: wp,
                      hp: hp,
                      text: user.name,
                      image: 'assets/images/happy_smile.png',
                    ),
                    ButtonImage(
                      wp: wp,
                      hp: hp,
                      text: user.name,
                      image: 'assets/images/happy_smile.png',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
