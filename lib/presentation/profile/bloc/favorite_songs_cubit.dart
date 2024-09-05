import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotifycloneapp/domain/entities/song/song.dart';
import 'package:spotifycloneapp/domain/usecases/song/get_favorite_songs.dart';
import 'package:spotifycloneapp/presentation/profile/bloc/favorite_songs_state.dart';
import 'package:spotifycloneapp/service_locator.dart';

class FavoriteSongsCubit extends Cubit<FavoriteSongsState>{
  FavoriteSongsCubit() : super(FavoriteSongsLoading());

  List<SongEntity> favoriteSongs=[];
  Future<void> getFavoriteSongs()async{
    var result = await s1<GetFavoriteSongsUseCase>().call();

    result.fold((l){
      emit(FavoriteSongsFailure());
    }, (r){
      favoriteSongs=r;
      emit(
        
        FavoriteSongsLoaded(favoritesSongs: favoriteSongs)
      );
    });
  }
  void removeSong(int index){
    favoriteSongs.removeAt(index);
    emit(
        
        FavoriteSongsLoaded(favoritesSongs: favoriteSongs)
      );
  }
}