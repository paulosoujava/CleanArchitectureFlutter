import '../../../domain/entities/entities.dart';
import '../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/usecases.dart';

import '../../http/http.dart';
import '../../models/models.dart';

class RemoteAuthentication implements Authentication {
  final HttpClient httpClient;
  final String url;

  RemoteAuthentication({
    this.httpClient,
    this.url,
  }) {
    assert(httpClient != null && httpClient is HttpClient, 'Check the param HttpClient');
    assert(url != null && url.isNotEmpty, 'url is required');
  }
  Future<AccountEntity> auth(AuthenticationParams params) async {
    final body = RemoteAuthenticationParams.fromDomain(params).toJson();
    try {
      final httpResponse = await httpClient.request(url: url, method: 'post', body: body);
      return RemoteAccountModel.fromJson(httpResponse).toEntity();
    } on HttpError catch (error) {
      throw error == HttpError.unauthorized ? DomainError.invalidCredentials : DomainError.unexpected;
    }
  }
}

class RemoteAuthenticationParams {
  final String email;
  final String password;

  RemoteAuthenticationParams({this.email, this.password}) {
    assert(email != null && email.isNotEmpty, 'email is required');
    assert(password != null && password.isNotEmpty, 'password is required');
  }

  factory RemoteAuthenticationParams.fromDomain(AuthenticationParams params) => RemoteAuthenticationParams(
        email: params.email,
        password: params.secret,
      );

  Map toJson() => {'email': email, 'password': password};
}
