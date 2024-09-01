part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable {
  final AuthenticationStatus authenticationStatus;
  final TokenModel token;

  const AuthenticationState(
      {required this.token,
      this.authenticationStatus = AuthenticationStatus.none});

  @override
  List<Object?> get props => [token, authenticationStatus];

  AuthenticationState copyWith({
    AuthenticationStatus? authenticationStatus,
    TokenModel? token,
  }) {
    return AuthenticationState(
      token: token ?? this.token,
      authenticationStatus: authenticationStatus ?? this.authenticationStatus,
    );
  }
}
