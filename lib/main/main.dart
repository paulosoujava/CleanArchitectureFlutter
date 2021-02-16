import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../ui/components/components.dart';
import './factories/factories.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return MaterialApp(
      title: '4Dev',
      debugShowCheckedModeBanner: false,
      theme: makeAppTheme(),
      home: makeLoginPage(),
      routes: <String, WidgetBuilder>{
        '/surveys': (context) => Scaffold(body: Text('Enquetes')),
      },
    );
  }
}
