import 'package:dio/dio.dart';
import '../models/notification_model.dart';

abstract class NotificationRemoteDataSource {
  Future<List<NotificationModel>> getNotifications();
  Future<void> markAsRead(String id);
  Future<void> markAllAsRead();
}

class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  final Dio dio;

  NotificationRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<NotificationModel>> getNotifications() async {
    // Mocking API call with delay
    await Future.delayed(const Duration(seconds: 1));
    
    // Generating some mock data to match Figma exactly
    final now = DateTime.now();
    
    return [
      NotificationModel(
        id: '1',
        title: "Don't forget today's quiz challenge!",
        message: "", // Figma shows only one bold text for this card
        timestamp: now.subtract(const Duration(hours: 2)), // Today
        isRead: false,
        type: 'quiz',
      ),
      NotificationModel(
        id: '2',
        title: "5 new quizzes added in Bible Knowledge.",
        message: "",
        timestamp: now.subtract(const Duration(hours: 5)), // Today
        isRead: false,
        type: 'bible',
      ),
      NotificationModel(
        id: '3',
        title: "John invited you to join Faith Quiz Group.",
        message: "",
        timestamp: now.subtract(const Duration(hours: 10)), // Today
        isRead: true,
        type: 'group',
      ),
      NotificationModel(
        id: '4',
        title: "You are on a 7-day streak. Keep going!",
        message: "",
        timestamp: now.subtract(const Duration(days: 1, hours: 2)), // Yesterday
        isRead: true,
        type: 'achievement',
      ),
      NotificationModel(
        id: '5',
        title: "Don't forget today's quiz challenge!",
        message: "",
        timestamp: now.subtract(const Duration(days: 1, hours: 5)), // Yesterday
        isRead: true,
        type: 'quiz',
      ),
      NotificationModel(
        id: '6',
        title: "Rohan invited you to join Faith Quiz Group.",
        message: "",
        timestamp: now.subtract(const Duration(days: 1, hours: 10)), // Yesterday
        isRead: true,
        type: 'group',
      ),
      // Optional older notifications to test the grouping
      NotificationModel(
        id: '7',
        title: "Welcome to Bible Quiz App!",
        message: "Start playing to earn points.",
        timestamp: now.subtract(const Duration(days: 3)), // Older
        isRead: true,
        type: 'system',
      ),
    ];
  }

  @override
  Future<void> markAsRead(String id) async {
    // Mock API call
    await Future.delayed(const Duration(milliseconds: 300));
  }

  @override
  Future<void> markAllAsRead() async {
    // Mock API call
    await Future.delayed(const Duration(milliseconds: 500));
  }
}
