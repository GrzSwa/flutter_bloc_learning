import 'package:block_learning/config/constant/enums.dart' as iType;
import 'package:block_learning/core/cubit/login_form_cubit/login_form_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class Input extends StatefulWidget {
  final iType.InputType inputType;
  final String name;
  final String? placeholder;
  final Icon? icons;
  Input(
      {Key? key,
      required this.inputType,
      required this.name,
      this.placeholder,
      this.icons})
      : super(key: key);

  @override
  _InputState createState() => _InputState();
}

class _InputState extends State<Input> {
  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
        name: widget.name,
        obscureText:
            widget.inputType == iType.InputType.password ? true : false,
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
            hintText: widget.placeholder,
            prefixIcon: widget.icons),
        onChanged: (value) {
          if (widget.inputType == iType.InputType.password) {
            context.read<LoginFormCubit>().setPassword(value!);
          } else if (widget.inputType == iType.InputType.username) {
            context.read<LoginFormCubit>().setUsername(value!);
          }
        });
  }
}
