import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/dio_client.dart';
import '../../data/datasources/dashboard_remote_data_source.dart';
import '../../data/repositories/dashboard_repository_impl.dart';
import '../../domain/entities/dashboard_data.dart';
import '../../domain/repositories/dashboard_repository.dart';
import '../../domain/usecases/get_dashboard_data.dart';

final dashboardRemoteDataSourceProvider = Provider<DashboardRemoteDataSource>((ref) {
  final dio = ref.watch(dioProvider);
  return DashboardRemoteDataSourceImpl(dio);
});

final dashboardRepositoryProvider = Provider<DashboardRepository>((ref) {
  final remoteDataSource = ref.watch(dashboardRemoteDataSourceProvider);
  return DashboardRepositoryImpl(remoteDataSource: remoteDataSource);
});

final getDashboardDataUseCaseProvider = Provider<GetDashboardData>((ref) {
  final repository = ref.watch(dashboardRepositoryProvider);
  return GetDashboardData(repository);
});

final dashboardDataProvider = FutureProvider.autoDispose<DashboardData>((ref) async {
  final useCase = ref.watch(getDashboardDataUseCaseProvider);
  return useCase.execute();
});
