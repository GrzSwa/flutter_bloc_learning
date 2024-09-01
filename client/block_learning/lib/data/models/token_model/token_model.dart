import 'package:equatable/equatable.dart';

class TokenModel extends Equatable {
  final String access_token;
  final String refresh_token;
  const TokenModel({required this.access_token, required this.refresh_token});

  TokenModel copyWith({String? access_token, String? refresh_token}) {
    return TokenModel(
        access_token: access_token ?? this.access_token,
        refresh_token: refresh_token ?? this.refresh_token);
  }

  Map<String, String> toJson() {
    return {'access_token': access_token, 'refresh_token': refresh_token};
  }

  @override
  List<Object?> get props => [access_token, refresh_token];
}
