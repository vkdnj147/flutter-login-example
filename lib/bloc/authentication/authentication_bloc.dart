import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutterloginlogout/util/user_repository.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import 'bloc.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepository;

  AuthenticationBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  AuthenticationState get initialState => AuthenticationState.initial();

  @override
  Stream<Transition<AuthenticationEvent, AuthenticationState>> transformEvents(
    Stream<AuthenticationEvent> events,
    TransitionFunction<AuthenticationEvent, AuthenticationState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(
        const Duration(milliseconds: 500),
      ),
      transitionFn,
    );
  }

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AuthenticationStarted) {
      yield* _mapAuthenticationStartedToState();
    } else if (event is AuthenticationSignIn) {
      yield* _mapAuthenticationSignInToState();
    } else if (event is AuthenticationSignOut) {
      yield* _mapAuthenticationSignOutToState();
    }
  }

  Stream<AuthenticationState> _mapAuthenticationStartedToState() async* {
    final isSignedIn = await _userRepository.isSignedIn();
    if (isSignedIn) {
      yield state.signIn();
    } else {
      yield state.signOut();
    }
    yield state.initialed();
  }

  Stream<AuthenticationState> _mapAuthenticationSignInToState() async* {
    yield state.signIn();
  }

  Stream<AuthenticationState> _mapAuthenticationSignOutToState() async* {
    yield state.signOut();
    _userRepository.signOut();
  }
}
