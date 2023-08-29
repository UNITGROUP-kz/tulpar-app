import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garage/data/models/dictionary/part_model.dart';
import 'package:garage/logic/bloc/dictionary/part_picker/part_picker_cubit.dart';
import 'package:garage/logic/bloc/user/details_car/details_car_cubit.dart';
import 'package:garage/presentation/routing/router.dart';
import 'package:garage/presentation/widgets/form/pickers/part_picker.dart';
import 'package:garage/presentation/widgets/screen_templates/screen_default_template.dart';
import 'package:garage/presentation/widgets/tiles/part_model.dart';

import '../../../../data/enums/fetch_status.dart';
import '../../../../data/models/dictionary/car_model.dart';
import '../../../widgets/form/fields/text_field.dart';
import '../../../widgets/navigation/header.dart';
import '../../../widgets/snackbars/error_snackbar.dart';

@RoutePage()
class DetailsCarScreen extends StatefulWidget {
  final CarModel car;

  const DetailsCarScreen({super.key, required this.car});

  @override
  State<DetailsCarScreen> createState() => _DetailsCarScreenState();
}

class _DetailsCarScreenState extends State<DetailsCarScreen> {
  late PartController _partController;

  @override
  void initState() {
    _partController = PartController()..addListener(_listenerPart);
    super.initState();
  }

  _listenerPart() {
    if(_partController.value.choseChild.isNotEmpty) {
      context.router.navigate(SplashRouter(
        children: [
          UserFormRouter(
            children: [
              CreateOrderRoute(part: _partController.value.choseChild.first, car: widget.car)
            ]
          )
        ]
      ));
    }
  }

  @override
  void dispose() {
    _partController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenDefaultTemplate(
        children: [
          Header(title: 'Машина'),
          PartPicker(controller: _partController, isMulti: false),
        ],
    );
  }
}
