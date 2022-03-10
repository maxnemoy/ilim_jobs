import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ilimgroup_jobs/config/singleton.dart';
import 'package:ilimgroup_jobs/core/logic/authentication/repository.dart';
import 'package:ilimgroup_jobs/core/models/user/user_data.dart';

part 'state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState>{
  AuthenticationCubit() : super(AuthenticationInitial());
  
  final AuthenticationRepository _repository = getIt<AuthenticationRepository>();

  void login(UserData user) async {
    emit(AuthenticationLoading());
    await _repository.login(user);
    if(_repository.auth != null){
      emit(AuthenticatedState());
    } else {
      emit(NotAuthenticated());
    }
  }

  void logout(){
    emit(AuthenticationLoading());
    _repository.logout();
    emit(NotAuthenticated());
  }
}