import 'package:spotifycloneapp/domain/entities/song/song.dart';

abstract class FavoriteSongsState{}

class FavoriteSongsLoading extends FavoriteSongsState{}

class FavoriteSongsLoaded extends   FavoriteSongsState{
  final List<SongEntity> favoritesSongs;

  FavoriteSongsLoaded({required this.favoritesSongs});


}

class FavoriteSongsFailure extends FavoriteSongsState{
  
}

