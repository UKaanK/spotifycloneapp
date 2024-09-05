import 'package:dartz/dartz.dart';
import 'package:spotifycloneapp/data/sources/song/song_firebase.dart';
import 'package:spotifycloneapp/domain/repository/song/song.dart';
import 'package:spotifycloneapp/service_locator.dart';

class SongRepositoryImpl extends SongsRepository{
  @override
  Future<Either> getNewsSongs() async{
    return await s1<SongFirebaseService>().getNewsSongs();
  }
  
  @override
  Future<Either> getPlayList() async {
    return await s1<SongFirebaseService>().getPlayList();
  }
  
  @override
  Future<Either> addOrRemoveFavoriteSongs(String songId) async {
    return await s1<SongFirebaseService>().addOrRemoveFavoriteSong(songId);
  }
  
  @override
  Future<bool> isFavoriteSong(String songId) async {
    return await s1<SongFirebaseService>().isFavoriteSong(songId);
  }
  
  @override
  Future<Either> getUserFavoriteSongs() async {
    return await s1<SongFirebaseService>().getUserFavoriteSongs();
  }

}