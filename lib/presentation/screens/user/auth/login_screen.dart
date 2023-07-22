import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garage/logic/bloc/user/auth/auth_cubit.dart';
import 'package:garage/presentation/routing/router.dart';

import '../../../../data/fform/forms/login_form.dart';
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
      await context.read<AuthCubit>().login(
          _emailPhoneController.value.text,
          _passwordController.value.text
      );
    }
  }

  @override
  void initState() {
    _emailPhoneController = TextEditingController();
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

  _listener(BuildContext context, AuthState state) {
    if (state.error != null) {
      showErrorSnackBar(
          context, state.error?.messages[0] ?? 'Неизвестная ошибка');
    }
    else if(state.auth != null) {
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

  _toRegister() {
    context.router.navigate(RegisterRoute());
  }

  _toLogin() {
    context.router.navigate(StoreLoginRoute());
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _emailPhoneController,
              ),
              TextField(
                controller: _passwordController,
              ),
              BlocConsumer<AuthCubit, AuthState>(
                listener: _listener,
                builder: (context, state) {
                  if(state.isLoading) return ElevatedButton(
                      onPressed: () {},
                      child: CupertinoActivityIndicator()
                  );
                  return ElevatedButton(
                      onPressed: _submit,
                      child: Text('Авторизоваться')
                  );
                },
              ),
              Text.rich(TextSpan(
                children: [
                  TextSpan(
                    text: 'У вас нет аккаунта? ',
                  ),
                  TextSpan(
                    text: 'Зарегистрироваться',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor
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
                          color: Theme.of(context).primaryColor
                        ),
                        recognizer: TapGestureRecognizer()..onTap = _toLogin
                    )
                  ]
              ))

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
        ),
      ),
    );
  }
}