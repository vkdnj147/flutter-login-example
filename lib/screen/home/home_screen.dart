import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterloginlogout/bloc/authentication/authentication_bloc.dart';
import 'package:flutterloginlogout/bloc/authentication/authentication_event.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
    super.initState();
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              if (_authenticationBloc.state.isAuth) {
                _authenticationBloc.add(
                  AuthenticationSignOut(),
                );
              } else {
                _authenticationBloc.add(
                  AuthenticationSignIn(),
                );
              }
            },
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Center(child: Text('Welcome! ${_authenticationBloc.state.isAuth}')),
        ],
      ),
    );
  }
}
