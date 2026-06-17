import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/secure_storage_service.dart';

class AuthInterceptor extends Interceptor {
  final SecureStorageService _secureStorageService;

  AuthInterceptor(this._secureStorageService);

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await _secureStorageService.getToken();
    
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    
    options.headers['Accept'] = 'application/json';
    options.headers['Content-Type'] = 'application/json';

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      // Handle unauthorized errors (e.g., clear token, trigger logout)
      _secureStorageService.deleteToken();
      // Optionally trigger an event to redirect to login
    }
    super.onError(err, handler);
  }
}

final authInterceptorProvider = Provider<AuthInterceptor>((ref) {
  final secureStorageService = ref.watch(secureStorageProvider);
  return AuthInterceptor(secureStorageService);
});
