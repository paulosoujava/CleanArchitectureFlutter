import 'package:clean_architecture/data/usecases/authentication/remote_authentication.dart';
import 'package:flutter/material.dart';

import '../../factories.dart';
import '../../../../ui/pages/pages.dart';

Widget makeLoginPage() {
  return LoginPage(makeLoginPresenter());
}
