import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garage/logic/bloc/user/auth/auth_cubit.dart';
import 'package:garage/logic/bloc/user/login/login_cubit.dart';
import 'package:garage/presentation/routing/router.dart';
import 'package:garage/presentation/widgets/form/fields/password_field.dart';
import 'package:garage/presentation/widgets/form/fields/phone_field.dart';
import 'package:garage/presentation/widgets/navigation/header.dart';

import '../../../../data/fform/forms/login_form.dart';
import '../../../widgets/buttons/elevated_button.dart';
import '../../../widgets/form/fields/text_field.dart';
import '../../../widgets/snackbars/error_snackbar.dart';


@RoutePage()
class LoginScreen extends StatefulWidget {


  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _emailPhoneController;
  late TextEditingController _passwordController;
  


  _submit() async {
    if (_check()) {
      await context.read<LoginCubit>().login(
          _emailPhoneController.value.text,
          _passwordController.value.text
      );
    }
  }

  @override
  void initState() {
    _emailPhoneController = TextEditingController(text: '+7');
    _passwordController = TextEditingController();
    super.initState();
  }

  bool _check() {
    final form = LoginForm.parse(
        emailPhone: _emailPhoneController.value.text,
        password: _passwordController.value.text
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
    _passwordController.dispose();
    super.dispose();
  }

  _listener(BuildContext context, LoginState state) {
    if (state.status == LoginStatus.error) {
      showErrorSnackBar(context, state.error?.messages[0] ?? 'Неизвестная ошибка');
    } else if(state.status == LoginStatus.validate) {
      context.router.navigate(RegisterRoute(emailPhone: _emailPhoneController.value.text));
    }
  }

  _toRegister() {
    context.router.navigate(RegisterRoute());
  }

  _toLogin() {
    context.router.navigate(StoreLoginRoute());
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Text('Авторизация', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          PhoneFieldWidget(
            label: 'Телефон',
            controller: _emailPhoneController,
          ),
          SizedBox(height: 10),
          PasswordFieldWidget(
            label: 'Пароль',
            controller: _passwordController,
          ),
          SizedBox(height: 10),
          BlocConsumer<LoginCubit, LoginState>(
            listener: _listener,
            builder: (context, state) {
              if(state.status == LoginStatus.loading) return ElevatedButtonWidget(
                  onPressed: () {},
                  child: CupertinoActivityIndicator(color: Colors.black45)
              );
              return ElevatedButtonWidget(
                  onPressed: _submit,
                  child: Text('Авторизоваться')
              );
            },
          ),
          SizedBox(height: 10),
          Text.rich(TextSpan(
              children: [
                TextSpan(
                  text: 'У вас нет аккаунта? ',
                ),
                TextSpan(
                    text: 'Зарегистрироваться',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary
                    ),
                    recognizer: TapGestureRecognizer()..onTap = _toRegister
                )
              ]
          )),
          Text.rich(TextSpan(
              children: [
                TextSpan(
                  text: 'Войти как ',
                ),
                TextSpan(
                    text: 'Магазин',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary
                    ),
                    recognizer: TapGestureRecognizer()..onTap = _toLogin
                )
              ]
          )),

          // SignInButton(
          //   Buttons.Google,
          //   onPressed: () async {
          //     try {
          //       await FirebaseAuthRepository.withGoogle();
          //       // Успешная авторизация
          //     } catch (e) {
          //       // Обработка ошибок
          //     }
          //   },
          // ),
          // SignInButton(
          //   Buttons.Facebook,
          //   onPressed: () async {
          //     try {
          //       await FirebaseAuthRepository.withFacebook();
          //       // Успешная авторизация
          //     } catch (e) {
          //       // Обработка ошибок
          //     }
          //   },
          // ),
          // SignInButton(
          //   Buttons.AppleDark,
          //   onPressed: () async {
          //     try {
          //       await FirebaseAuthRepository.withApple();
          //       // Успешная авторизация
          //     } catch (e) {
          //       // Обработка ошибок
          //     }
          //   },
          // ),
        ],
      ),
    );
  }
}