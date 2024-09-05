import 'dart:ffi';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotifycloneapp/domain/usecases/auth/get_user.dart';
import 'package:spotifycloneapp/presentation/profile/bloc/profile_info_state.dart';
import 'package:spotifycloneapp/service_locator.dart';

class ProfileInfoCubit extends Cubit<ProfileInfoState> {
  ProfileInfoCubit() : super(ProfileInfoLoading());

  Future<void> getUser() async {
    var user = await s1<GetUserUseCase>().call();

    user.fold((l) {
      emit(ProfileInfoFailure());
    }, (userEntitiy) {
      emit(ProfileInfoLoaded(userEntitiy: userEntitiy));
    });
  }
}
