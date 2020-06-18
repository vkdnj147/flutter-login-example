import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutterloginlogout/screen/home/home_screen.dart';
import 'package:flutterloginlogout/screen/splash_screen.dart';

import 'bloc/authentication/bloc.dart';

import 'bloc/simple_bloc_delegate.dart';

import 'util/user_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final UserRepository userRepository = UserRepository();
  runApp(
    BlocProvider(
      create: (context) => AuthenticationBloc(
        userRepository: userRepository,
      )..add(AuthenticationStarted()),
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en'),
        const Locale('ko'),
      ],
      theme: ThemeData(
        primaryColor: Color(0xFFFF9600),
        primaryColorLight: Color(0xFFFF9600),
        accentColor: Color(0xFFFF9600),
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state.isInit) {
            return HomeScreen();
          }
          return SplashScreen();
        },
      ),
    );
  }
}
