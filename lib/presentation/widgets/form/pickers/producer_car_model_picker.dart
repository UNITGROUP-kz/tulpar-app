import 'package:flutter/cupertino.dart';
import 'package:garage/presentation/widgets/form/pickers/car_model_picker.dart';
import 'package:garage/presentation/widgets/form/pickers/producer_picker.dart';
import 'package:garage/presentation/widgets/form/pickers/volume_picker.dart';
import 'package:garage/presentation/widgets/form/pickers/year_picker.dart';

class ProducerCarModelPicker extends StatefulWidget {
  final ProducerController producerController;
  final CarModelController carModelController;
  final YearController? yearController;
  final VolumeController? volumeController;


  const ProducerCarModelPicker({
    super.key,
    required this.producerController,
    required this.carModelController,
    this.yearController,
    this.volumeController
  });

  @override
  State<ProducerCarModelPicker> createState() => _ProducerCarModelPickerState();
}

class _ProducerCarModelPickerState extends State<ProducerCarModelPicker> {

  @override
  void initState() {
    widget.producerController.addListener(_listenerProducer);
    super.initState();
  }

  _listenerProducer() {
    widget.carModelController.remove();
  }

  @override
  void dispose() {
    widget.producerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProducerPickerWidget(
          label: 'Производитель',
          controller: widget.producerController,
          carModelController: widget.carModelController,
          yearController: widget.yearController,
          volumeController: widget.volumeController,
        ),
        const SizedBox(height: 10),
        ValueListenableBuilder(
            valueListenable: widget.producerController,
            builder: (context, value, child) {
              if(value == null) return Container();
              return CarModelPickerWidget(
                label: 'Модель машины',
                producer: value,
                controller: widget.carModelController,
                yearController: widget.yearController,
                volumeController: widget.volumeController,
              );
            }
        ),
      ],
    );
  }
}