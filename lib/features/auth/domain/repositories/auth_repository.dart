import '../entities/user.dart';

abstract class AuthRepository {
  Future<User> login({required String email, required String phoneNumber});
  Future<void> register({required String fullName, required String email, required String phoneNumber});
  Future<User> loginWithGoogle();
  Future<void> registerWithGoogle();
  Future<void> guestLogin();
  Future<void> logout();
}
