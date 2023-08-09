import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garage/logic/bloc/dictionary/current_city/current_city_cubit.dart';
import 'package:garage/logic/bloc/user/auth/auth_cubit.dart';
import 'package:garage/presentation/routing/router.dart';
import 'package:garage/presentation/widgets/screen_templates/screen_default_template.dart';

import '../../../../core/services/firebase/fb_notification.dart';
import '../../../../data/models/dictionary/city_model.dart';
import '../../../../data/models/dictionary/offer_model.dart';
import '../../../../logic/bloc/store/auth/auth_store_cubit.dart';
import '../../../widgets/tiles/setting_tile.dart';

@RoutePage()
class StoreProfileScreen extends StatefulWidget {

  const StoreProfileScreen({super.key});

  @override
  State<StoreProfileScreen> createState() => _StoreProfileScreenState();
}

class _StoreProfileScreenState extends State<StoreProfileScreen> {
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
    context.read<AuthStoreCubit>().logout();
  }

  _change() {
    context.router.navigate(SplashRouter(
        children: [
          StoreFormRouter(
              children: [
                ChangeStoreRoute()
              ]
          )
        ]
    ));
  }

  _notificationSwitch(bool value) async {
    await FbNotification.toggle();
    setState(() {});
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
        BlocBuilder<AuthStoreCubit, AuthStoreState>(
          builder: (context, state) {
            return ClipOval(
              child: Container(
                color: Colors.grey.shade200,
                width: MediaQuery.of(context).size.width * 0.35,
                height: MediaQuery.of(context).size.width * 0.35,
                child: CachedNetworkImage(
                  imageUrl: state.store?.image ?? '',
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
              return SettingsTile(
                  icon: Icons.location_city,
                  label: 'Город',
                  child: Text(state.currentCity?.name ?? 'Не выбран'),
                  callback: _changeCity,
              );
            }
        ),
        SettingsTile(
          label: 'Уведомления',
          icon: Icons.notifications,
          child: Switch(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            value: FbNotification.checkTopic() ?? false,
            onChanged: _notificationSwitch,
          ),
          backgroundIcon: Colors.amber,
        ),
        SettingsTile(
            label: 'Документы',
            icon: Icons.insert_drive_file_sharp,
            backgroundIcon: Colors.grey,
            callback: _toDocument
        ),
        SettingsTile(
          icon: Icons.exit_to_app_rounded,
          backgroundIcon: Colors.red,
          label: 'Выйти',
          callback: _exit,
        ),

      ],
    );
  }
}
