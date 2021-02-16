import 'package:clean_architecture/main/factories/cache/local_storage_adapter_factory.dart';

import '../../../data/usecases/usecases.dart';
import '../../../domain/usecases/usecases.dart';

SaveCurrentAccount makeSaveCurrentAccount() {
  return LocalSaveCurrentAccount(saveSecureCacheStorage: makeLocalStorageAdapter());
}
