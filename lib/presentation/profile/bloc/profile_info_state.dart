import 'package:spotifycloneapp/domain/entities/auth/user.dart';

abstract class ProfileInfoState{}

class ProfileInfoLoading extends ProfileInfoState{}

class ProfileInfoLoaded extends ProfileInfoState{
  final UserEntitiy userEntitiy;

  ProfileInfoLoaded({required this.userEntitiy});
}

class ProfileInfoFailure extends ProfileInfoState{
  
}