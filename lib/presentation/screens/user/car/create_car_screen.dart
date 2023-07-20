import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:garage/presentation/widgets/form/fields/car_model_picker.dart';
import 'package:garage/presentation/widgets/screen_templates/screen_default_template.dart';

import '../../../widgets/form/fields/producer_picker.dart';

@RoutePage()
class CreateCarScreen extends StatefulWidget {
  @override
  State<CreateCarScreen> createState() => _CreateCarScreenState();
}

class _CreateCarScreenState extends State<CreateCarScreen> {
  late TextEditingController _vinController;
  late ProducerController _producerController;
  late CarModelController _carModelController;

  @override
  void initState() {
    _vinController = TextEditingController();
    _producerController = ProducerController()..addListener(_listenerProducer);
    _carModelController = CarModelController();
    super.initState();
  }

  _listenerProducer() {
    _carModelController.remove();
  }

  @override
  void dispose() {
    _vinController.dispose();
    _producerController.removeListener(_listenerProducer);
    _producerController.dispose();
    _carModelController.dispose();
    super.dispose();
  }

  _create() {

  }

  @override
  Widget build(BuildContext context) {
    return ScreenDefaultTemplate(
      children: [
        TextField(controller: _vinController),
        ProducerPickerWidget(label: 'Producer', controller: _producerController),
        ValueListenableBuilder(
            valueListenable: _producerController,
            builder: (context, value, child) {
              if(value == null) return Container();

              return CarModelPickerWidget(label: 'Car model', producer: value, controller: _carModelController);
            }
        ),
        ElevatedButton(
            onPressed: _create,
            child: Text('create')
        )
      ],
    );
  }
}