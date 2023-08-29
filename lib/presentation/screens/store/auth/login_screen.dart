import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garage/data/enums/fetch_status.dart';
import 'package:garage/data/fform/forms/store_login_form.dart';
import 'package:garage/logic/bloc/store/login/login_store_cubit.dart';
import 'package:garage/presentation/routing/router.dart';
import 'package:garage/presentation/widgets/form/fields/password_field.dart';
import 'package:garage/presentation/widgets/form/fields/phone_field.dart';

import '../../../../logic/bloc/store/auth/auth_store_cubit.dart';
import '../../../widgets/buttons/elevated_button.dart';
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
      await context.read<LoginStoreCubit>().login(
          _phoneController.value.text,
          _passwordController.value.text
      );
    }
  }

  @override
  void initState() {
    _phoneController = TextEditingController(text: '+7');
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

  _listener(BuildContext context, LoginStoreState state) {
    if (state.error != null) {
      showErrorSnackBar(
          context, state.error?.messages[0] ?? 'Неизвестная ошибка');
    }
    else if(state.status == FetchStatus.success) {
      context.router.replace(
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
    context.router.replace(LoginRoute());
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Text('Авторизация Магазина', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          PhoneFieldWidget(
            label: 'Телефон',
            controller: _phoneController,
          ),
          SizedBox(height: 10),
          PasswordFieldWidget(
            label: 'Пароль',
            controller: _passwordController,
          ),
          SizedBox(height: 10),
          BlocConsumer<LoginStoreCubit, LoginStoreState>(
            listener: _listener,
            builder: (context, state) {
              if(state.status == FetchStatus.loading) return ElevatedButtonWidget(
                  onPressed: () {},
                  child: CupertinoActivityIndicator()
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
    );
  }
}