import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garage/data/fform/forms/register_form.dart';
import 'package:garage/logic/bloc/user/register/register_cubit.dart';
import 'package:garage/presentation/routing/router.dart';
import 'package:garage/presentation/widgets/navigation/header.dart';
import 'package:garage/presentation/widgets/navigation/step_widget.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../data/fform/fields/password_field.dart';
import '../../../../data/fform/forms/verify_form.dart';
import '../../../widgets/buttons/elevated_button.dart';
import '../../../widgets/form/fields/password_field.dart';
import '../../../widgets/form/fields/pincode_field.dart';
import '../../../widgets/form/fields/text_field.dart';
import '../../../widgets/snackbars/error_snackbar.dart';



@RoutePage()
class RegisterScreen extends StatefulWidget {

  final String? emailPhone;

  const RegisterScreen({super.key, this.emailPhone});

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
    _emailPhoneController = TextEditingController(text: widget.emailPhone);
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

  _toPrivacy() {
    context.router.navigate(DocumentRouter(
      children: [
        PrivacyRoute()
      ]
    ));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<RegisterCubit, RegisterState>(
          listener: _listener,
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Header(title: 'Регистрация'),
                  StepWidget(maxStep: 2, currentStep: state.status == RegisterStatusState.register? 1 : 2),
                  Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (state.status == RegisterStatusState.register) ...[
                        TextFieldWidget(
                          label: 'Имя',
                          controller: _nameController,
                        ),
                        SizedBox(height: 10),
                        TextFieldWidget(
                          label: 'Email или Телефон',
                          controller: _emailPhoneController,
                        ),
                        SizedBox(height: 10),
                        PasswordFieldWidget(
                          label: 'Пароль',
                          controller: _passwordController,
                        ),
                        SizedBox(height: 10),
                        PasswordFieldWidget(
                          label: 'Повторите пароль',
                          controller: _passwordConfirmController,
                        ),
                        SizedBox(height: 10),
                        if (state.isLoading) ElevatedButtonWidget(
                            onPressed: () {},
                            child: CupertinoActivityIndicator()
                        ) else ElevatedButtonWidget(
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
                        SizedBox(height: 10),
                        if (state.isLoading) ElevatedButtonWidget(
                            onPressed: () {},
                            child: CupertinoActivityIndicator()
                        ) else ElevatedButtonWidget(
                            onPressed: _submitVerify,
                            child: Text('Верификация')
                        ),

                      ],
                      SizedBox(height: 10),
                      Text.rich(TextSpan(
                          children: [
                            TextSpan(
                              text: 'Регистрируясь вы соглашаетесь с ',
                            ),
                            TextSpan(
                                text: 'Политикой конфиденциальности',
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor
                                ),
                                recognizer: TapGestureRecognizer()..onTap = _toPrivacy
                            ),
                            TextSpan(
                              text: ' приложения'
                            )
                          ]
                      ), textAlign: TextAlign.center,),
                    ],
                  ),
                  Spacer(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}