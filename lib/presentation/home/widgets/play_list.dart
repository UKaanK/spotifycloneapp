import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotifycloneapp/common/helpers/is_dark_mode.dart';
import 'package:spotifycloneapp/common/widgets/favorite_button/favorite_button.dart';
import 'package:spotifycloneapp/core/configs/theme/app_colors.dart';
import 'package:spotifycloneapp/domain/entities/song/song.dart';
import 'package:spotifycloneapp/presentation/home/bloc/play_list_cubit.dart';
import 'package:spotifycloneapp/presentation/home/bloc/play_list_state.dart';
import 'package:spotifycloneapp/presentation/song_player/pages/song_player.dart';

class PlayList extends StatelessWidget {
  const PlayList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => PlayListCubit()..getPlayList(),
        child: BlocBuilder<PlayListCubit, PlayListState>(
          builder: (context, state) {
            if (state is PlayListLoading) {
              return Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              );
            }
            if (state is PlayListLoaded) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 40.0, horizontal: 16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Playlist",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "See more",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xffC6C6C6)),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    _songs(state.songs)
                  ],
                ),
              );
            }
            return Container();
          },
        ));
  }

  Widget _songs(List<SongEntity> songs) {
    return ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        SongPlayerPage(songEntity: songs[index]),
                  ));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: context.isDarkmode
                              ? AppColors.darkGrey
                              : Color(0xffE6E6E6)),
                      child: Icon(
                        Icons.play_arrow_rounded,
                        color: context.isDarkmode
                            ? Color(0xff959595)
                            : Color(0xff555555),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          songs[index].title,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          songs[index].artist,
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 11),
                        ),
                      ],
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(songs[index].duration.toString().replaceAll(".", ":")),
                    SizedBox(
                      width: 20,
                    ),
                   FavoriteButton(songEntity: songs[index])
                  ],
                )
              ],
            ),
          );
        },
        separatorBuilder: (context, index) => SizedBox(
              height: 20,
            ),
        itemCount: songs.length);
  }
}
