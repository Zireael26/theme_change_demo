import 'dart:async';

import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      initialData: false,
      stream: bloc.darkThemeEnabled,
      builder: (context, snapshot) => MaterialApp(
            theme: snapshot.data?ThemeData.dark():ThemeData.light(),
            home: HomePage(snapshot.data),
          ),
    );
  }
}

class HomePage extends StatelessWidget {

  bool darkThemeEnabled;

  HomePage(this.darkThemeEnabled);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dynamic themes"),
      ),
      body: Center(
        child: Text(
          "Hello World!",
          style: TextStyle(fontSize: 32.0),
        ),
      ),
      drawer: Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text("Abhishek"),
                accountEmail: Text("abhishek.nexus26@gmail.com"),
                currentAccountPicture: CircleAvatar(
                  child: Text("AK"),
                ),
              ),
              ListTile(
                title: Text("Dark Theme"),
                trailing: Switch(
                  value: darkThemeEnabled,
                  onChanged: bloc.changeTheme,
                ),
              )
            ],
          )),
    );
  }
}

class Bloc {
  final _themeController = StreamController<bool>();
  get changeTheme => _themeController.sink.add;
  get darkThemeEnabled => _themeController.stream;
}

final bloc = Bloc();