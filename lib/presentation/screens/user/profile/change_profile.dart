import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garage/logic/bloc/user/auth/auth_cubit.dart';
import 'package:garage/presentation/widgets/builder/multi_value_listenable_builder.dart';
import 'package:garage/presentation/widgets/screen_templates/screen_default_template.dart';
import 'package:garage/presentation/widgets/snackbars/error_snackbar.dart';

import '../../../../data/enums/fetch_status.dart';
import '../../../../data/fform/forms/change_profile_form.dart';
import '../../../../data/models/auth/user_model.dart';
import '../../../../data/params/profile/change_profile_params.dart';
import '../../../../logic/bloc/user/change_profile/change_profile_cubit.dart';
import '../../../widgets/buttons/elevated_button.dart';
import '../../../widgets/form/fields/password_field.dart';
import '../../../widgets/form/fields/phone_field.dart';
import '../../../widgets/form/fields/text_field.dart';
import '../../../widgets/navigation/header.dart';

@RoutePage()
class ChangeProfileScreen extends StatefulWidget {

  const ChangeProfileScreen({super.key});

  @override
  State<ChangeProfileScreen> createState() => _ChangeProfileScreenState();
}

class _ChangeProfileScreenState extends State<ChangeProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _passwordController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;

  _change() {
    if (_check()) {
      context.read<ChangeProfileCubit>().change(ChangeProfileParams(
          name: _nameController.value.text,
          password: _passwordController.value.text,
          email: _emailController.value.text,
          phone: _phoneController.value.text
      ));
    }
  }

  bool _check() {
    final form = ChangeProfileForm.parse(
        name: _nameController.value.text,
        password: _passwordController.value.text,
        email: _emailController.value.text,
        phone: _phoneController.value.text
    );

    if (form.isInvalid) {
      for (var element in form.exceptions) {
        showErrorSnackBar(context, element.toString());
      }
    }

    return form.isValid;
  }

  _listenerState(BuildContext context, ChangeProfileState state) {
    if(state.status == FetchStatus.error) {
      showErrorSnackBar(context, state.error?.messages[0] ?? 'Неизвестная ошибка');
    } else if(state.status == FetchStatus.success) {
      context.router.pop();
    }
  }

  @override
  void initState() {
    UserModel? user = context.read<AuthCubit>().state.user;
    _nameController = TextEditingController(text: user?.name ?? '');
    _phoneController = TextEditingController(text: user?.phone ?? '');
    _emailController = TextEditingController(text: user?.email ?? '');
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenDefaultTemplate(
      children: [
        Header(title: 'Изменить профиль'),
        TextFieldWidget(
            isRequired: true,
            controller: _nameController,
            label: 'Имя'
        ),
        SizedBox(height: 10),
        TextFieldWidget(
            label: 'Email',
            controller: _emailController
        ),
        SizedBox(height: 10),
        PhoneFieldWidget(
          controller: _phoneController,
          label: 'Телефон',
        ),
        SizedBox(height: 10),
        PasswordFieldWidget(
            controller: _passwordController,
            label: 'Пароль',
        ),
        SizedBox(height: 10),
        BlocConsumer<ChangeProfileCubit, ChangeProfileState>(
          listener: _listenerState,
          builder: (context, state) {
            if(state.status == FetchStatus.loading) {
              return ElevatedButtonWidget(
                  onPressed: () {},
                  child: CupertinoActivityIndicator()
              );
            }
            return MultiValueListenableBuilder(
                valuesListenable: [
                  _nameController,
                  _phoneController,
                  _emailController
                ],
                builder: (context, value, child) {
                  bool isVisible = value[0].text.isNotEmpty && (value[1].text.isNotEmpty || value[2].text.isNotEmpty);
                  return ElevatedButtonWidget(
                      onPressed: isVisible ? _change : null,
                      child: Text('Изменить профиль')
                  );
                }
            );
          },
        )
      ],
    );
  }
}
