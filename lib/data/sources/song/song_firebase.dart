import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotifycloneapp/data/models/song/song.dart';
import 'package:spotifycloneapp/domain/entities/song/song.dart';
import 'package:spotifycloneapp/domain/usecases/song/is_favorite_song.dart';
import 'package:spotifycloneapp/service_locator.dart';

abstract class SongFirebaseService {
  Future<Either> getNewsSongs();
  Future<Either> getPlayList();
  Future<Either> addOrRemoveFavoriteSong(String songId);
  Future<bool> isFavoriteSong(String songId);
  Future<Either> getUserFavoriteSongs();
}

class SongFirebaseServiceImpl extends SongFirebaseService {
  @override
  Future<Either> getNewsSongs() async {
    try {
      List<SongEntity> songs = [];
      var data = await FirebaseFirestore.instance
          .collection('Songs')
          .orderBy('releaseDate', descending: true)
          .limit(3)
          .get();

      for (var element in data.docs) {
        var songModel = SongModel.fromJson(element.data());
        bool isFavorite = await s1<IsFavoriteSongUseCase>().call(
          params:element.reference.id
        );
        songModel.isFavorite=isFavorite;
        songModel.songId = element.reference.id;
        songs.add(songModel.toEntitiy());
      }

      return Right(songs);

    } catch (e) {
     return  Left('An error occured , Please try again');
      
    }
  }
  
  @override
  Future<Either> getPlayList() async {
    try {
      List<SongEntity> songs = [];
      var data = await FirebaseFirestore.instance
          .collection('Songs')
          .orderBy('releaseDate', descending: true)
          .get();

      for (var element in data.docs) {
        var songModel = SongModel.fromJson(element.data());
        bool isFavorite = await s1<IsFavoriteSongUseCase>().call(
          params:element.reference.id
        );
        songModel.isFavorite=isFavorite;
        songModel.songId = element.reference.id;
        songs.add(songModel.toEntitiy());
      }

      return Right(songs);

    } catch (e) {
     return  Left('An error occured , Please try again');
      
    }
  }
  
  @override
  Future<Either> addOrRemoveFavoriteSong(String songId) async {
    try{
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final FirebaseFirestore firebaseFirestore= FirebaseFirestore.instance;

    var user = firebaseAuth.currentUser;
    String uId=user!.uid;

    late bool isFavorite;

     QuerySnapshot favoriteSongs = await firebaseFirestore.collection('Users').doc(uId).collection('Favorites').where('songId',isEqualTo:songId ).get();

     if (favoriteSongs.docs.isNotEmpty) {
       await favoriteSongs.docs.first.reference.delete();
       isFavorite=false;
     }else {
       await firebaseFirestore.collection('Users').doc(uId).collection('Favorites').add({
          'songId' : songId,
          'addedDate' : Timestamp.now()
        });
        isFavorite=true;
     }

     return Right(isFavorite);
  } catch(e){
    return Left('An error occurred');
  }
  }
  
  @override
  Future<bool> isFavoriteSong(String songId) async {
     try{
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final FirebaseFirestore firebaseFirestore= FirebaseFirestore.instance;

    var user = firebaseAuth.currentUser;
    String uId=user!.uid;

    late bool isFavorite;

     QuerySnapshot favoriteSongs = await firebaseFirestore.collection('Users').doc(uId).collection('Favorites').where('songId',isEqualTo:songId ).get();

     if (favoriteSongs.docs.isNotEmpty) {
      return true;
     }else {
       return false;
     }
  } catch(e){
    return false;
  }
  }
  
  @override
  Future<Either> getUserFavoriteSongs() async{
    try{
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final FirebaseFirestore firebaseFirestore= FirebaseFirestore.instance;

    var user = firebaseAuth.currentUser;
    List<SongEntity> favoriteSongs = [];
    String uId=user!.uid;
    QuerySnapshot favoriesSnapshot = await firebaseFirestore.collection(
      'Users'
    ).doc(uId).collection('Favorites').get();

    for(var element in favoriesSnapshot.docs){
      String songId = element['songId'];
      var song = await firebaseFirestore.collection('Songs').doc(songId).get();
      SongModel songModel = SongModel.fromJson(song.data()!);
      songModel.isFavorite = true;
      songModel .songId=songId;
      favoriteSongs.add(songModel.toEntitiy());

    
    }
    return Right(favoriteSongs);
  } catch(e){
    print("hata:"+e.toString());
    return Left('An error occurred');
  }
  }
}
