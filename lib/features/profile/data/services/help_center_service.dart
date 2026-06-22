import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/dio_client.dart';
import '../../domain/models/help_support_model.dart';

final helpCenterServiceProvider = Provider<HelpCenterService>((ref) {
  final dio = ref.watch(dioProvider);
  return HelpCenterService(dio);
});

class HelpCenterService {
  final Dio _dio;

  HelpCenterService(this._dio);

  Future<List<HelpCategoryModel>> getCategories() async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    return [
      const HelpCategoryModel(id: '1', name: 'Getting Started', icon: 'rocket'),
      const HelpCategoryModel(id: '2', name: 'Account & Profile', icon: 'person'),
      const HelpCategoryModel(id: '3', name: 'Quizzes & Battles', icon: 'gamepad'),
      const HelpCategoryModel(id: '4', name: 'Points & Rewards', icon: 'star'),
    ];
  }

  Future<List<HelpArticleModel>> getArticles() async {
    await Future.delayed(const Duration(milliseconds: 800));

    return [
      const HelpArticleModel(
        id: '1',
        title: 'How to create an account',
        content: 'To create an account, tap on the Sign Up button on the login screen. Fill in your details including email, username, and password. Once registered, you will receive a verification email.',
      ),
      const HelpArticleModel(
        id: '2',
        title: 'How points and rewards work',
        content: 'You earn points for every correct answer in a quiz. You also earn bonus points for completing daily challenges and winning battles. Points can be redeemed for avatars, badges, and other rewards in the shop.',
      ),
      const HelpArticleModel(
        id: '3',
        title: 'Playing with friends',
        content: 'You can play with friends by creating a Group Challenge or inviting them to a Battle. Navigate to the Battles screen and tap "Create Room" to invite your friends using a room code.',
      ),
      const HelpArticleModel(
        id: '4',
        title: 'Resetting your password',
        content: 'If you forgot your password, tap on "Forgot Password" on the login screen. Enter your email address, and we will send you a secure link to reset your password.',
      ),
    ];
  }
}
