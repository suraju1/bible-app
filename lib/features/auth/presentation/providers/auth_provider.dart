import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/services/secure_storage_service.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../data/datasources/auth_remote_data_source.dart';
import '../../data/repositories/auth_repository_impl.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dio = ref.watch(dioProvider);
  final secureStorage = ref.watch(secureStorageProvider);

  return AuthRepositoryImpl(
    remoteDataSource: AuthRemoteDataSourceImpl(dio),
    secureStorage: secureStorage,
  );
});

final loginControllerProvider = AsyncNotifierProvider.autoDispose<LoginController, void>(LoginController.new);

class LoginController extends AutoDisposeAsyncNotifier<void> {
  @override
  void build() {}

  Future<bool> login(String email, String phoneNumber) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(authRepositoryProvider);
      await repository.login(email: email, phoneNumber: phoneNumber);
    });
    return !state.hasError;
  }

  Future<bool> loginWithGoogle() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(authRepositoryProvider);
      await repository.loginWithGoogle();
    });
    return !state.hasError;
  }
}

final signUpControllerProvider = AsyncNotifierProvider.autoDispose<SignUpController, void>(SignUpController.new);

class SignUpController extends AutoDisposeAsyncNotifier<void> {
  @override
  void build() {}

  Future<bool> register(String fullName, String email, String phoneNumber) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(authRepositoryProvider);
      await repository.register(fullName: fullName, email: email, phoneNumber: phoneNumber);
    });
    return !state.hasError;
  }

  Future<bool> registerWithGoogle() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(authRepositoryProvider);
      await repository.registerWithGoogle();
    });
    return !state.hasError;
  }
}

final guestLoginControllerProvider = AsyncNotifierProvider.autoDispose<GuestLoginController, void>(GuestLoginController.new);

class GuestLoginController extends AutoDisposeAsyncNotifier<void> {
  @override
  void build() {}

  Future<bool> guestLogin() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(authRepositoryProvider);
      await repository.guestLogin();
    });
    return !state.hasError;
  }
}
