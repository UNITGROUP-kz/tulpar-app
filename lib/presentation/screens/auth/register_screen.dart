import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garage/data/fform/forms/register_form.dart';
import 'package:garage/logic/bloc/user/register/register_cubit.dart';
import 'package:garage/presentation/routing/router.dart';
import 'package:garage/presentation/widgets/step_widget.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../data/fform/forms/verify_form.dart';
import '../../widgets/snackbars/error_snackbar.dart';


@RoutePage()
class RegisterScreen extends StatefulWidget {


  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController _emailPhoneController;
  late TextEditingController _nameController;
  late TextEditingController _passwordController;
  late TextEditingController _passwordConfirmController;
  late TextEditingController _pincodeController;


  _submitRegister() async {
    if (_checkRegister()) {
      await context.read<RegisterCubit>().register(
          _nameController.value.text,
          _emailPhoneController.value.text,
          _passwordController.value.text,
          _passwordConfirmController.value.text
      );
    }
  }

  _submitVerify() async {
    if (_checkVerify()) {
      await context.read<RegisterCubit>().verify(
        _emailPhoneController.value.text,
        _pincodeController.value.text,
      );
    }
  }

  @override
  void initState() {
    _nameController = TextEditingController();
    _emailPhoneController = TextEditingController();
    _passwordController = TextEditingController();
    _passwordConfirmController = TextEditingController();
    _pincodeController = TextEditingController();
    super.initState();
  }

  bool _checkRegister() {
    final form = RegisterForm.parse(
        name: _nameController.value.text,
        emailPhone: _emailPhoneController.value.text,
        password: _passwordController.value.text,
        confirmPassword: _passwordConfirmController.value.text
    );

    if (form.isInvalid) {
      for (var e in form.exceptions) {
        showErrorSnackBar(context, e.toString());
      }
    }

    return form.isValid;
  }

  bool _checkVerify() {
    final form = VerifyForm.parse(
        emailPhone: _emailPhoneController.value.text,
        code: _pincodeController.value.text
    );

    if (form.isInvalid) {
      for (var e in form.exceptions) {
        showErrorSnackBar(context, e.toString());
      }
    }

    return form.isValid;
  }

  @override
  void dispose() {
    _emailPhoneController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    _pincodeController.dispose();
    super.dispose();
  }

  _listener(BuildContext context, RegisterState state) {
    if (state.error != null) {
      showErrorSnackBar(
          context, state.error?.messages[0] ?? 'Неизвестная ошибка');
    }
    else if (state.status == RegisterStatusState.success) {
      context.router.navigate(
          SplashRouter(
              children: [
                UserRouter(
                    children: [
                      UserCarRouter()
                    ]
                )
              ]
          )
      );
    }
  }

  _back() {
    context.router.pop();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            IconButton(
                onPressed: _back, icon: Icon(Icons.arrow_back_ios)),
            Center(
              child: BlocConsumer<RegisterCubit, RegisterState>(
                listener: _listener,
                builder: (context, state) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      StepWidget(maxStep: 2, currentStep: state.status == RegisterStatusState.register? 1 : 2),
                      if (state.status == RegisterStatusState.register) ...[
                        TextField(
                          controller: _nameController,
                        ),
                        TextField(
                          controller: _emailPhoneController,
                        ),
                        TextField(
                          controller: _passwordController,
                        ),
                        TextField(
                          controller: _passwordConfirmController,
                        ),
                        if (state.isLoading) ElevatedButton(
                            onPressed: () {},
                            child: CupertinoActivityIndicator()
                        ) else ElevatedButton(
                            onPressed: _submitRegister,
                            child: Text('Регистрация')
                        )
                      ]
                      else if (state.status == RegisterStatusState.verify)...[
                        PinCodeTextField(
                          appContext: context,
                          length: 6,
                          controller: _pincodeController,
                        ),
                        if (state.isLoading) ElevatedButton(
                            onPressed: () {},
                            child: CupertinoActivityIndicator()
                        ) else ElevatedButton(
                            onPressed: _submitVerify,
                            child: Text('Верификация')
                        )
                      ],
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}