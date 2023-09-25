import 'package:flutter/cupertino.dart';
import 'package:garage/presentation/widgets/form/pickers/car_model_picker.dart';
import 'package:garage/presentation/widgets/form/pickers/producer_picker.dart';
import 'package:garage/presentation/widgets/form/pickers/volume_picker.dart';
import 'package:garage/presentation/widgets/form/pickers/year_picker.dart';

import 'car_picker.dart';

class ProducerCarModelPicker extends StatefulWidget {
  ProducerController? producerController;
  CarModelController? carModelController;
  CarApiController? carApiController;


  ProducerCarModelPicker({
    super.key,
    this.producerController,
    this.carModelController,
    this.carApiController
  });

  @override
  State<ProducerCarModelPicker> createState() => _ProducerCarModelPickerState();
}

class _ProducerCarModelPickerState extends State<ProducerCarModelPicker> {

  @override
  void initState() {
    widget.producerController ??= ProducerController();
    widget.carModelController ??= CarModelController();
    widget.carApiController ??= CarApiController();
    widget.producerController?.addListener(_listenerProducer);
    widget.carModelController?.addListener(_listenerModel);

    super.initState();
  }

  _listenerProducer() {
    widget.carModelController?.remove();
    widget.carApiController?.remove();
  }

  _listenerModel() {
    widget.carApiController?.remove();
  }

  @override
  void dispose() {
    widget.producerController?.removeListener(_listenerProducer);
    widget.carApiController?.removeListener(_listenerModel);

    super.dispose();
  }

  @override
  void didUpdateWidget(covariant ProducerCarModelPicker oldWidget) {
    widget.producerController ??= oldWidget.producerController;
    widget.carModelController ??= oldWidget.carModelController;
    widget.carApiController ??= oldWidget.carApiController;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProducerPickerWidget(
          label: 'Производитель',
          controller: widget.producerController,
          carModelController: widget.carModelController,
          carApiController: widget.carApiController,
        ),
        const SizedBox(height: 10),
        ValueListenableBuilder(
            valueListenable: widget.producerController!,
            builder: (context, value, child) {
              if(value == null) return Container();
              return CarModelPickerWidget(
                label: 'Модель машины',
                producer: value,
                controller: widget.carModelController,
                carApiController: widget.carApiController,
              );
            }
        ),
        const SizedBox(height: 10),
        ValueListenableBuilder(
            valueListenable: widget.carModelController!,
            builder: (context, value, child) {
              if(value == null) return Container();
              return CarApiPickerWidget(
                label: 'Машина',
                controller: widget.carApiController,
                producer: widget.producerController!.value!,
                carModel: value,
              );
            }
        ),
      ],
    );
  }
}