import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garage/data/models/dictionary/part_model.dart';
import 'package:garage/data/params/order/create_order_params.dart';
import 'package:garage/logic/bloc/user/create_order/create_order_cubit.dart';
import 'package:garage/presentation/routing/router.dart';
import 'package:garage/presentation/widgets/builder/multi_value_listenable_builder.dart';
import 'package:garage/presentation/widgets/screen_templates/screen_default_template.dart';
import 'package:garage/presentation/widgets/snackbars/error_snackbar.dart';

import '../../../../data/enums/fetch_status.dart';
import '../../../../data/fform/forms/create_order_form.dart';
import '../../../../data/models/dictionary/car_model.dart';

@RoutePage()
class CreateOrderScreen extends StatefulWidget {

  final PartModel part;
  final CarModel car;

  const CreateOrderScreen({super.key, required this.part, required this.car});

  @override
  State<CreateOrderScreen> createState() => _CreateOrderScreenState();
}

class _CreateOrderScreenState extends State<CreateOrderScreen> {
  late TextEditingController _titleController;
  late TextEditingController _commentController;




  _createOrder() {
    if (_check()) {
      context.read<CreateOrderCubit>().create(CreateOrderParams(
          title: _titleController.value.text,
          comment: _commentController.value.text,
          car: widget.car,
          part: widget.part
      ));
    }
  }

  bool _check() {
    final form = CreateOrderForm.parse(title: _titleController.value.text);

    if (form.isInvalid) {
      form.exceptions.forEach((element) {
        showErrorSnackBar(context, element.toString());
      });
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
    _commentController = TextEditingController();
    super.initState();
  }

  _back() {
    context.router.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ScreenDefaultTemplate(
          children: [
            TextField(controller: _titleController),
            TextField(controller: _commentController),
            BlocConsumer<CreateOrderCubit, CreateOrderState>(
              listener: _listenerState,
              builder: (context, state) {
                if(state.status == FetchStatus.loading) {
                  return ElevatedButton(
                    onPressed: () {},
                    child: CupertinoActivityIndicator()
                  );
                }
                return MultiValueListenableBuilder(
                  valuesListenable: [
                    _titleController
                  ],
                  builder: (context, value, child) {
                    return ElevatedButton(
                        onPressed: value[0].text.isNotEmpty ? _createOrder : null,
                        child: Text('Create Order')
                    );
                  }
                );
              },
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: IconButton(onPressed: _back, icon: Icon(Icons.arrow_back_ios)),
        ),
      ],
    );
  }
}
