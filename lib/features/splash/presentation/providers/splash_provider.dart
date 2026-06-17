import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/splash_repository_impl.dart';
import '../../domain/entities/app_launch_status.dart';
import '../../domain/usecases/get_app_launch_status.dart';

final getAppLaunchStatusUseCaseProvider = Provider<GetAppLaunchStatus>((ref) {
  final repository = ref.watch(splashRepositoryProvider);
  return GetAppLaunchStatus(repository);
});

final splashProvider = FutureProvider<AppLaunchStatus>((ref) async {
  final useCase = ref.watch(getAppLaunchStatusUseCaseProvider);
  return useCase.execute();
});
