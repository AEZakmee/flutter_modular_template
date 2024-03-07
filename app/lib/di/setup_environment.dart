import '../env/environment_reader.dart';
import 'locator.dart';

Future<void> setupEnvironment() async {
  locator.registerLazySingleton(EnvironmentReader.new);

  await locator<EnvironmentReader>().loadEnvironment();
}
