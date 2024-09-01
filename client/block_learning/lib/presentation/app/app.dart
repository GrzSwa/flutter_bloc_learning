import 'package:block_learning/config/router/router.dart';
import 'package:block_learning/core/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:block_learning/core/blocs/internet_connection_bloc/internet_connection_bloc.dart';
import 'package:block_learning/data/providers/authentication_provider/authentication_provider.dart';
import 'package:block_learning/data/repositories/authentication_repository/authentication_repository.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  final AppRouter appRouter;
  final Connectivity connectivity;
  final AuthenticationRepository _authenticationRepository =
      AuthenticationRepository(AuthenticationProvider());

  App({
    Key? key,
    required this.appRouter,
    required this.connectivity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<InternetConnectionBloc>(
              create: (internetConnectionBlocContext) =>
                  InternetConnectionBloc(connectivity: connectivity)),
          BlocProvider<AuthenticationBloc>(
              create: (authenticationBlocContext) => AuthenticationBloc(
                  authenticationRepository: _authenticationRepository)),
        ],
        child: MaterialApp(
          title: "Aion",
          onGenerateRoute: appRouter.onGenerateRoute,
        ));
  }
}
