import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:mockito_dating_app/helpers/get.dart';
import 'package:mockito_dating_app/models/user_model.dart';
import 'package:mockito_dating_app/ui/routes/routes.dart';
import 'package:mockito_dating_app/data/repositories/auth_repository.dart';
import 'package:mockito_dating_app/data/repositories/account_repository.dart';

class IsAuth extends StatefulWidget {
  const IsAuth({Key? key, required this.page}) : super(key: key);

  final Widget page;

  @override
  State<IsAuth> createState() => _IsAuthState();
}

class _IsAuthState extends State<IsAuth> {
  final _accountRepository = Get.i.find<AccountRepository>();
  final _authRepository = Get.i.find<AuthRepository>();

  late bool _initialized;

  @override
  void initState() {
    super.initState();

    final afterSplash = Get.i.find<bool>(tag: 'after-splash');
    _initialized = !kIsWeb || afterSplash;

    if (!_initialized) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) async {
          Navigator.pushReplacementNamed(context, Routes.splash);
          final token = _authRepository.token;
          if (token != null) {
            final user = await _accountRepository.userInfo;
            if (user != null) {
              Get.i.put<UserModel>(user);
              setState(() {
                _initialized = true;
              });
              Get.i.put<bool>(true, tag: 'after-splash');
              return;
            }
          }
          Navigator.pushReplacementNamed(context, Routes.login);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_initialized) return widget.page;
    return Container(width: 1, height: 1, color: Colors.transparent);
  }
}
