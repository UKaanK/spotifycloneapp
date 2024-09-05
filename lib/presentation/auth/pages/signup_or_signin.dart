import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotifycloneapp/common/helpers/is_dark_mode.dart';
import 'package:spotifycloneapp/common/widgets/appbar/app_bar.dart';
import 'package:spotifycloneapp/common/widgets/button/basic_app_button.dart';
import 'package:spotifycloneapp/core/configs/assets/app_images.dart';
import 'package:spotifycloneapp/core/configs/assets/app_vectors.dart';
import 'package:spotifycloneapp/core/configs/theme/app_colors.dart';
import 'package:spotifycloneapp/presentation/auth/pages/signin.dart';
import 'package:spotifycloneapp/presentation/auth/pages/signup.dart';

class SignupOrSigninPage extends StatelessWidget {
  const SignupOrSigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BasicAppBar(),
          Align(
            alignment: Alignment.topRight,
            child: SvgPicture.asset(AppVectors.topPattern),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: SvgPicture.asset(AppVectors.bottomPattern),
          ),
          Align(
              alignment: Alignment.bottomLeft,
              child: Image.asset(AppImages.authBG)),
          Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(AppVectors.logo),
                    SizedBox(
                      height: 55,
                    ),
                    Text(
                      "Enjey Listenin To Music",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                    ),
                    SizedBox(height: 21),
                    Text(
                      " 'Spotify is a proprietary Swedish audio streaming and media services provider ",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          color: AppColors.grey),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: BasicAppButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => SignupPage(),));
                              }, title: "Register"),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          flex: 1,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => SigninPage(),));
                            },
                            child: Text(
                              "Sign in",
                              style: TextStyle(
                                color: context.isDarkmode
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
