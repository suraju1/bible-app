import 'package:dio/dio.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login({required String email, required String phoneNumber});
  Future<void> register({required String fullName, required String email, required String phoneNumber});
  Future<UserModel> loginWithGoogle();
  Future<void> registerWithGoogle();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl(this.dio);

  @override
  Future<UserModel> login({required String email, required String phoneNumber}) async {
    // Mock API Call
    await Future.delayed(const Duration(seconds: 1));
    if (email.isEmpty || phoneNumber.isEmpty) {
      throw Exception('Email and phone number are required.');
    }
    return UserModel(
      id: 1,
      fullName: 'Mock User',
      email: email,
      phoneNumber: phoneNumber,
      token: 'mock_jwt_token_12345',
    );
  }

  @override
  Future<void> register({required String fullName, required String email, required String phoneNumber}) async {
    // Mock API Call
    await Future.delayed(const Duration(seconds: 1));
    if (fullName.isEmpty || email.isEmpty || phoneNumber.isEmpty) {
      throw Exception('All fields are required.');
    }
  }

  @override
  Future<UserModel> loginWithGoogle() async {
    await Future.delayed(const Duration(seconds: 1));
    return const UserModel(
      id: 2,
      fullName: 'Google User',
      email: 'google@example.com',
      phoneNumber: '+10000000000',
      token: 'mock_google_jwt_token',
    );
  }

  @override
  Future<void> registerWithGoogle() async {
    await Future.delayed(const Duration(seconds: 1));
  }
}
