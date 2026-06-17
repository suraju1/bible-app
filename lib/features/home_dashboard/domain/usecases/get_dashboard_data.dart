import '../entities/dashboard_data.dart';
import '../repositories/dashboard_repository.dart';

class GetDashboardData {
  final DashboardRepository repository;

  GetDashboardData(this.repository);

  Future<DashboardData> execute() {
    return repository.getDashboardData();
  }
}
