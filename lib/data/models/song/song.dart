import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spotifycloneapp/domain/entities/song/song.dart';

class SongModel {
  String? title;
  String? artist;
  num? duration;
  Timestamp? releaseDate;
  bool? isFavorite;
  String ? songId;

  SongModel(
      {required this.title,
      required this.artist,
      required this.duration,
      required this.releaseDate,
      required this.isFavorite,
      required this.songId});

  SongModel.fromJson(Map<String, dynamic> data) {
    title = data['title'];
    artist = data['artist'];
    // duration alanını doğru türde almak için kontrol ediyoruz
    if (data['duration'] is String) {
      duration = num.tryParse(data['duration']);
    } else {
      duration = data['duration'];
    }
    releaseDate = data['releaseDate'];
  }
}

extension SongModelX on SongModel {
  SongEntity toEntitiy() {
    return SongEntity(
        title: title!,
        artist: artist!,
        duration: duration!,
        releaseDate: releaseDate!,
        isFavorite: isFavorite!,
        songId: songId!);
  }
}
