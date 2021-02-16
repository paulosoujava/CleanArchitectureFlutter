import 'package:clean_architecture/ui/pages/builders/form_builder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../pages/pages.dart';
import 'components/components.dart';
import '../../components/components.dart';

class LoginPage extends StatefulWidget {
  final LoginPresenter presenter;

  const LoginPage(this.presenter);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  void _hideKeyboard() {
    final currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  @override
  void dispose() {
    super.dispose();
    widget.presenter.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          widget.presenter.isLoadingStream.listen((isLoading) {
            if (isLoading) {
              showDialogLoading(context);
            } else {
              hideLoading(context);
            }
          });

          widget.presenter.mainErrorStream.listen((error) {
            if (error != null && error.isNotEmpty) {
              showErrorMessage(context, error);
            }
          });

          return GestureDetector(
            onTap: _hideKeyboard,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  LoginHeader(),
                  Headline1(text: 'Login'),
                  Padding(
                    padding: EdgeInsets.all(32),
                    child: Provider(
                      create: (context) => widget.presenter,
                      child: Form(
                        child: Column(
                          children: [
                            // ...FormBuilder.instace().email().build(),
                            // ...FormBuilder.instace().password().build(),
                            // ...FormBuilder.instace().button().build(),
                            EmailInput(),
                            PasswordInput(),
                            ButtonLogin(),
                            FlatButton.icon(onPressed: () {}, icon: Icon(Icons.person), label: Text('Criar Conta'))
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
