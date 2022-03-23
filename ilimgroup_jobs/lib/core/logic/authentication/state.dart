part of 'cubit.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}
class AuthenticationLoading extends AuthenticationState {}
class AuthenticatedState  extends AuthenticationState {}
class NotAuthenticated  extends AuthenticationState {}
class ResumeTrySave  extends AuthenticationState {}
class ResumeSaved  extends AuthenticationState {}
class ResumeSavedError  extends AuthenticationState {}