import '../factories.dart';
import '../../../data/usecases/usecases.dart';
import '../../../domain/usecases/usecases.dart';

Authentication makeRemouteAuthentication() {
  return RemoteAuthentication(
    httpClient: makeHttpAdapter(),
    url: makeApiUrl('login'),
  );
}
