import 'package:block_learning/core/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:block_learning/core/cubit/login_form_cubit/login_form_cubit.dart';
import 'package:block_learning/presentation/screens/login/widgets/input.dart';
import 'package:block_learning/presentation/screens/login/widgets/login_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:block_learning/config/constant/enums.dart' as iType;
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormBuilderState>();
    return BlocProvider(
      create: (context) => LoginFormCubit(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              const LoginLogo(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                child: FormBuilder(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        'Zaloguj się',
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          children: [
                            Input(
                              inputType: iType.InputType.username,
                              name: 'username',
                              placeholder: 'Nazwa użytkownika',
                              icons: const Icon(Icons.account_circle_sharp),
                            ),
                            const SizedBox(height: 25),
                            Input(
                              inputType: iType.InputType.password,
                              name: 'password',
                              placeholder: 'Hasło',
                              icons: const Icon(Icons.lock),
                            ),
                          ],
                        ),
                      ),
                      BlocConsumer<LoginFormCubit, LoginFormState>(
                        listener: (context, state) {
                          if (state.status == LoginFormStatus.success) {
                            context.read<AuthenticationBloc>().add(
                                AuthenticationLogIn(
                                    username: state.username,
                                    password: state.password));
                          }
                        },
                        builder: (context, state) {
                          return Column(
                            children: [
                              if (state.status == LoginFormStatus.empty)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 15),
                                  child: Text(
                                    '${state.errorMessage}',
                                    style: const TextStyle(
                                        color: Colors.redAccent,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              if (state.status == LoginFormStatus.failure)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 15),
                                  child: Text(
                                    '${state.errorMessage}',
                                    style: const TextStyle(
                                        color: Colors.redAccent,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              const SizedBox(height: 5),
                              DecoratedBox(
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF1f2c4c),
                                      Color(0xFF304c95),
                                      Color(0xFF3760be),
                                      Color(0xFF558edc)
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      textStyle: const TextStyle(
                                        fontSize: 20,
                                      ),
                                      minimumSize: const Size(240, 50),
                                      maximumSize: const Size(400, 65),
                                      foregroundColor: Colors.white,
                                      backgroundColor: Colors.transparent,
                                      shadowColor: Colors.transparent),
                                  onPressed: () async {
                                    context
                                        .read<LoginFormCubit>()
                                        .checkFormFields();
                                  },
                                  child: state.status == LoginFormStatus.loading
                                      ? const SizedBox(
                                          width: 100,
                                          height: 50,
                                          child: SpinKitThreeBounce(
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        )
                                      : const Text("Zaloguj"),
                                ),
                              )
                            ],
                          );
                        },
                      ),
                      BlocListener<AuthenticationBloc, AuthenticationState>(
                        listener: (context, state) {
                          if (state.authenticationStatus ==
                              iType.AuthenticationStatus.authenticated) {
                            Navigator.of(context).pushReplacementNamed('/home');
                          } else if (state.authenticationStatus ==
                              iType.AuthenticationStatus.loading) {
                            context.read<LoginFormCubit>().loading();
                          } else {
                            context.read<LoginFormCubit>().signalError();
                          }
                        },
                        child: Container(),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
