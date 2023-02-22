import 'package:flutter/widgets.dart';
import 'package:mockito_dating_app/helpers/get.dart';
import 'package:mockito_dating_app/models/user_model.dart';
import 'package:mockito_dating_app/data/repositories/auth_repository.dart';
import 'package:mockito_dating_app/data/repositories/account_repository.dart';
import 'package:mockito_dating_app/data/repositories/preferences_repository.dart';

class SplashController extends ChangeNotifier {
  final _authRepository = Get.i.find<AuthRepository>();
  final _prefsRepository = Get.i.find<PrefsRepository>();
  final _accountRepository = Get.i.find<AccountRepository>();

  void Function(UserModel? user, bool isReady)? onAfterFirstLayout;

  void afterFirstLayout() async {
    await Future.delayed(const Duration(seconds: 2));
    final token = _authRepository.token;
    if (token != null) {
      final user = await _accountRepository.userInfo;
      if (user != null) {
        if (onAfterFirstLayout != null) {
          onAfterFirstLayout!(user, true);
          return;
        }
      }
    }

    final isReady = _prefsRepository.onboardAndWelcomeReady;

    if (onAfterFirstLayout != null) {
      onAfterFirstLayout!(null, isReady);
    }
  }
}
