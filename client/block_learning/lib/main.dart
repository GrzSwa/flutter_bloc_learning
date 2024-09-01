import 'package:block_learning/config/project/locator.dart';
import 'package:block_learning/config/project/orientation.dart';
import 'package:block_learning/config/router/router.dart';
import 'package:block_learning/presentation/app/app.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setOrientation(DeviceOrientation.portraitUp);
  addLocator();
  runApp(App(
    appRouter: AppRouter(),
    connectivity: Connectivity(),
  ));
}
