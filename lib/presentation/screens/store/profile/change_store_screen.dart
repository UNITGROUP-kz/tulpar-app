import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garage/presentation/widgets/builder/multi_value_listenable_builder.dart';
import 'package:garage/presentation/widgets/form/fields/description_field.dart';
import 'package:garage/presentation/widgets/form/fields/text_field.dart';
import 'package:garage/presentation/widgets/screen_templates/screen_default_template.dart';
import 'package:garage/presentation/widgets/snackbars/error_snackbar.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../data/enums/fetch_status.dart';
import '../../../../data/fform/forms/change_store_form.dart';
import '../../../../data/models/auth/store_model.dart';
import '../../../../data/models/dictionary/city_model.dart';
import '../../../../data/params/change_image_params.dart';
import '../../../../data/params/store/change_store_params.dart';
import '../../../../logic/bloc/dictionary/current_city/current_city_cubit.dart';
import '../../../../logic/bloc/store/auth/auth_store_cubit.dart';
import '../../../../logic/bloc/store/change_image/change_image_cubit.dart';
import '../../../../logic/bloc/store/change_store/change_store_cubit.dart';
import '../../../routing/router.dart';
import '../../../widgets/bottomsheets/choose_image_picker.dart';
import '../../../widgets/buttons/elevated_button.dart';
import '../../../widgets/navigation/header.dart';
import '../../../widgets/tiles/setting_tile.dart';

@RoutePage()
class ChangeStoreScreen extends StatefulWidget {

  const ChangeStoreScreen({super.key});

  @override
  State<ChangeStoreScreen> createState() => _ChangeStoreScreenState();
}

class _ChangeStoreScreenState extends State<ChangeStoreScreen> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;

  _change() {
    if (_check()) {
      context.read<ChangeStoreCubit>().change(ChangeStoreParams(
          name: _nameController.value.text,
          description: _descriptionController.value.text,
      ));
    }
  }

  bool _check() {
    final form = ChangeStoreForm.parse(
        name: _nameController.value.text,
        description: _descriptionController.value.text,
    );

    if (form.isInvalid) {
      for (var element in form.exceptions) {
        showErrorSnackBar(context, element.toString());
      }
    }

    return form.isValid;
  }

  _listenerState(BuildContext context, ChangeStoreState state) {
    if(state.status == FetchStatus.error) {
      showErrorSnackBar(context, state.error?.messages[0] ?? 'Неизвестная ошибка');
    } else if(state.status == FetchStatus.success) {
      context.router.pop();
    }
  }

  @override
  void initState() {
    StoreModel? store = context.read<AuthStoreCubit>().state.store;
    _nameController = TextEditingController(text: store?.name ?? '');
    _descriptionController = TextEditingController(text: store?.description ?? '');
    super.initState();
  }

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

    context.read<ChangeImageStoreCubit>().change(ChangeImageParams(imageMF), bytes);

    context.router.pop();
  };


  _listenerImage(BuildContext context, ChangeImageStoreState state) {
    if(state.status == FetchStatus.error) {
      showErrorSnackBar(context, state.error?.messages[0] ?? 'Неизвестная ошибка');
    }
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

  @override
  Widget build(BuildContext context) {
    return ScreenDefaultTemplate(
      children: [
        Header(title: 'Изменить магазин'),
        BlocBuilder<AuthStoreCubit, AuthStoreState>(
          builder: (context, authState) {
            return BlocConsumer<ChangeImageStoreCubit, ChangeImageStoreState>(
              listener: _listenerImage,
              builder: (context, state) {
                return InkWell(
                  customBorder: const CircleBorder(),
                  onTap: _showChooseImage,
                  child: ClipOval(
                    child: Container(
                      color: Colors.grey.shade200,
                      width: MediaQuery.of(context).size.width * 0.35,
                      height: MediaQuery.of(context).size.width * 0.35,
                      child: state.bytes == null ? CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: authState.store?.image ?? '',
                        placeholder: (context, String val) => const CupertinoActivityIndicator(),
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
        TextFieldWidget(label: 'Название', controller: _nameController),
        SizedBox(height: 10),
        DescriptionFieldWidget(label: 'Описание', controller: _descriptionController),
        SizedBox(height: 10),
        SettingsTile(label: 'Изменить свои услуги', icon: Icons.handyman),
        // SizedBox(height: 5),
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
        SizedBox(height: 20),


        BlocConsumer<ChangeStoreCubit, ChangeStoreState>(
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
                  _descriptionController,
                ],
                builder: (context, value, child) {
                  bool isVisible = value[0].text.isNotEmpty && value[1].text.isNotEmpty;
                  return ElevatedButtonWidget(
                      onPressed: isVisible ? _change : null,
                      child: Text('Изменить магазин')
                  );
                }
            );
          },
        ),
      ],
    );
  }
}
