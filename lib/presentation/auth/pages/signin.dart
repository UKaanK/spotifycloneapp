import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotifycloneapp/common/widgets/appbar/app_bar.dart';
import 'package:spotifycloneapp/common/widgets/button/basic_app_button.dart';
import 'package:spotifycloneapp/core/configs/assets/app_vectors.dart';
import 'package:spotifycloneapp/data/models/auth/signin_user_req.dart';
import 'package:spotifycloneapp/domain/usecases/auth/signin.dart';
import 'package:spotifycloneapp/presentation/auth/pages/signup.dart';
import 'package:spotifycloneapp/presentation/home/pages/home.dart';
import 'package:spotifycloneapp/service_locator.dart';

class SigninPage extends StatelessWidget {
   SigninPage({super.key});

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _signupText(context),
      appBar: BasicAppBar(
        title: SvgPicture.asset(height: 40, width: 40, AppVectors.logo),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 50,
          vertical: 50,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _registerText(),
              SizedBox(
                height: 59,
              ),
              _emailField(context),
              SizedBox(
                height: 20,
              ),
              _passwordField(context),
              SizedBox(
                height: 20,
              ),
              BasicAppButton(
                onPressed: () async{
                  var result = await s1<SigninUseCase>().call(
                      params: SigninUserReq(
                    email: _email.text.toString(),
                    password: _password.text.toString(),
                  ));
                  result.fold((l){
                    var snackbar = SnackBar(content: Text(l),behavior: SnackBarBehavior.floating,);
                    ScaffoldMessenger.of(context).showSnackBar(snackbar);
                  }, (r) {
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage(),), (route) => false);
                  },);
                },
                title: "Sign In ",
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _registerText() {
    return Text(
      "Sign In",
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
    );
  }

  Widget _emailField(BuildContext context) {
    return TextField(
      controller: _email,
        decoration: InputDecoration(
      hintText: "Enter Email",
    ).applyDefaults(Theme.of(context).inputDecorationTheme));
  }

  Widget _passwordField(BuildContext context) {
    return TextField(
      controller: _password,
        decoration: InputDecoration(
      hintText: "Enter Password",
    ).applyDefaults(Theme.of(context).inputDecorationTheme));
  }

  Widget _signupText(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Not A Member?",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          TextButton(onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignupPage(),));
          }, child: Text("Register Now"))
        ],
      ),
    );
  }
}
