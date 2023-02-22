import 'package:flutter/widgets.dart';
import 'package:mockito_dating_app/helpers/get.dart';
import 'package:mockito_dating_app/models/user_model.dart';
import 'package:mockito_dating_app/ui/global_widgets/custom_form.dart';
import 'package:mockito_dating_app/data/repositories/auth_repository.dart';

class RegisterController extends ChangeNotifier {
  final _repository = Get.i.find<AuthRepository>();

  GlobalKey<CustomFormState> formKey = GlobalKey();

  late String _email, _name, _number, _lastname, _password;

  void onPasswordChanged(String text) => _password = text;
  void onlastnameChanged(String text) => _lastname = text;
  void onNumberChanged(String text) => _number = text;
  void onEmailChanged(String text) => _email = text;
  void onNameChanged(String text) => _name = text;

  String get password => _password;
  String get lastname => _lastname;
  String get number => _number;
  String get email => _email;
  String get name => _name;

  Future<bool?> submit() async {
    return await _repository.register(
      UserModel(
        name: _name,
        email: _email,
        number: _number,
        lastname: _lastname,
        password: _password,
        // id: DateTime.now().millisecondsSinceEpoch.toString(),
      ),
    );
  }
}
