import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mockito_dating_app/ui/utils/colors.dart';
import 'package:mockito_dating_app/ui/utils/responsive.dart';
import 'package:mockito_dating_app/ui/global_widgets/custom_form.dart';

class InputText extends StatefulWidget {
  final void Function(String)? onSubmitted, onChanged;
  final String? Function(String)? validator;
  final TextInputAction? textInputAction;
  final bool? obscureText, suffixIcon;
  final TextInputType? keyboardType;
  final IconData? prefixIcon;
  final double? inputSize;
  final String label;

  const InputText({
    Key? key,
    this.validator,
    this.onChanged,
    this.inputSize,
    this.prefixIcon,
    this.suffixIcon,
    this.onSubmitted,
    this.keyboardType,
    this.obscureText = false,
    required this.textInputAction,
    required this.label,
  }) : super(key: key);

  @override
  State<InputText> createState() => InputTextState();
}

class InputTextState extends State<InputText> {
  late bool _obscureText;
  CustomFormState? _formState;
  String? get errorText => _errorText;
  String? _errorText = '';

  //? INIT
  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText!;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _formState = CustomForm.formOf(context);
      _formState?.register(this);
    });
  }

  //? DEACTIVATE
  @override
  void deactivate() {
    _formState?.remove(this);
    super.deactivate();
  }

  //? VALIDATE
  void _validate(String text) {
    if (widget.validator != null) {
      _errorText = widget.validator!(text);
      setState(() {});
    }

    if (widget.onChanged != null) {
      widget.onChanged!(text);
    }
  }

  //? ONCHANGE
  void _onVisibleChanged() {
    _obscureText = !_obscureText;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    final wp = responsive.wp(100);
    final hp = responsive.hp(100);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: wp * 0.04),
      child: TextField(
        onChanged: _validate,
        obscureText: _obscureText,
        onSubmitted: widget.onSubmitted,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        decoration: InputDecoration(
          label: Text(
            widget.label,
            style: TextStyle(
              fontSize: widget.inputSize != null
                  ? widget.inputSize! - 2
                  : widget.inputSize,
            ),
          ),
          prefixIcon: widget.prefixIcon != null
              ? Icon(
                  widget.prefixIcon,
                  size: widget.inputSize,
                )
              : null,
          suffixIcon: widget.suffixIcon != null
              ? widget.suffixIcon == true && widget.obscureText == true
                  ? CupertinoButton(
                      minSize: 20,
                      onPressed: _onVisibleChanged,
                      padding: EdgeInsets.all(hp * 0.001),
                      child: !_obscureText == true
                          ? Icon(
                              Icons.visibility_off_outlined,
                              color: Colors.grey,
                              size: widget.inputSize,
                            )
                          : Icon(
                              Icons.visibility_outlined,
                              color: primColor,
                              size: widget.inputSize,
                            ),
                    )
                  : Icon(
                      Icons.check_circle_outline,
                      size: widget.inputSize,
                      color: _errorText == null ? primColor : Colors.grey,
                    )
              : null,
        ),
      ),
    );
  }
}
