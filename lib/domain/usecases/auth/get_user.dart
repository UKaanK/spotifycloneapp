import 'package:dartz/dartz.dart';
import 'package:spotifycloneapp/core/configs/usercase/usercase.dart';
import 'package:spotifycloneapp/data/models/auth/create_user_req.dart';
import 'package:spotifycloneapp/data/models/auth/signin_user_req.dart';
import 'package:spotifycloneapp/domain/repository/auth/auth.dart';
import 'package:spotifycloneapp/service_locator.dart';

class GetUserUseCase implements UseCase<Either,dynamic>{
  @override
  Future<Either> call({params}) async {
    return await s1<AuthRepository>().getUser();
  }

}