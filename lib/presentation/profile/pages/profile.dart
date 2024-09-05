import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotifycloneapp/common/bloc/favorite_button/favorite_button_cubit.dart';
import 'package:spotifycloneapp/common/helpers/is_dark_mode.dart';
import 'package:spotifycloneapp/common/widgets/appbar/app_bar.dart';
import 'package:spotifycloneapp/common/widgets/favorite_button/favorite_button.dart';
import 'package:spotifycloneapp/core/configs/constants/app_urls.dart';
import 'package:spotifycloneapp/core/configs/theme/app_colors.dart';
import 'package:spotifycloneapp/domain/entities/song/song.dart';
import 'package:spotifycloneapp/presentation/profile/bloc/favorite_songs_cubit.dart';
import 'package:spotifycloneapp/presentation/profile/bloc/favorite_songs_state.dart';
import 'package:spotifycloneapp/presentation/profile/bloc/profile_info_cubit.dart';
import 'package:spotifycloneapp/presentation/profile/bloc/profile_info_state.dart';
import 'package:spotifycloneapp/presentation/song_player/pages/song_player.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        backgroundColor: context.isDarkmode ? Color(0xff2C2B2B) : Colors.white,
        title: Text("Profile"),
      ),
      body: Column(
        children: [
          _profileInfo(context),
          SizedBox(
            height: 30,
          ),
          _favoriteSongs()
        ],
      ),
    );
  }

  Widget _profileInfo(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileInfoCubit()..getUser(),
      child: Container(
        height: MediaQuery.of(context).size.height / 3.5,
        width: double.infinity,
        decoration: BoxDecoration(
            color: context.isDarkmode ? Color(0xff2C2B2B) : Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            )),
        child: BlocBuilder<ProfileInfoCubit, ProfileInfoState>(
          builder: (context, state) {
            if (state is ProfileInfoLoading) {
              return Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator());
            }
            if (state is ProfileInfoLoaded) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(state.userEntitiy.imageURL!))),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(state.userEntitiy.email!),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    state.userEntitiy.fullName!,
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                  )
                ],
              );
            }

            if (state is ProfileInfoFailure) {
              return Text('Please try again ');
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget _favoriteSongs() {
    return BlocProvider(
      create: (context) => FavoriteSongsCubit()..getFavoriteSongs(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("FAVORİTE SONGS"),
            SizedBox(
              height: 20,
            ),
            BlocBuilder<FavoriteSongsCubit, FavoriteSongsState>(
              builder: (context, state) {
                if (state is FavoriteSongsLoading) {
                  return CircularProgressIndicator();
                }
                if (state is FavoriteSongsLoaded) {
                  return ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>SongPlayerPage(songEntity: state.favoritesSongs[index]) ,));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 70,
                                    width: 70,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                              '${AppURLs.firestorage}${state.favoritesSongs[index].artist.toLowerCase()}.jpg?${AppURLs.mediaAlt}',
                                            ))),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        state.favoritesSongs[index].title,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        state.favoritesSongs[index].artist,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 11),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Text(state.favoritesSongs[index].duration
                                      .toString()
                                      .replaceAll(".", ":")),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  FavoriteButton(
                                    songEntity: state.favoritesSongs[index],
                                    key: UniqueKey(),
                                    function: () {
                                      context
                                          .read<FavoriteSongsCubit>()
                                          .removeSong(index);
                                    },
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(
                            height: 10,
                          ),
                      itemCount: state.favoritesSongs.length);
                }
                if (state is FavoriteSongsFailure) {
                  return Text("Please try Again");
                }
                return Container();
              },
            )
          ],
        ),
      ),
    );
  }
}
