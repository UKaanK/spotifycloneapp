import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotifycloneapp/common/helpers/is_dark_mode.dart';
import 'package:spotifycloneapp/common/widgets/appbar/app_bar.dart';
import 'package:spotifycloneapp/core/configs/assets/app_images.dart';
import 'package:spotifycloneapp/core/configs/assets/app_vectors.dart';
import 'package:spotifycloneapp/core/configs/theme/app_colors.dart';
import 'package:spotifycloneapp/presentation/home/widgets/news_songs.dart';
import 'package:spotifycloneapp/presentation/home/widgets/play_list.dart';
import 'package:spotifycloneapp/presentation/profile/pages/profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        hideBack: true,
        action: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(),
                  ));
            },
            icon: Icon(
              Icons.person,
            )),
        title: SvgPicture.asset(
          AppVectors.logo,
          height: 40,
          width: 40,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _homeTopCard(),
            _tabs(),
            SizedBox(
              height: 260,
              child: TabBarView(
                children: [
                  NewsSongs(),
                  Container(),
                  Container(),
                  Container(),
                ],
                controller: _tabController,
              ),
            ),
            PlayList()
          ],
        ),
      ),
    );
  }

  Widget _homeTopCard() {
    return Center(
      child: SizedBox(
        height: 140,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: SvgPicture.asset(AppVectors.homeTopCard),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 60.0),
                child: Image.asset(AppImages.homeArtist),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _tabs() {
    return TabBar(
        controller: _tabController,
        labelColor: context.isDarkmode ? Colors.white : Colors.black,
        isScrollable: true,
        indicatorColor: AppColors.primary,
        padding: EdgeInsets.symmetric(
          vertical: 40,
        ),
        tabs: [
          Text(
            "News",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
          Text(
            "Videos",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
          Text(
            "Artists",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
          Text(
            "Podcasts",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
        ]);
  }
}
