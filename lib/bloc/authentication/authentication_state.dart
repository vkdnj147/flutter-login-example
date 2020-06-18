import 'package:meta/meta.dart';

@immutable
class AuthenticationState {
  final bool isInit;
  final bool isAuth;
  final String username;

  AuthenticationState({
    @required this.isInit,
    @required this.isAuth,
    @required this.username,
  });

  factory AuthenticationState.initial() {
    return AuthenticationState(
      isInit: false,
      isAuth: false,
      username: null,
    );
  }

  AuthenticationState initialed() {
    return copyWith(isInit: true);
  }

  AuthenticationState signIn() {
    return copyWith(isAuth: true);
  }

  AuthenticationState signOut() {
    return copyWith(isAuth: false, username: null);
  }

  AuthenticationState copyWith({
    bool isInit,
    bool isAuth,
    bool username,
  }) {
    return AuthenticationState(
      isInit: isInit ?? this.isInit,
      isAuth: isAuth ?? this.isAuth,
      username: username ?? this.username,
    );
  }

  @override
  String toString() {
    return '''AuthenticationState {
      isInit: $isInit,
      isAuth: $isAuth,      
      username: $username,
    }''';
  }
}
