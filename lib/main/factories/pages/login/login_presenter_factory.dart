import '../../factories.dart';
import '../../../../ui/pages/pages.dart';
import '../../../../presentetion/presenters/presenters.dart';

LoginPresenter makeLoginPresenter() {
  return StreamLoginPresenter(
    authentication: makeRemouteAuthentication(),
    validation: makeLoginValidation(),
    saveCurrentAccount: makeSaveCurrentAccount(),
  );
}
