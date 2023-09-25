import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:garage/presentation/widgets/form/pickers/car_picker.dart';
import 'package:uuid/uuid.dart';

import 'package:garage/presentation/widgets/buttons/elevated_button.dart';
import 'package:garage/presentation/widgets/form/pickers/car_model_picker.dart';
import 'package:garage/presentation/widgets/form/pickers/producer_car_model_picker.dart';
import 'package:garage/presentation/widgets/form/pickers/producer_picker.dart';


class MultiProducerCarModelValue {
  late String id;
  ProducerController producerController;
  CarModelController carModelController;
  CarApiController carApiController;
  bool update;

  MultiProducerCarModelValue({
    required this.producerController,
    required this.carModelController,
    required this.carApiController,
    this.update = true
  }) {
    id = const Uuid().v1();
  }
}

class MultiProducerCarModelController extends ValueNotifier<List<MultiProducerCarModelValue>> {
  MultiProducerCarModelController({List<MultiProducerCarModelValue>? value}) : super(value
      ?? [ MultiProducerCarModelValue(
          producerController: ProducerController(),
          carModelController: CarModelController(),
          carApiController: CarApiController()
        )
      ]
  ) {
    for (var element in this.value) {
      element.producerController.addListener(_changeProducer(element.carModelController, element.carApiController));
      element.carModelController.addListener(_changeModel(element.carApiController));
      element.carApiController.addListener(_changeCar(element));
    }
  }

  _add() {
    CarApiController carApiController = CarApiController();
    CarModelController carModelController = CarModelController()..addListener(_changeModel(carApiController));
    ProducerController producerController = ProducerController()..addListener(_changeProducer(carModelController, carApiController));
    MultiProducerCarModelValue value = MultiProducerCarModelValue(
        producerController: producerController,
        carModelController: carModelController,
        carApiController: carApiController
    );
    carApiController.addListener(_changeCar(value));


    this.value.add(value);

    notifyListeners();
  }

  _changeProducer(CarModelController controller, CarApiController carApiController) => () {
    controller.remove();
    carApiController.remove();
    notifyListeners();
  };

  _changeModel(CarApiController carApiController) => () {
    carApiController.remove();
    notifyListeners();
  };

  _changeCar(MultiProducerCarModelValue value) => () {
    if(value.carApiController.value != null) value.update = false;
    notifyListeners();
  };

  _edit(MultiProducerCarModelValue value ) {
    this.value = this.value.map<MultiProducerCarModelValue>((element) {
      if(value.id == element.id) {
        return value..update = true;
      }
      return element;
    }).toList();
    notifyListeners();
  }

  @override
  void dispose() {
    for (var element in value) {
      element.producerController.removeListener(_changeProducer(element.carModelController, element.carApiController));
      element.carModelController.removeListener(_changeModel(element.carApiController));
      element.carApiController.removeListener(_changeCar(element));
      element.producerController.dispose();
      element.carModelController.dispose();
      element.carApiController.dispose();
    }
    super.dispose();
  }
}

class MultiProducerCarModelPicker extends StatefulWidget {
  MultiProducerCarModelController? controller;

  MultiProducerCarModelPicker({super.key, this.controller});

  @override
  State<MultiProducerCarModelPicker> createState() => _MultiProducerCarModelPickerState();
}

class _MultiProducerCarModelPickerState extends State<MultiProducerCarModelPicker> {

  _addController() {
    widget.controller?._add();
  }

  _edit(MultiProducerCarModelValue value) => () {
    widget.controller?._edit(value);
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ValueListenableBuilder(
        builder: (context, value, child) {
          return Column(
            children: [
              ...value.map((e) {
                return Column(
                  children: [
                    if(e.update) ProducerCarModelPicker(
                      producerController: e.producerController,
                      carModelController: e.carModelController,
                    )
                    else IntrinsicHeight(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(e.producerController.value?.name ?? ''),
                                Text(e.carModelController.value?.name ?? ''),
                              ],
                            ),
                            GestureDetector(
                              onTap: _edit(e),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.primary,
                                    borderRadius: BorderRadius.circular(5)
                                ),
                                width: 30,
                                height: 30,
                                child: Icon(Icons.edit, size: 20, color: Colors.white),
                              ),
                            ),
                          ],
                      ),
                    ),
                    Divider(height: 20, thickness: 1,),
                  ],
                );
              }).toList(),
              SizedBox(height: 10),
              ElevatedButtonWidget(child: Text('Добавить машину'), onPressed: _addController)
            ],
          );
        }, valueListenable: widget.controller!,
      ),
    );
  }

  @override
  void initState() {
    widget.controller ??= MultiProducerCarModelController();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant MultiProducerCarModelPicker oldWidget) {
    widget.controller ??= oldWidget.controller;
    super.didUpdateWidget(oldWidget);
  }
}