import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotifycloneapp/common/helpers/is_dark_mode.dart';
import 'package:spotifycloneapp/core/configs/constants/app_urls.dart';
import 'package:spotifycloneapp/core/configs/theme/app_colors.dart';
import 'package:spotifycloneapp/domain/entities/song/song.dart';
import 'package:spotifycloneapp/presentation/home/bloc/news_songs_cubit.dart';
import 'package:spotifycloneapp/presentation/home/bloc/news_songs_state.dart';
import 'package:spotifycloneapp/presentation/song_player/pages/song_player.dart';

class NewsSongs extends StatelessWidget {
  const NewsSongs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsSongsCubit()..getNewsSongs(),
      child: SizedBox(
        height: 200,
        child: BlocBuilder<NewsSongsCubit, NewsSongsState>(
          builder: (context, state) {
            if (state is NewsSongsLoading) {
              return Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator());
            }
            if (state is NewsSongsLoaded) {
              return _songs(state.songs);
            }

            return Container();
          },
        ),
      ),
    );
  }

  Widget _songs(List<SongEntity> songs) {
    return ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SongPlayerPage(songEntity: songs[index],),));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 160,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    '${AppURLs.firestorage}${songs[index].artist.toLowerCase()}.jpg?${AppURLs.mediaAlt}'))),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            height: 40,
                            width: 40,
                            transform: Matrix4.translationValues(10, 10, 0),
                            child: Icon(
                              Icons.play_arrow_rounded,
                              color: context.isDarkmode ?   Color(0xff959595) : Color(0xff555555)
                            ),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: context.isDarkmode?  AppColors.darkGrey : Color(0xffE6E6E6)
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      songs[index].title,
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      songs[index].artist,
                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
                    )
                  ],
                ),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => SizedBox(
              width: 5,
            ),
        itemCount: songs.length);
  }
}
