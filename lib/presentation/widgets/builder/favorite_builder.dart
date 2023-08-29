import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garage/logic/bloc/user/favorite/favorite_cubit.dart';

class FavoriteBuilder extends StatelessWidget {
  final int carId;

  const FavoriteBuilder({super.key, required this.carId});

  _onTap(BuildContext context) => () {
    context.read<FavoriteCubit>().toggle(carId);
  };

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteCubit, FavoriteState>(
      builder: (context, state) {
          final isFavorite = state.favorites.any((element) => element.carId == carId);
          return GestureDetector(
              onTap: _onTap(context),
              child: Icon(Icons.star, color: isFavorite? Colors.yellow.shade700: Colors.grey.shade500,)
          );
      },
    );
  }

}