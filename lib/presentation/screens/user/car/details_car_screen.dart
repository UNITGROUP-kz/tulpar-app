import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:garage/presentation/routing/router.dart';
import 'package:garage/presentation/widgets/form/pickers/group_picker.dart';
import 'package:garage/presentation/widgets/screen_templates/screen_default_template.dart';
import '../../../../data/models/dictionary/car_api_model.dart';
import '../../../../data/models/dictionary/car_vin_model.dart';
import '../../../widgets/navigation/header.dart';

@RoutePage()
class DetailsCarScreen extends StatefulWidget {
  final CarApiModel? car;
  final CarVinModel? carVin;

  const DetailsCarScreen({super.key, this.car, this.carVin});

  @override
  State<DetailsCarScreen> createState() => _DetailsCarScreenState();
}

class _DetailsCarScreenState extends State<DetailsCarScreen> {
  late GroupController _groupController;

  @override
  void initState() {
    _groupController = GroupController()..addListener(_listenerGroup);
    super.initState();
  }

  _listenerGroup() {
    if(_groupController.value.choseChild.isNotEmpty) {
      context.router.navigate(SplashRouter(
        children: [
          UserRouter(
            children: [
              UserCarRouter(
                  children: [
                    DetailsGroupRoute(
                        group: _groupController.value.choseChild.first,
                        car: widget.car,
                        carVin: widget.carVin
                    )
                  ]
              )
            ]
          )
        ]
      ));
    }
  }

  @override
  void dispose() {
    _groupController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenDefaultTemplate(
        children: [
          Header(title: widget.car?.name ?? widget.carVin?.title ?? 'Машина'),
          GroupPicker(controller: _groupController, isMulti: false, car: widget.car),
        ],
    );
  }
}
