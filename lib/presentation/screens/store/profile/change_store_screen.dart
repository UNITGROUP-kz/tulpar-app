import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garage/presentation/routing/router.dart';
import 'package:garage/presentation/widgets/builder/multi_value_listenable_builder.dart';
import 'package:garage/presentation/widgets/screen_templates/screen_default_template.dart';
import 'package:garage/presentation/widgets/snackbars/error_snackbar.dart';

import '../../../../data/enums/fetch_status.dart';
import '../../../../data/fform/forms/change_store_form.dart';
import '../../../../data/models/auth/store_model.dart';
import '../../../../data/params/store/change_store_params.dart';
import '../../../../logic/bloc/store/auth/auth_store_cubit.dart';
import '../../../../logic/bloc/store/change_store/change_store_cubit.dart';
import '../../../widgets/buttons/elevated_button.dart';
import '../../../widgets/navigation/header.dart';

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

  @override
  Widget build(BuildContext context) {
    return ScreenDefaultTemplate(
      children: [
        Header(title: 'Изменить магазин'),
        TextField(controller: _nameController),
        TextField(controller: _descriptionController),
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
                      child: Text('Change Store')
                  );
                }
            );
          },
        )
      ],
    );
  }
}
