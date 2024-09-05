import 'package:get_it/get_it.dart';
import 'package:spotifycloneapp/data/repository/auth/auth_repository_impl.dart';
import 'package:spotifycloneapp/data/repository/song/song_repository_impl.dart';
import 'package:spotifycloneapp/data/sources/auth/auth_firebase_service.dart';
import 'package:spotifycloneapp/data/sources/song/song_firebase.dart';
import 'package:spotifycloneapp/domain/repository/auth/auth.dart';
import 'package:spotifycloneapp/domain/repository/song/song.dart';
import 'package:spotifycloneapp/domain/usecases/auth/get_user.dart';
import 'package:spotifycloneapp/domain/usecases/auth/signin.dart';
import 'package:spotifycloneapp/domain/usecases/auth/signup.dart';
import 'package:spotifycloneapp/domain/usecases/song/add_or_remove_favorite_song.dart';
import 'package:spotifycloneapp/domain/usecases/song/get_favorite_songs.dart';
import 'package:spotifycloneapp/domain/usecases/song/get_news_songs.dart';
import 'package:spotifycloneapp/domain/usecases/song/get_play_list.dart';
import 'package:spotifycloneapp/domain/usecases/song/is_favorite_song.dart';

final s1 = GetIt.instance;

Future<void> initializeDependencies() async {
  s1.registerSingleton<AuthFirebaseService>(
    AuthFirebaseServiceImpl(),
  );
  s1.registerSingleton<SongFirebaseService>(
    SongFirebaseServiceImpl(),
  );
  s1.registerSingleton<AuthRepository>(
    AuthRepositoryImpl()
  );

  s1.registerSingleton<SongsRepository>(
    SongRepositoryImpl()
  );

  s1.registerSingleton<SignupUseCase>(
    SignupUseCase()
  );
  s1.registerSingleton<SigninUseCase>(
    SigninUseCase()
  );

  s1.registerSingleton<GetNewsSongsUseCase>(
    GetNewsSongsUseCase()
  );
  
  s1.registerSingleton<GetPlayListUseCase>(
    GetPlayListUseCase()
  );

  s1.registerSingleton<AddOrRemoveFavoriteSongUseCase>(
    AddOrRemoveFavoriteSongUseCase()
  );

  s1.registerSingleton<IsFavoriteSongUseCase>(
    IsFavoriteSongUseCase()
  );

  s1.registerSingleton<GetUserUseCase>(
    GetUserUseCase()
  );

  s1.registerSingleton<GetFavoriteSongsUseCase>(
    GetFavoriteSongsUseCase()
  );
}
