import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotifycloneapp/common/widgets/button/basic_app_button.dart';
import 'package:spotifycloneapp/core/configs/assets/app_images.dart';
import 'package:spotifycloneapp/core/configs/assets/app_vectors.dart';
import 'package:spotifycloneapp/core/configs/theme/app_colors.dart';
import 'package:spotifycloneapp/presentation/choose_mode/pages/choose_model.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 40, horizontal: 40),
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(
                  AppImages.introBG,
                ),
              ),
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.15),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 40
            ),
            child: Column(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: SvgPicture.asset(
                      AppVectors.logo,
                    ),
                  ),
                  Spacer(),
                  Text(
                    'Enjoy Listenin To Music',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18),
                  ),
                  SizedBox(
                    height: 21,
                  ),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppColors.grey,
                        fontSize: 13),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  BasicAppButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChooseModelPage(),
                          ));
                    },
                    title: 'Get Started',
                  ),
                ],
              ),
          ),
        ],
      ),
    );
  }
}
