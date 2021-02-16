import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../login_presenter.dart';

class ButtonLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<LoginPresenter>(context);
    return StreamBuilder<bool>(
        stream: presenter.isFormValidStream,
        builder: (context, snapshot) {
          return Container(
            margin: EdgeInsets.only(top: 50),
            child: RaisedButton(
              onPressed: snapshot.data == true ? presenter.auth : null,
              child: Text('Entrar'.toUpperCase()),
            ),
          );
        });
  }
}
