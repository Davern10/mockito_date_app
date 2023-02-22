import 'package:flutter/widgets.dart';
import 'package:mockito_dating_app/helpers/get.dart';
import 'package:mockito_dating_app/models/user_model.dart';
import 'package:mockito_dating_app/data/repositories/account_repository.dart';
import 'package:mockito_dating_app/data/repositories/auth_repository.dart';

class LoginController extends ChangeNotifier {
  final _accountRepository = Get.i.find<AccountRepository>();
  final _authRepository = Get.i.find<AuthRepository>();

  String _email = '', _password = '';
  String get password => _password;
  String get email => _email;

  void onEmailChanged(String text) => _email = text;
  void onPasswordChanged(String text) => _password = text;

  Future<UserModel?> submit() async {
    final String? token = await _authRepository.login(_email, _password);
    if (token != null) {
      await _authRepository.saveToken(token);
      return _accountRepository.userInfo;
    }
    return null;
  }
}
