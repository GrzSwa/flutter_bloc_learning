part of 'internet_connection_bloc.dart';

@immutable
abstract class InternetConnectionState {}

class InternetConnectionLoading extends InternetConnectionState {}

class InternetConnectionConnected extends InternetConnectionState {
  final ConnectionType connectionType;

  InternetConnectionConnected({required this.connectionType});

  @override
  String toString() => 'InternetConnected(connectionType: $connectionType)';
}

class InternetConnectionDisconnected extends InternetConnectionState {}
