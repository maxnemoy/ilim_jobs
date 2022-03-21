import 'package:get_it/get_it.dart';
import 'package:ilimgroup_jobs/core/logic/authentication/repository.dart';
import 'package:ilimgroup_jobs/core/logic/data/repository.dart';

final getIt = GetIt.instance;

Future<void> singletonInit() async {
  getIt.registerSingleton<AuthenticationRepository>(AuthenticationRepository());
  getIt.registerSingleton<DataRepository>(DataRepository());

  await getIt.allReady();
  await getIt<DataRepository>().loadData();
}
