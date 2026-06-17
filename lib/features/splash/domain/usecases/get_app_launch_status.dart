import '../entities/app_launch_status.dart';
import '../repositories/splash_repository.dart';

class GetAppLaunchStatus {
  final SplashRepository repository;

  GetAppLaunchStatus(this.repository);

  Future<AppLaunchStatus> execute() {
    return repository.getAppLaunchStatus();
  }
}
