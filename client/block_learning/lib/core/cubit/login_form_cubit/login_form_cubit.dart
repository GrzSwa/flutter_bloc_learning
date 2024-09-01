import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_form_state.dart';

class LoginFormCubit extends Cubit<LoginFormState> {
  LoginFormCubit()
      : super(
            const LoginFormState(username: '', password: '', errorMessage: ''));

  void setUsername(String value) =>
      emit(state.copyWith(username: value, status: LoginFormStatus.empty));

  void setPassword(String value) =>
      emit(state.copyWith(password: value, status: LoginFormStatus.empty));

  void signalError() => emit(state.copyWith(
      status: LoginFormStatus.failure,
      errorMessage: 'Niepoprawna nazwa użytkownika lub hasło'));

  void loading() => emit(state.copyWith(
        status: LoginFormStatus.loading,
      ));

  Future<void> checkFormFields() async {
    if (state.username.isEmpty || state.password.isEmpty) {
      emit(state.copyWith(
          status: LoginFormStatus.empty,
          errorMessage: 'Brak nazwy użytkownika lub hasła'));
    } else if (state.username != 'test' || state.password != '123456') {
      emit(state.copyWith(status: LoginFormStatus.loading));
      await Future.delayed(Duration(seconds: 2));
      emit(state.copyWith(
          status: LoginFormStatus.failure,
          errorMessage: 'Niepoprawna nazwa użytkownika lub hasło'));
    } else {
      emit(state.copyWith(status: LoginFormStatus.loading));
      await Future.delayed(Duration(seconds: 2));
      emit(state.copyWith(status: LoginFormStatus.success));
    }
  }
}
