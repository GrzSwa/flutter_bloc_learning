import 'package:block_learning/core/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                BlocProvider.of<AuthenticationBloc>(context)
                    .add(AuthenticationLogOut());
                Navigator.of(context).popAndPushNamed('/login');
              },
              icon: Icon(Icons.logout_outlined)),
          title: Text('APP'),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/profile');
                },
                icon: Icon(Icons.account_circle_rounded))
          ],
        ),
        body: Container(
          child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/scheduler');
              },
              child: Text('click')),
        ));
  }
}
