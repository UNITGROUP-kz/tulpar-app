import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garage/logic/bloc/user/auth/auth_cubit.dart';
import 'package:garage/presentation/widgets/bottomsheets/choose_image_picker.dart';
import 'package:garage/presentation/widgets/builder/multi_value_listenable_builder.dart';
import 'package:garage/presentation/widgets/screen_templates/screen_default_template.dart';
import 'package:garage/presentation/widgets/snackbars/error_snackbar.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../data/enums/fetch_status.dart';
import '../../../../data/fform/forms/change_profile_form.dart';
import '../../../../data/models/auth/user_model.dart';
import '../../../../data/params/change_image_params.dart';
import '../../../../data/params/profile/change_profile_params.dart';
import '../../../../logic/bloc/user/change_image/change_image_cubit.dart';
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

  _showDeleteDialog() {
    showDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: Text('Удалить аккаунт'),
          actions: [
            CupertinoDialogAction(child: Text('Отмена'), onPressed: _back(context)),
            CupertinoDialogAction(child: Text('Удалить'), onPressed: _delete(context)),
          ],
        )
    );
  }

  _delete(BuildContext context) => (){
    context.read<AuthCubit>().delete().then((value) {
      _back(context)();
    });
  };

  _back(BuildContext context) => () {
    context.router.pop();
  };

  _showChooseImage() {
    showModalBottomSheet(
        context: context,
        useRootNavigator: true,

        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
        ),
        builder: (context) => ChooseImagePicker(callback: _changeImage(context))
    );
  }

  _changeImage(BuildContext context) => (XFile? image) async {
    if(image == null) return;

    Uint8List bytes = await image.readAsBytes();
    MultipartFile imageMF = MultipartFile.fromBytes(bytes, filename: image.name);
    
    context.read<ChangeImageUserCubit>().change(ChangeImageParams(imageMF), bytes);

    _back(context)();
  };

  _listenerImage(BuildContext context, ChangeImageUserState state) {
    if(state.status == FetchStatus.error) {
      showErrorSnackBar(context, state.error?.messages[0] ?? 'Неизвестная ошибка');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenDefaultTemplate(
      children: [
        Header(title: 'Изменить профиль'),
        BlocBuilder<AuthCubit, AuthState>(
          builder: (context, authState) {
            return BlocConsumer<ChangeImageUserCubit, ChangeImageUserState>(
              listener: _listenerImage,
              builder: (context, state) {
                return InkWell(
                  customBorder: CircleBorder(),
                  onTap: _showChooseImage,
                  child: ClipOval(
                    child: Container(
                      color: Colors.grey.shade200,
                      width: MediaQuery.of(context).size.width * 0.35,
                      height: MediaQuery.of(context).size.width * 0.35,
                      child: state.bytes == null ? CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: authState.user?.image ?? '',
                        placeholder: (context, String val) => CupertinoActivityIndicator(),
                        errorWidget: (context, String val, err) => Icon(Icons.person, size: MediaQuery.of(context).size.width * 0.2, color: Colors.grey),
                      ) : Image.memory(
                        state.bytes!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
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
        ),
        SizedBox(height: 10),
        TextButton(child: Text('Удалить профиль'), onPressed: _showDeleteDialog)
      ],
    );
  }
}
