import 'package:flutter/services.dart';

void setOrientation(DeviceOrientation deviceOrientation) {
  SystemChrome.setPreferredOrientations([deviceOrientation]);
}
