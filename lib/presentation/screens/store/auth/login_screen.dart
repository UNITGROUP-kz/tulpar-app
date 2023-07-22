import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garage/data/fform/forms/store_login_form.dart';
import 'package:garage/presentation/routing/router.dart';

import '../../../../logic/bloc/store/auth/auth_store_cubit.dart';
import '../../../widgets/snackbars/error_snackbar.dart';


@RoutePage()
class StoreLoginScreen extends StatefulWidget {


  @override
  State<StoreLoginScreen> createState() => _StoreLoginScreenState();
}

class _StoreLoginScreenState extends State<StoreLoginScreen> {
  late TextEditingController _phoneController;
  late TextEditingController _passwordController;


  _submit() async {
    if (_check()) {
      await context.read<AuthStoreCubit>().login(
          _phoneController.value.text,
          _passwordController.value.text
      );
    }
  }

  @override
  void initState() {
    _phoneController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  bool _check() {
    final form = StoreLoginForm.parse(
        phone: _phoneController.value.text,
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
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  _listener(BuildContext context, AuthStoreState state) {
    if (state.error != null) {
      showErrorSnackBar(
          context, state.error?.messages[0] ?? 'Неизвестная ошибка');
    }
    else if(state.auth != null) {
      context.router.navigate(
          SplashRouter(
              children: [
                StoreRouter(
                    children: [
                      StoreOrderRouter()
                    ]
                )
              ]
          )
      );
    }
  }

  _toRegister() {
    context.router.pop();
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
                controller: _phoneController,
              ),
              TextField(
                controller: _passwordController,
              ),
              BlocConsumer<AuthStoreCubit, AuthStoreState>(
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
                      text: 'Войти как ',
                    ),
                    TextSpan(
                        text: 'Пользователь',
                        recognizer: TapGestureRecognizer()..onTap = _toRegister,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor
                        )
                    )
                  ]
              ))
            ],
          ),
        ),
      ),
    );
  }
}