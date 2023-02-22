import 'package:flutter/material.dart';
import 'package:mockito_dating_app/ui/routes/routes.dart';
import 'package:mockito_dating_app/ui/pages/home/home_page.dart';
import 'package:mockito_dating_app/ui/pages/date/date_page.dart';
import 'package:mockito_dating_app/ui/global_widgets/is_auth.dart';
import 'package:mockito_dating_app/ui/pages/login/login_page.dart';
import 'package:mockito_dating_app/ui/pages/splash/splash_page.dart';
import 'package:mockito_dating_app/ui/pages/welcome/welcome_page.dart';
import 'package:mockito_dating_app/ui/pages/onboard/onboard_page.dart';
import 'package:mockito_dating_app/ui/pages/register/register_page.dart';
import 'package:mockito_dating_app/ui/global_widgets/list_firebase_view.dart';
import 'package:mockito_dating_app/ui/pages/forgot_password/forgot_password_page.dart';

abstract class Pages {
  static const String initial = Routes.splash; //SPLASH

  static final Map<String, Widget Function(BuildContext)> routes = {
    Routes.login: (_) => const LoginPage(),
    Routes.splash: (_) => const SplashPage(),
    Routes.welcome: (_) => const WelcomePage(),
    Routes.onboard: (_) => const OnboardPage(),
    Routes.register: (_) => const RegisterPage(),
    Routes.personalPage: (_) => const DatePage(),
    Routes.home: (_) => const IsAuth(page: HomePage()),
    Routes.forgotPassword: (_) => const ForgotPasswordPage(),
    Routes.listFireBase: (_) => const DateListFBPage(),
  };
}
