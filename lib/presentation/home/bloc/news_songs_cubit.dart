import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotifycloneapp/domain/usecases/song/get_news_songs.dart';
import 'package:spotifycloneapp/presentation/home/bloc/news_songs_state.dart';
import 'package:spotifycloneapp/service_locator.dart';

class NewsSongsCubit extends Cubit<NewsSongsState> {
  NewsSongsCubit() : super(NewsSongsLoading());

  Future<void> getNewsSongs() async {
    var returnedSongs = await s1<GetNewsSongsUseCase>().call();

    returnedSongs.fold((l) {
      emit(NewsSongsLoadFailure());
    }, (data) {
      emit(NewsSongsLoaded(songs: data));
    });
  }
}
