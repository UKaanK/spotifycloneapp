import 'dart:ffi';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotifycloneapp/common/bloc/favorite_button/favorite_button_state.dart';
import 'package:spotifycloneapp/domain/usecases/song/add_or_remove_favorite_song.dart';
import 'package:spotifycloneapp/service_locator.dart';

class FavoriteButtonCubit extends Cubit<FavoriteButtonState>{
  FavoriteButtonCubit() : super(FavoriteButtonInitial());

  Future<void> favoriteButtonUpdated(String songId) async {
    var result = await s1<AddOrRemoveFavoriteSongUseCase>().call(
      params: songId
    );

    result.fold(
      (l) => null,
       (isFavorite) {
         emit(
          FavoriteButtonUpdated(
            isFavorite: isFavorite
          )
         );
       }
       );
  }
}