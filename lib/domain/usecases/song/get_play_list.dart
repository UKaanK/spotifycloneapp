import 'package:dartz/dartz.dart';
import 'package:spotifycloneapp/core/configs/usercase/usercase.dart';
import 'package:spotifycloneapp/data/models/auth/create_user_req.dart';
import 'package:spotifycloneapp/data/repository/song/song_repository_impl.dart';
import 'package:spotifycloneapp/domain/repository/auth/auth.dart';
import 'package:spotifycloneapp/domain/repository/song/song.dart';
import 'package:spotifycloneapp/service_locator.dart';

class GetPlayListUseCase implements UseCase<Either,dynamic>{
  @override
  Future<Either> call({params}) async{
    return await s1<SongsRepository>().getPlayList();
  }

  
}