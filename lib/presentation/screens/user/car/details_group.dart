import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garage/data/models/dictionary/group_model.dart';
import 'package:garage/data/params/dictionary/index_part_params.dart';
import 'package:garage/logic/bloc/dictionary/part_picker/part_picker_cubit.dart';
import 'package:garage/presentation/widgets/screen_templates/screen_default_template.dart';
import '../../../../data/models/dictionary/car_api_model.dart';
import '../../../../data/models/dictionary/car_vin_model.dart';
import '../../../../data/models/dictionary/part_model.dart';
import '../../../routing/router.dart';
import '../../../widgets/navigation/header.dart';
import '../../../widgets/tiles/part_tile.dart';

@RoutePage()
class DetailsGroupScreen extends StatefulWidget {
  final GroupModel group;
  final CarApiModel? car;
  final CarVinModel? carVin;

  const DetailsGroupScreen({super.key, required this.group, this.car, this.carVin});

  @override
  State<DetailsGroupScreen> createState() => _DetailsGroupScreenState();
}

class _DetailsGroupScreenState extends State<DetailsGroupScreen> {

  @override
  void initState() {
    context.read<PartPickerCubit>().fetch(IndexPartParams(group: widget.group));
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }

  _onTapPart(PartModel part) => () {
    context.router.navigate(SplashRouter(
        children: [
          UserFormRouter(
              children: [
                CreateOrderRoute(part: part, car: widget.car, carVin: widget.carVin)
              ]
          )
        ]
    ));
  };


  @override
  Widget build(BuildContext context) {
    return ScreenDefaultTemplate(
      children: [
        Header(title: widget.group.name),
        if(widget.group.image != null) ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: widget.group.image!,
            width: double.infinity,
            placeholder: (context, String val) => const CupertinoActivityIndicator(),
          ),
        ),
        SizedBox(height: 20),
        BlocBuilder<PartPickerCubit, PartPickerState>(
          builder: (context, state) {
            return Column(
              children: state.parts.map((e) {
                return PartTile(part: e, callback: _onTapPart(e));
              }).toList(),
            );
          },
        )
      ],
    );
  }
}
