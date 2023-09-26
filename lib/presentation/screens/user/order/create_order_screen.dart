import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garage/data/models/dictionary/car_api_model.dart';
import 'package:garage/data/models/dictionary/group_model.dart';
import 'package:garage/data/models/dictionary/part_model.dart';
import 'package:garage/data/params/order/create_order_params.dart';
import 'package:garage/logic/bloc/user/create_order/create_order_cubit.dart';
import 'package:garage/presentation/routing/router.dart';
import 'package:garage/presentation/screens/picker/lat_lon_picker.dart';
import 'package:garage/presentation/widgets/builder/multi_value_listenable_builder.dart';
import 'package:garage/presentation/widgets/form/fields/description_field.dart';
import 'package:garage/presentation/widgets/screen_templates/screen_default_template.dart';
import 'package:garage/presentation/widgets/snackbars/error_snackbar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../data/enums/fetch_status.dart';
import '../../../../data/fform/forms/create_order_form.dart';
import '../../../../data/models/dictionary/car_model.dart';
import '../../../widgets/buttons/elevated_button.dart';
import '../../../widgets/form/fields/text_field.dart';
import '../../../widgets/form/pickers/city_picker.dart';
import '../../../widgets/navigation/header.dart';

@RoutePage()
class CreateOrderScreen extends StatefulWidget {

  final PartModel part;
  final CarApiModel car;

  const CreateOrderScreen({super.key, required this.part, required this.car});

  @override
  State<CreateOrderScreen> createState() => _CreateOrderScreenState();
}

class _CreateOrderScreenState extends State<CreateOrderScreen> {
  late LatLonController _mapController;
  late TextEditingController _titleController;
  late TextEditingController _commentController;
  late CityController _cityController;

  _createOrder() {
    if (_check()) {
      context.read<CreateOrderCubit>().create(CreateOrderParams(
          title: _titleController.value.text,
          comment: _commentController.value.text,
          car: widget.car,
          part: widget.part,
          city: _cityController.value!
      ));
    }
  }

  bool _check() {
    final form = CreateOrderForm.parse(title: _titleController.value.text);

    if (form.isInvalid) {
      for (var element in form.exceptions) {
        showErrorSnackBar(context, element.toString());
      }
    }

    return form.isValid;
  }

  _listenerState(BuildContext context, CreateOrderState state) {
    if(state.status == FetchStatus.error) {
      showErrorSnackBar(context, state.error?.messages[0] ?? 'Неизвестная ошибка');
    } else if(state.status == FetchStatus.success) {
      context.router.navigate(SplashRouter(
        children: [
          UserRouter(
            children: [
              UserOrderRouter(
                  children: [
                    OrdersRoute()
                  ]
              )
            ]
          )
        ]
      ));
    }
  }

  @override
  void initState() {
    _titleController = TextEditingController();
    _cityController = CityController();
    _commentController = TextEditingController();
    _mapController = LatLonController();
    super.initState();
  }

  @override
  void dispose() {
    _mapController.dispose();
    _titleController.dispose();
    _commentController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenDefaultTemplate(
      children: [
        Header(title: 'Создать заказ'),

        TextFieldWidget(
            isRequired: true,
            label: 'Заголовок',
            controller: _titleController
        ),
        SizedBox(height: 10),
        DescriptionFieldWidget(
            isRequired: true,
            label: 'Описание',
            controller: _commentController
        ),
        SizedBox(height: 10),
        CityPickerWidget(
          label: 'Город',
          controller: _cityController
        ),
        SizedBox(height: 10),
        MapPicker(controller: _mapController),
        SizedBox(height: 10),
        BlocConsumer<CreateOrderCubit, CreateOrderState>(
          listener: _listenerState,
          builder: (context, state) {
            if(state.status == FetchStatus.loading) {
              return ElevatedButtonWidget(
                onPressed: () {},
                child: CupertinoActivityIndicator(color: Colors.black45)
              );
            }
            return MultiValueListenableBuilder(
              valuesListenable: [
                _titleController,
                _commentController,
                _cityController,
                _mapController
              ],
              builder: (context, value, child) {
                final isValid = value[0].text.isNotEmpty
                    && value[1].text.isNotEmpty
                    && value[2] != null
                    && value[3] != null;
                return ElevatedButtonWidget(
                    onPressed: isValid ? _createOrder : null,
                    child: const Text('Создать заказ')
                );
              }
            );
          },
        )
      ],
    );
  }
}
