import 'input_text.dart';
import 'package:flutter/material.dart';

//TODO USER REGISTER CONFIRM VALIDATOR

class CustomForm extends StatefulWidget {
  const CustomForm({required this.child, Key? key}) : super(key: key);

  final Widget child;

  @override
  State<CustomForm> createState() => CustomFormState();

  static CustomFormState? formOf(BuildContext context) {
    return context.findAncestorStateOfType<CustomFormState>();
  }
}

class CustomFormState extends State<CustomForm> {
  final Set<InputTextState> _fields = <InputTextState>{};

  bool? validate() {
    bool? isOk = true;

    for (final InputTextState item in _fields) {
      if (item.errorText != null) {
        isOk = false;
        break;
      }
    }

    return isOk;
  }

  void register(InputTextState field) => _fields.add(field);

  void remove(InputTextState field) => _fields.remove(field);

  @override
  Widget build(BuildContext context) => widget.child;
}
