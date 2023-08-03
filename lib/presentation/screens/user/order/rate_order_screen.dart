import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garage/data/models/error_model.dart';
import 'package:garage/presentation/widgets/navigation/header.dart';
import 'package:garage/presentation/widgets/snackbars/error_snackbar.dart';

import '../../../../data/models/dictionary/order_model.dart';
import '../../../../logic/bloc/user/details_order/details_order_cubit.dart';
import '../../../widgets/buttons/elevated_button.dart';
import '../../../widgets/form/pickers/star_picker.dart';
import '../../../widgets/screen_templates/screen_default_template.dart';
import '../../../widgets/tiles/store_tile.dart';


@RoutePage()
class RateOrderScreen extends StatefulWidget {

  final OrderModel order;

  const RateOrderScreen({super.key, required this.order});

  @override
  State<RateOrderScreen> createState() => _RateOrderScreenState();
}

class _RateOrderScreenState extends State<RateOrderScreen> {
  late StarPickerController _starPickerController;

  @override
  void initState() {
    _starPickerController = StarPickerController();
    super.initState();
  }

  @override
  void dispose() {
    _starPickerController.dispose();
    super.dispose();
  }

  _rate() {
    context.read<DetailsOrderCubit>().rate(widget.order.id, _starPickerController.value).then((value) {
      _back();
    }).catchError((error) {
      _back();
      showErrorSnackBar(context, ErrorModel.parse(error).messages[0]);
    });
  }

  _back() {
    context.router.pop();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenDefaultTemplate(
      children: [
        Header(title: 'Оценить'),
        if(widget.order.store != null) StoreTile(store: widget.order.store!),
        StarPicker(
          controller: _starPickerController,
        ),
        SizedBox(height: 10,),
        ElevatedButtonWidget(child: Text('Оценить'), onPressed: _rate),
      ],
    );
  }
}