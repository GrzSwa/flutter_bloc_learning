import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:block_learning/config/constant/enums.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';

part 'internet_connection_event.dart';
part 'internet_connection_state.dart';

class InternetConnectionBloc
    extends Bloc<InternetConnectionEvent, InternetConnectionState> {
  final Connectivity connectivity;
  late StreamSubscription<List<ConnectivityResult>>
      connectivityStreamSubscription;

  InternetConnectionBloc({required this.connectivity})
      : super(InternetConnectionLoading()) {
    monitorInternetConnection();

    on<InternetConnectedEvent>((event, emit) {
      emit(InternetConnectionConnected(connectionType: event.connectiontype));
    });

    on<InternetDisconnectedEvent>((event, emit) {
      emit(InternetConnectionDisconnected());
    });
  }

  void monitorInternetConnection() {
    connectivityStreamSubscription =
        connectivity.onConnectivityChanged.listen((connectivityResult) {
      if (connectivityResult[0] == ConnectivityResult.wifi ||
          connectivityResult[0] == ConnectivityResult.mobile ||
          connectivityResult[0] == ConnectivityResult.ethernet) {
        add(InternetConnectedEvent(ConnectionType.connected));
      } else {
        add(InternetDisconnectedEvent());
      }
    });
  }

  @override
  Future<void> close() {
    connectivityStreamSubscription.cancel();
    return super.close();
  }
}
