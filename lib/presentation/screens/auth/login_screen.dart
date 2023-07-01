import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:garage/data/repositories/firebase_auth_repository.dart';


@RoutePage()
class LoginScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Авторизация'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('AAAAA'),
              SignInButton(
                Buttons.Google,
                onPressed: () async {
                  try {
                    await FirebaseAuthRepository.withGoogle();
                    // Успешная авторизация
                  } catch (e) {
                    // Обработка ошибок
                  }
                },
              ),
              SignInButton(
                Buttons.Facebook,
                onPressed: () async {
                  try {
                    await FirebaseAuthRepository.withFacebook();
                    // Успешная авторизация
                  } catch (e) {
                    // Обработка ошибок
                  }
                },
              ),
              SignInButton(
                Buttons.AppleDark,
                onPressed: () async {
                  try {
                    await FirebaseAuthRepository.withApple();
                    // Успешная авторизация
                  } catch (e) {
                    // Обработка ошибок
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}