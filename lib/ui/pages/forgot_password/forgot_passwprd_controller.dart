import 'package:flutter/cupertino.dart';
import 'package:mockito_dating_app/helpers/get.dart';
import 'package:mockito_dating_app/data/providers/remote/fb_serv_date_user.dart';
import 'package:mockito_dating_app/data/repositories/auth_repository.dart';

class ForgotPasswordController extends ChangeNotifier {
  final _repository = Get.i.find<AuthRepository>();

  late String _email;
  String get email => _email;

  void onEmailChanged(String text) => _email = text;

  Future<bool> submit() async {
    final fireBase = FBServices();
    final result = await fireBase.getUserEmailExist(_email);
    result ? await _repository.sendResetToken(_email) : false;
    return result;
  }
}
