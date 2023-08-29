import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garage/data/models/dictionary/order_model.dart';
import 'package:garage/presentation/widgets/form/fields/number_field.dart';

import '../../../../core/utils/parser.dart';
import '../../../../data/enums/fetch_status.dart';
import '../../../../data/fform/forms/create_offer_form.dart';
import '../../../../data/params/offers/create_offer_params.dart';
import '../../../../logic/bloc/store/create_offer/create_offer_cubit.dart';
import '../../../routing/router.dart';
import '../../../widgets/builder/multi_value_listenable_builder.dart';
import '../../../widgets/buttons/elevated_button.dart';
import '../../../widgets/form/fields/description_field.dart';
import '../../../widgets/form/fields/text_field.dart';
import '../../../widgets/form/pickers/condition_picker.dart';
import '../../../widgets/navigation/header.dart';
import '../../../widgets/screen_templates/screen_default_template.dart';
import '../../../widgets/snackbars/error_snackbar.dart';

@RoutePage()
class CreateOfferScreen extends StatefulWidget {
  
  final OrderModel order;

  const CreateOfferScreen({super.key, required this.order});

  @override
  State<CreateOfferScreen> createState() => _CreateOfferScreenState();
}

class _CreateOfferScreenState extends State<CreateOfferScreen> {
  late TextEditingController _priceController;
  late TextEditingController _producerController;
  late TextEditingController _deliveryController;
  late ConditionPickerController _conditionPickerController;

  _createOffer() {
    if (_check()) {
      context.read<CreateOfferCubit>().create(CreateOfferParams(
          order: widget.order,
          price: Parser.toDouble(_priceController.value.text),
          producer: _producerController.value.text,
          delivery: _deliveryController.value.text,
          condition: _conditionPickerController.value
      ));
    }
  }

  bool _check() {
    final form = CreateOfferForm.parse(
      delivery: _deliveryController.value.text,
      producer: _producerController.value.text,
      price: _priceController.value.text
    );

    if (form.isInvalid) {
      for (var element in form.exceptions) {
        showErrorSnackBar(context, element.toString());
      }
    }

    return form.isValid;
  }

  _listenerState(BuildContext context, CreateOfferState state) {
    if(state.status == FetchStatus.error) {
      showErrorSnackBar(context, state.error?.messages[0] ?? 'Неизвестная ошибка');
    } else if(state.status == FetchStatus.success) {
      // context.router.navigate(SplashRouter(
      //     children: [
      //       StoreRouter(
      //           children: [
      //             UserOfferRouter(
      //                 children: [
      //                   OffersRoute()
      //                 ]
      //             )
      //           ]
      //       )
      //     ]
      // ));
    }
  }

  @override
  void initState() {
    _producerController = TextEditingController();
    _priceController = TextEditingController();
    _deliveryController = TextEditingController();
    _conditionPickerController = ConditionPickerController();
    super.initState();
  }

  @override
  void dispose() {
    _producerController.dispose();
    _priceController.dispose();
    _deliveryController.dispose();
    _conditionPickerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenDefaultTemplate(
      children: [
        Header(title: 'Создать предложение'),
        TextFieldWidget(
            isRequired: true,
            label: 'Производитель',
            controller: _producerController
        ),
        SizedBox(height: 10),
        DescriptionFieldWidget(
            isRequired: true,
            label: 'Описание доставки',
            controller: _deliveryController
        ),
        SizedBox(height: 10),
        NumberField(
            label: 'Цена',
            isRequired: true,
            controller: _priceController
        ),
        SizedBox(height: 10),
        ConditionPicker(controller: _conditionPickerController),
        SizedBox(height: 10),
        BlocConsumer<CreateOfferCubit, CreateOfferState>(
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
                  _producerController,
                  _deliveryController,
                  _priceController
                ],
                builder: (context, value, child) {
                  return ElevatedButtonWidget(
                      onPressed: value[0].text.isNotEmpty && value[1].text.isNotEmpty && value[2].text.isNotEmpty ? _createOffer : null,
                      child: Text('Создать предложение')
                  );
                }
            );
          },
        )
      ],
    );
  }
}