import 'package:get_it/get_it.dart';
import 'package:medical_sales/core/services/database_service.dart';
import 'package:medical_sales/core/services/firebase_auth_service.dart';
import 'package:medical_sales/core/services/firestore_service.dart';
import 'package:medical_sales/features/auth/data/repos/auth_repo_impl.dart';
import 'package:medical_sales/features/auth/domain/repos/auth_repo.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  getIt.registerSingleton<FirebaseAuthService>(FirebaseAuthService());
  // getIt.registerSingleton<StorageService>(SupabaseStorageService());
  getIt.registerSingleton<DatabaseService>(FirestoreService());
  getIt.registerSingleton<AuthRepo>(
    AuthRepoImpl(
      firebaseAuthService: getIt<FirebaseAuthService>(),
      databaseService: getIt<DatabaseService>(),
    ),
  );
  // getIt.registerSingleton<ImagesRepo>(
  //     ImagesRepoImpl(storageService: getIt.get<StorageService>()));
  // getIt.registerSingleton<ProductsRepo>(
  //     ProductsRepoImpl(databaseService: getIt.get<DatabaseService>()));

  // getIt.registerSingleton<ProductsRepo>(
  //   ProductsRepoImpl(databaseService: getIt.get<DatabaseService>()),
  // );
}
