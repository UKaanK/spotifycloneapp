import 'package:dartz/dartz.dart';
import 'package:spotifycloneapp/data/models/auth/create_user_req.dart';
import 'package:spotifycloneapp/data/models/auth/signin_user_req.dart';
import 'package:spotifycloneapp/data/sources/auth/auth_firebase_service.dart';
import 'package:spotifycloneapp/domain/repository/auth/auth.dart';
import 'package:spotifycloneapp/service_locator.dart';

class AuthRepositoryImpl extends AuthRepository{
  @override
  Future<Either> signin(SigninUserReq signinUserReq) async{
    return await s1<AuthFirebaseService>().signin(signinUserReq);
  }

  @override
  Future<Either> signup(CreateUserReq createUserReq) async{
   return await s1<AuthFirebaseService>().signup(createUserReq);
  }
  
  @override
  Future<Either> getUser() async{
    return await s1<AuthFirebaseService>().getUser();
  }

}