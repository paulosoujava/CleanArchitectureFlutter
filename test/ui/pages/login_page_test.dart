import 'dart:async';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:clean_architecture/ui/pages/pages.dart';
import 'package:mockito/mockito.dart';

class LoginPresenterSpy extends Mock implements LoginPresenter {}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  LoginPresenter presenter;
  MockNavigatorObserver mockObserver;
  StreamController<String> emailErrorController;
  StreamController<String> passwordErrorController;
  StreamController<String> navigateToController;
  StreamController<String> mainErrorController;
  StreamController<bool> isFormValidController;
  StreamController<bool> isLoadingController;

  void initialize() {
    presenter = LoginPresenterSpy();
    mockObserver = MockNavigatorObserver();
    emailErrorController = StreamController<String>();
    passwordErrorController = StreamController<String>();
    navigateToController = StreamController<String>();
    mainErrorController = StreamController<String>();
    isFormValidController = StreamController<bool>();
    isLoadingController = StreamController<bool>();
  }

  void mockStreams() {
    when(presenter.emailErrorStream).thenAnswer((_) => emailErrorController.stream);
    when(presenter.passwordErrorStream).thenAnswer((_) => passwordErrorController.stream);
    when(presenter.isFormValidStream).thenAnswer((_) => isFormValidController.stream);
    when(presenter.isLoadingStream).thenAnswer((_) => isLoadingController.stream);
    when(presenter.mainErrorStream).thenAnswer((_) => mainErrorController.stream);
    when(presenter.navigationToStream).thenAnswer((_) => navigateToController.stream);
  }

  void closeStreams() {
    emailErrorController.close();
    passwordErrorController.close();
    isFormValidController.close();
    isLoadingController.close();
    mainErrorController.close();
    navigateToController.close();
  }

  Future<void> loadPage(WidgetTester tester) async {
    initialize();
    mockStreams();

    final loginPage = MaterialApp(
      home: LoginPage(presenter),
      navigatorObservers: [mockObserver],
    );
    await tester.pumpWidget(loginPage);
  }

  tearDown(() {
    closeStreams();
  });

  testWidgets('Should load with correct initial state', (WidgetTester tester) async {
    await loadPage(tester);

    final emailTextChildren = find.descendant(of: find.bySemanticsLabel('Email'), matching: find.byType(Text));
    expect(emailTextChildren, findsOneWidget, reason: 'when a TextFormField has only one text child, means it has no errors, since one of the childs is always the label text');

    final passwordTextChildren = find.descendant(of: find.bySemanticsLabel('Senha'), matching: find.byType(Text));
    expect(passwordTextChildren, findsOneWidget, reason: 'when a TextFormField has only one text child, means it has no errors, since one of the childs is always the label text');

    final button = tester.widget<RaisedButton>(find.byType(RaisedButton));
    expect(button.onPressed, null);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('Should call validate with correct values', (WidgetTester tester) async {
    await loadPage(tester);
    final email = faker.internet.email();
    await tester.enterText(find.bySemanticsLabel('Email'), email);

    verify(presenter.validateEmail(email));

    final password = faker.internet.password();
    await tester.enterText(find.bySemanticsLabel('Senha'), password);

    verify(presenter.validatePassword(password));
  });

  testWidgets('Should present error if email is invalid', (WidgetTester tester) async {
    await loadPage(tester);

    emailErrorController.add('any error');
    await tester.pump(); // renderiza a tela ai filho por q o strean ta nandando dados

    expect(find.text('any error'), findsOneWidget);
  });

  testWidgets('Should present error if email is invalid', (WidgetTester tester) async {
    await loadPage(tester);

    emailErrorController.add('any error');
    await tester.pump(); // renderiza a tela ai filho por q o strean ta nandando dados

    expect(find.text('any error'), findsOneWidget);
  });

  testWidgets('Should present no error if email is valid', (WidgetTester tester) async {
    await loadPage(tester);

    emailErrorController.add(null);
    await tester.pump(); // renderiza a tela ai filho por q o strean ta nandando dados
    // me diz se existe somente um descendente de texto na tela que é o padrao correto +de um seguinifica que tenho erro
    final emailTextChildren = find.descendant(
      of: find.bySemanticsLabel('Email'),
      matching: find.byType(Text),
    );
    expect(
      emailTextChildren,
      findsOneWidget,
      reason: 'nao tenho como testar uma stream quando ela não exibe nada, para isso eu uso o find.descendant, verificando assim  o estado de NAO erro, erro + de um text é exibido',
    );
  });

  testWidgets('Should present no error if email is valid', (WidgetTester tester) async {
    await loadPage(tester);

    emailErrorController.add(null);
    await tester.pump(); // renderiza a tela ai filho por q o strean ta nandando dados
    // me diz se existe somente um descendente de texto na tela que é o padrao correto +de um seguinifica que tenho erro
    final emailTextChildren = find.descendant(
      of: find.bySemanticsLabel('Email'),
      matching: find.byType(Text),
    );
    expect(
      emailTextChildren,
      findsOneWidget,
      reason: 'nao tenho como testar uma stream quando ela não exibe nada, para isso eu uso o find.descendant, verificando assim  o estado de NAO erro, erro + de um text é exibido',
    );
  });

  testWidgets('Should present no error if email is valid', (WidgetTester tester) async {
    await loadPage(tester);

    emailErrorController.add(''); // emite um string vazia
    await tester.pump(); // renderiza a tela ai filho por q o strean ta nandando dados
    // continuacao do teste de cima, no caso se a stream emitir um dado vazio vai constar como ou novo text na tela e isso sera considerado
    // como um erro, precisamos tratar isso
    final emailTextChildren = find.descendant(
      of: find.bySemanticsLabel('Email'),
      matching: find.byType(Text),
    );
    expect(
      emailTextChildren,
      findsOneWidget,
    );
  });

  testWidgets('Should present error if password is invalid', (WidgetTester tester) async {
    await loadPage(tester);

    passwordErrorController.add('any error');
    await tester.pump(); // renderiza a tela ai filho por q o strean ta nandando dados

    expect(find.text('any error'), findsOneWidget);
  });

  testWidgets('Should present error if password is invalid', (WidgetTester tester) async {
    await loadPage(tester);

    passwordErrorController.add('any error');
    await tester.pump(); // renderiza a tela ai filho por q o strean ta nandando dados

    expect(find.text('any error'), findsOneWidget);
  });

  testWidgets('Should present no error if password is valid', (WidgetTester tester) async {
    await loadPage(tester);

    passwordErrorController.add(null);
    await tester.pump(); // renderiza a tela ai filho por q o strean ta nandando dados
    // me diz se existe somente um descendente de texto na tela que é o padrao correto +de um seguinifica que tenho erro
    final passTextChildren = find.descendant(
      of: find.bySemanticsLabel('Senha'),
      matching: find.byType(Text),
    );
    expect(
      passTextChildren,
      findsOneWidget,
      reason: 'nao tenho como testar uma stream quando ela não exibe nada, para isso eu uso o find.descendant, verificando assim  o estado de NAO erro, erro + de um text é exibido',
    );
  });

  testWidgets('Should present no error if password is valid', (WidgetTester tester) async {
    await loadPage(tester);

    passwordErrorController.add(null);
    await tester.pump(); // renderiza a tela ai filho por q o strean ta nandando dados
    // me diz se existe somente um descendente de texto na tela que é o padrao correto +de um seguinifica que tenho erro
    final passTextChildren = find.descendant(
      of: find.bySemanticsLabel('Senha'),
      matching: find.byType(Text),
    );
    expect(
      passTextChildren,
      findsOneWidget,
      reason: 'nao tenho como testar uma stream quando ela não exibe nada, para isso eu uso o find.descendant, verificando assim  o estado de NAO erro, erro + de um text é exibido',
    );
  });

  testWidgets('Should present no error if password is valid', (WidgetTester tester) async {
    await loadPage(tester);

    passwordErrorController.add(''); // emite um string vazia
    await tester.pump(); // renderiza a tela ai filho por q o strean ta nandando dados
    // continuacao do teste de cima, no caso se a stream emitir um dado vazio vai constar como ou novo text na tela e isso sera considerado
    // como um erro, precisamos tratar isso
    final passTextChildren = find.descendant(
      of: find.bySemanticsLabel('Senha'),
      matching: find.byType(Text),
    );
    expect(
      passTextChildren,
      findsOneWidget,
    );
  });

  testWidgets('Should enable button if form is valid', (WidgetTester tester) async {
    await loadPage(tester);

    isFormValidController.add(true);
    await tester.pump();
    final button = tester.widget<RaisedButton>(find.byType(RaisedButton));
    expect(button.onPressed, isNotNull);
  });

  testWidgets('Should disable button if form is valid', (WidgetTester tester) async {
    await loadPage(tester);

    isFormValidController.add(false); // emite um string vazia
    await tester.pump();
    final button = tester.widget<RaisedButton>(find.byType(RaisedButton));
    expect(button.onPressed, isNull);
  });

  testWidgets('Should call authentication on form submit', (WidgetTester tester) async {
    await loadPage(tester);

    // isFormValidController.add(true);
    // await tester.pump();

    await tester.tap(find.byType(RaisedButton));

    verify(presenter.auth()).called(1);
  });

  testWidgets('Should present loading show and hide', (WidgetTester tester) async {
    await loadPage(tester);
    isLoadingController.add(true); // emite um true para habilitar o btn
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    isLoadingController.add(false); // emite um true para habilitar o btn
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('Should present error message if authentication fails', (WidgetTester tester) async {
    await loadPage(tester);
    mainErrorController.add('error message'); // emite um true para habilitar o btn
    await tester.pump();
    expect(find.text('error message'), findsOneWidget);
  });

  testWidgets('Should close streams on dispose', (WidgetTester tester) async {
    await loadPage(tester);
    addTearDown(() {
      verify(presenter.dispose()).called(1);
    });
  });

  testWidgets('Should change page', (WidgetTester tester) async {
    await loadPage(tester);
    navigateToController.add('any_route');
    await tester.pumpAndSettle();
    expect(find.text('Enquetes'), findsOneWidget);
    //verify(mockObserver.didPush(any, any));
  });
}
