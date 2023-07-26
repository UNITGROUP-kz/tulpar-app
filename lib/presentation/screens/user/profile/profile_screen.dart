import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garage/logic/bloc/dictionary/current_city/current_city_cubit.dart';
import 'package:garage/logic/bloc/user/auth/auth_cubit.dart';
import 'package:garage/presentation/routing/router.dart';
import 'package:garage/presentation/widgets/screen_templates/screen_default_template.dart';

import '../../../../data/models/dictionary/city_model.dart';
import '../../../widgets/tiles/setting_tile.dart';

@RoutePage()
class UserProfileScreen extends StatefulWidget {

  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  _exit() {
    context.read<AuthCubit>().logout();
  }

  _change() {
    context.router.navigate(SplashRouter(
      children: [
        UserFormRouter(
          children: [
            ChangeProfileRoute()
          ]
        )
      ]
    ));
  }

  _notificationSwitch(bool value) {

  }

  _changeCity() async {
    final city = await context.router.push(SplashRouter(
      children: [
        PickerRouter(
          children: [
            CityPickerRoute()
          ]
        )
      ]
    ));
    print(city);

    if(city != null) context.read<CurrentCityCubit>().change(city as CityModel);
  }

  _toDocument() {
    context.router.navigate(DocumentRouter(
      children: [
        DocumentsRoute()
      ]
    ));
  }

  @override
  Widget build(BuildContext context) {
    return ScreenDefaultTemplate(
      scrollController: _scrollController,
      children: [
        BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            return ClipOval(
              child: Container(
                color: Colors.grey.shade200,
                width: MediaQuery.of(context).size.width * 0.35,
                height: MediaQuery.of(context).size.width * 0.35,
                child: CachedNetworkImage(
                    imageUrl: state.user?.image ?? '',
                    placeholder: (context, String val) => CupertinoActivityIndicator(),
                    errorWidget: (context, String val, err) => Icon(Icons.person, size: MediaQuery.of(context).size.width * 0.2, color: Colors.grey),
                ),
              ),
            );
          },
        ),
        TextButton(onPressed: _change, child: Text('Изменить профиль')),
        SizedBox(height: 20,),
        BlocBuilder<CurrentCityCubit, CurrentCityState>(
            builder: (context, state) {
              return SettingsTile(label: 'Город', child: Text(state.currentCity?.name ?? 'Не выбран'), callback: _changeCity,);
            }
        ),
        SettingsTile(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          label: 'Уведомления',
          child: Switch(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            value: true,
            onChanged: _notificationSwitch,
          ),
        ),
        SettingsTile(label: 'Документы', child: Icon(Icons.insert_drive_file_sharp, color: Colors.grey), callback: _toDocument),
        SettingsTile(
            label: 'Выйти',
            child: Icon(
              Icons.exit_to_app_rounded,
              color: Colors.red.shade800,
            ),
            callback: _exit,
        ),
      ],
    );
  }
}