import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/user_profile.dart';
import '../../domain/repositories/profile_repository.dart';

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepositoryImpl();
});

class ProfileRepositoryImpl implements ProfileRepository {
  @override
  Future<UserProfile> fetchUserProfile() async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 800));
    
    // Return mock data matching Figma
    return const UserProfile(
      name: 'Coraline',
      imageUrl: 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=150&q=80',
      completionPercentage: 50,
    );
  }
}
