import 'package:meta/meta.dart' show required;

abstract class Validation {
  String validate({@required String field, @required String value});
}
