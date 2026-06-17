import '../entities/app_launch_status.dart';

abstract class SplashRepository {
  Future<AppLaunchStatus> getAppLaunchStatus();
}
