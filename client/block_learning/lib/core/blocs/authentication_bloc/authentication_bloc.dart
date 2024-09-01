import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:block_learning/config/constant/enums.dart';
import 'package:block_learning/data/models/token_model/token_model.dart';
import 'package:block_learning/data/providers/storage_provider/storage_provider.dart';
import 'package:block_learning/data/repositories/authentication_repository/authentication_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final StorageProvider _storageProvider = GetIt.instance<StorageProvider>();
  final TokenModel tokenModel;
  final AuthenticationRepository _authenticationRepository;

  AuthenticationBloc(
      {required AuthenticationRepository authenticationRepository,
      this.tokenModel = const TokenModel(access_token: '', refresh_token: '')})
      : _authenticationRepository = authenticationRepository,
        super(AuthenticationState(token: tokenModel)) {
    on<AuthenticationLoading>(_authenticationLoading);
    on<AuthenticationLogIn>(_authenticationLogIn);
    on<AuthenticationLogOut>(_authenticationLogOut);
  }

  Future<void> _authenticationLoading(
      AuthenticationLoading event, Emitter<AuthenticationState> emit) async {
    emit(state.copyWith(authenticationStatus: AuthenticationStatus.loading));
    try {
      String access_token =
          await _storageProvider.readData('access_token') ?? '';
      String refresh_token = await _storageProvider.readData('refresh_token');

      if (access_token.isEmpty || refresh_token.isEmpty) {
        emit(state.copyWith(
            authenticationStatus: AuthenticationStatus.unatuhenticated));
        return;
      }

      emit(state.copyWith(
          token: TokenModel(
              access_token: access_token, refresh_token: refresh_token),
          authenticationStatus: AuthenticationStatus.authenticated));
    } catch (e) {
      print('------> [_authenticationLoading(Exception)]: $e');
      emit(state.copyWith(
          authenticationStatus: AuthenticationStatus.unatuhenticated));
    }
  }

  _authenticationLogIn(
      AuthenticationLogIn event, Emitter<AuthenticationState> emit) async {
    emit(state.copyWith(authenticationStatus: AuthenticationStatus.loading));

    try {
      final token =
          await _authenticationRepository.logIn(event.username, event.password);

      await _storageProvider.writeData('access_token', token.access_token);
      await _storageProvider.writeData('refresh_token', token.refresh_token);

      emit(state.copyWith(
          token: token,
          authenticationStatus: AuthenticationStatus.authenticated));
    } catch (e) {
      print('------> [_authenticationLogIn(Exception)]: $e');
      emit(state.copyWith(
          authenticationStatus: AuthenticationStatus.unatuhenticated));
    }
  }

  _authenticationLogOut(
      AuthenticationLogOut event, Emitter<AuthenticationState> emit) async {
    emit(state.copyWith(authenticationStatus: AuthenticationStatus.loading));
    try {
      await _storageProvider.deleteData('access_token');
      await _storageProvider.deleteData('refresh_token');
      emit(state.copyWith(
          token: const TokenModel(access_token: '', refresh_token: ''),
          authenticationStatus: AuthenticationStatus.unatuhenticated));
    } catch (e) {
      Exception(e);
    }
  }
}
