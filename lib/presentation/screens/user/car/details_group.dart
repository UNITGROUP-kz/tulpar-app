import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garage/data/models/dictionary/group_model.dart';
import 'package:garage/data/params/dictionary/index_part_params.dart';
import 'package:garage/logic/bloc/dictionary/part_picker/part_picker_cubit.dart';
import 'package:garage/presentation/widgets/screen_templates/screen_default_template.dart';
import '../../../../data/models/dictionary/car_model.dart';
import '../../../../data/models/dictionary/part_model.dart';
import '../../../routing/router.dart';
import '../../../widgets/navigation/header.dart';
import '../../../widgets/tiles/part_tile.dart';

@RoutePage()
class DetailsGroupScreen extends StatefulWidget {
  final GroupModel group;
  final CarModel car;

  const DetailsGroupScreen({super.key, required this.group, required this.car});

  @override
  State<DetailsGroupScreen> createState() => _DetailsGroupScreenState();
}

class _DetailsGroupScreenState extends State<DetailsGroupScreen> {
  double _scale = 1.0;
  Offset _position = Offset(0, 0);
  late Offset _startPosition;

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
                CreateOrderRoute(part: part, car: widget.car)
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
          child: GestureDetector(
            onScaleStart: (details) {
              _startPosition = _position;
            },
            onScaleUpdate: (ScaleUpdateDetails details) {
              double newScale = _scale * details.scale;
              if (newScale < 1.0) {
                newScale = 1.0;
              } else if (newScale > 3.0) {
                newScale = 3.0; // Здесь вы можете установить максимальный масштаб
              }

              double newX = _startPosition.dx + details.focalPoint.dx - details.localFocalPoint.dx;
              double newY = _startPosition.dy + details.focalPoint.dy - details.localFocalPoint.dy;

              if (newX < 0) {
                newX = 0;
              }
              if (newY < 0) {
                newY = 0;
              }

              // Размер экрана
              double screenWidth = MediaQuery.of(context).size.width;
              double screenHeight = MediaQuery.of(context).size.height;

              // Размер изображения
              double imageWidth = 200.0; // Замените на желаемую ширину изображения
              double imageHeight = 200.0; // Замените на желаемую высоту изображения

              if (newX + imageWidth * _scale > screenWidth) {
                newX = screenWidth - imageWidth * _scale;
              }
              if (newY + imageHeight * _scale > screenHeight) {
                newY = screenHeight - imageHeight * _scale;
              }


              setState(() {
                _scale = details.scale;
                _position = Offset(newX, newY);
              });
            },
            child: Transform.translate(
              offset: _position,
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: widget.group.image!,
                width: double.infinity,
                placeholder: (context, String val) => const CupertinoActivityIndicator(),
              ),
            ),
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
