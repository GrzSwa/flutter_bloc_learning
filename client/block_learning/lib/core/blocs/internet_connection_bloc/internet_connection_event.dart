part of 'internet_connection_bloc.dart';

@immutable
abstract class InternetConnectionEvent {}

class InternetConnectedEvent extends InternetConnectionEvent {
  final ConnectionType connectiontype;
  InternetConnectedEvent(this.connectiontype);
}

class InternetDisconnectedEvent extends InternetConnectionEvent {}
