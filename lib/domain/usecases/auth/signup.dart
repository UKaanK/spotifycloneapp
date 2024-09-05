import 'package:dartz/dartz.dart';
import 'package:spotifycloneapp/core/configs/usercase/usercase.dart';
import 'package:spotifycloneapp/data/models/auth/create_user_req.dart';
import 'package:spotifycloneapp/domain/repository/auth/auth.dart';
import 'package:spotifycloneapp/service_locator.dart';

class SignupUseCase implements UseCase<Either,CreateUserReq>{
  @override
  Future<Either> call({CreateUserReq ? params}) {
    return s1<AuthRepository>().signup(params!);
  }
}