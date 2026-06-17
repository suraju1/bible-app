import '../../../../core/services/secure_storage_service.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final SecureStorageService secureStorage;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.secureStorage,
  });

  @override
  Future<User> login({required String email, required String phoneNumber}) async {
    final userModel = await remoteDataSource.login(email: email, phoneNumber: phoneNumber);
    await secureStorage.saveToken(userModel.token);
    return userModel.toEntity();
  }

  @override
  Future<void> register({required String fullName, required String email, required String phoneNumber}) async {
    await remoteDataSource.register(fullName: fullName, email: email, phoneNumber: phoneNumber);
  }

  @override
  Future<User> loginWithGoogle() async {
    final userModel = await remoteDataSource.loginWithGoogle();
    await secureStorage.saveToken(userModel.token);
    return userModel.toEntity();
  }

  @override
  Future<void> registerWithGoogle() async {
    await remoteDataSource.registerWithGoogle();
  }

  @override
  Future<void> guestLogin() async {
    // Save a dummy token so guest session persists across app restarts
    await secureStorage.saveToken('guest_token_12345');
  }

  @override
  Future<void> logout() async {
    await secureStorage.deleteToken();
  }
}
