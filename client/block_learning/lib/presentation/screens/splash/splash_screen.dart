import 'package:block_learning/config/constant/enums.dart';
import 'package:block_learning/core/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:block_learning/core/blocs/internet_connection_bloc/internet_connection_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF1f2c4c),
              Color(0xFF304c95),
              Color(0xFF3760be),
              Color(0xFF558edc)
            ],
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/app_logo.png',
              scale: 1.4,
            ),
            const SizedBox(
              height: 20,
            ),
            BlocConsumer<InternetConnectionBloc, InternetConnectionState>(
                listener: (internetConnectionBlocContext, state) => {
                      if (state is InternetConnectionConnected)
                        {
                          context
                              .read<AuthenticationBloc>()
                              .add(AuthenticationLoading())
                        }
                    },
                builder: (internetConnectionBlocContext, state) {
                  if (state is InternetConnectionDisconnected) {
                    return const Text(
                      "Brak internetu",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    );
                  } else {
                    return BlocListener<AuthenticationBloc,
                            AuthenticationState>(
                        listener: (authenticationBlocContext, state) {
                          if (state.authenticationStatus ==
                              AuthenticationStatus.unatuhenticated) {
                            Navigator.of(context)
                                .pushReplacementNamed('/login');
                          } else if (state.authenticationStatus ==
                              AuthenticationStatus.authenticated) {
                            Navigator.of(context).pushReplacementNamed('/home');
                          }
                        },
                        child: const SizedBox(
                          width: double.infinity,
                          child: SpinKitThreeBounce(
                            color: Colors.white,
                            size: 20,
                          ),
                        ));
                  }
                }),
          ],
        ),
      ),
    );
  }
}
