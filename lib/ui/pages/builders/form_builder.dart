import '../../pages/login/components/components.dart';
import 'package:flutter/material.dart';

class FormBuilder {
  static FormBuilder _instance;

  List<Widget> list = [];

  FormBuilder._();

  static FormBuilder instace() {
    _instance = FormBuilder._();
    return _instance;
  }

  FormBuilder email() {
    list.add(EmailInput());
    return this;
  }

  FormBuilder password() {
    list.add(PasswordInput());
    return this;
  }

  FormBuilder button() {
    list.add(ButtonLogin());
    return this;
  }

  List<Widget> build() => list;
}
