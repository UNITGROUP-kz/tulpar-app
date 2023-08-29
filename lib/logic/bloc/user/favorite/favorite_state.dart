part of 'favorite_cubit.dart';

class FavoriteState extends Equatable {
  final List<FavoriteModel> favorites;
  const FavoriteState({
    this.favorites = const []
  });

  @override
  List<Object?> get props => [favorites];

  FavoriteState copyWith({
    List<FavoriteModel>? favorites
  }) {
    return FavoriteState(
        favorites: favorites ?? this.favorites
    );
  }
}
