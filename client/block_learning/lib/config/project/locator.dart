import 'package:block_learning/data/providers/dio_provider/dio_provider.dart';
import 'package:block_learning/data/providers/storage_provider/storage_provider.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void addLocator() {
  getIt.registerLazySingleton<DioProvider>(() => DioProvider());
  getIt.registerLazySingleton<StorageProvider>(() => StorageProvider());
}
