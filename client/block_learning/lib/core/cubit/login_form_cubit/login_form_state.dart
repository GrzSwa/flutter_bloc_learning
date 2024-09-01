part of 'login_form_cubit.dart';

enum LoginFormStatus { empty, success, failure, loading }

class LoginFormState extends Equatable {
  final String username;
  final String password;
  final LoginFormStatus status;
  final String? errorMessage;

  const LoginFormState({
    required this.username,
    required this.password,
    this.status = LoginFormStatus.empty,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [username, password, status, errorMessage];

  LoginFormState copyWith({
    String? username,
    String? password,
    LoginFormStatus? status,
    String? errorMessage,
  }) {
    return LoginFormState(
      username: username ?? this.username,
      password: password ?? this.password,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
