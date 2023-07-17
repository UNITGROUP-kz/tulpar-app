import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garage/data/enums/fetch_status.dart';
import 'package:garage/data/models/car_model.dart';
import 'package:garage/logic/bloc/user/my_car/my_car_cubit.dart';
import 'package:garage/presentation/widgets/screen_templates/screen_default_template.dart';
import 'package:garage/presentation/widgets/snackbars/error_snackbar.dart';

@RoutePage()
class MyCarScreen extends StatefulWidget {

  @override
  State<MyCarScreen> createState() => _MyCarScreenState();
}

class _MyCarScreenState extends State<MyCarScreen> {

  @override
  void initState() {
    context.read<MyCarCubit>().fetch();
    super.initState();
  }

  Future _onRefresh() async {
    return await context.read<MyCarCubit>().fetch();
  }

  _listener(context, MyCarState state) {
    if(state.status == FetchStatus.error) {
      showErrorSnackBar(context, 'Ошибка');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenDefaultTemplate(
      onRefresh: _onRefresh,
      children: [
        BlocConsumer<MyCarCubit, MyCarState>(
          listener: _listener,
          builder: (context, state) {
            return Column(
              children: [
                if(state.status == FetchStatus.loading) CupertinoActivityIndicator(),
                if(state.status == FetchStatus.error) Text('Ошибка'),
                ...state.cars.map((car) {
                  return CarCard(car: car);
                }).toList()
              ]
            );
          },
        ),
        Container(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {},
                child: Text('Добавить машину')
            )
        ),

      ],
    );
  }
}

class CarCard extends StatelessWidget {
  final CarModel car;

  const CarCard({super.key, required this.car});


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(10)
      ),
      width: double.infinity,
      child: Column(
        children: [
          Text(car.name),
          Text(car.modelName),
          Text(car.vinNumber)
        ],
      ),
    );
  }

}