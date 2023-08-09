import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garage/data/params/profile/support_params.dart';
import 'package:garage/logic/bloc/user/support/support_cubit.dart';
import 'package:garage/presentation/widgets/form/fields/description_field.dart';
import 'package:garage/presentation/widgets/form/fields/text_field.dart';
import 'package:garage/presentation/widgets/screen_templates/screen_default_template.dart';

import '../../../../data/enums/fetch_status.dart';
import '../../../widgets/builder/multi_value_listenable_builder.dart';
import '../../../widgets/buttons/elevated_button.dart';
import '../../../widgets/navigation/header.dart';
import '../../../widgets/snackbars/error_snackbar.dart';

@RoutePage()
class SupportScreen extends StatefulWidget {
  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;


  _create() {
    context.read<SupportCubit>().create(SupportParams(
      title: _titleController.value.text,
      description: _descriptionController.value.text
    ));
  }

  _listenerState(BuildContext context, SupportState state) {
    if(state.status == FetchStatus.error) {
      showErrorSnackBar(context, state.error?.messages[0] ?? 'Неизвестная ошибка');
    } else if(state.status == FetchStatus.success) {
      context.router.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenDefaultTemplate(
      children: [
        Header(title: 'Помощь'),

        TextFieldWidget(label: 'Заголовок', controller: _titleController, isRequired: true),
        SizedBox(height: 10),
        DescriptionFieldWidget(controller: _descriptionController, label: 'Описание', isRequired: true),
        SizedBox(height: 10),
        BlocConsumer<SupportCubit, SupportState>(
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
                  _titleController,
                  _descriptionController,
                ],
                builder: (context, value, child) {
                  bool isVisible = value[0].text.isNotEmpty && value[1].text.isNotEmpty;
                  return ElevatedButtonWidget(
                      onPressed: isVisible ? _create : null,
                      child: Text('Изменить профиль')
                  );
                }
            );
          },
        ),
      ],
    );
  }

  @override
  void initState() {
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}