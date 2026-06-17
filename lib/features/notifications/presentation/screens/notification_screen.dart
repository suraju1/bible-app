import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/notification_item.dart';
import '../providers/notification_provider.dart';
import '../widgets/notification_card.dart';

class NotificationScreen extends ConsumerWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(notificationProvider);

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF8BB5F5), // Light sky blue
              Color(0xFF3A3B8B), // Deep purple/blue
            ],
          ),
        ),
        child: Column(
          children: [
            // Header
            SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  children: [
                    // Circular back button
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withOpacity(0.15),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
                        onPressed: () => context.pop(),
                      ),
                    ),
                    const Expanded(
                      child: Text(
                        'Notification',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 48), // To balance the back button
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Main Content (White Container)
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                ),
                child: state.notifications.when(
                  loading: () => const Center(
                    child: CircularProgressIndicator(color: Color(0xFF3A3B8B)),
                  ),
                  error: (error, stack) => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Error: $error', textAlign: TextAlign.center),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () => ref.read(notificationProvider.notifier).fetchNotifications(),
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  ),
                  data: (notifications) {
                    if (notifications.isEmpty) {
                      return const Center(
                        child: Text(
                          'No new notifications',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      );
                    }

                    // Group notifications
                    final today = <NotificationItem>[];
                    final yesterday = <NotificationItem>[];
                    final older = <NotificationItem>[];

                    final now = DateTime.now();
                    final todayDate = DateTime(now.year, now.month, now.day);
                    final yesterdayDate = todayDate.subtract(const Duration(days: 1));

                    for (final item in notifications) {
                      final itemDate = DateTime(item.timestamp.year, item.timestamp.month, item.timestamp.day);
                      if (itemDate == todayDate) {
                        today.add(item);
                      } else if (itemDate == yesterdayDate) {
                        yesterday.add(item);
                      } else {
                        older.add(item);
                      }
                    }

                    return ListView(
                      padding: const EdgeInsets.all(24.0),
                      children: [
                        if (today.isNotEmpty) _buildGroup('Today', today, ref),
                        if (yesterday.isNotEmpty) _buildGroup('Yesterday', yesterday, ref),
                        if (older.isNotEmpty) _buildGroup('Older', older, ref),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGroup(String title, List<NotificationItem> items, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Group Header
        Row(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2C3E50),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Divider(color: Colors.grey.shade300, thickness: 1),
            ),
          ],
        ),
        const SizedBox(height: 16),
        
        // Items
        ...items.map((item) => NotificationCard(
              notification: item,
              onTap: () {
                ref.read(notificationProvider.notifier).markAsRead(item.id);
                // Can route to specific screens here based on item.type later
              },
            )),
        const SizedBox(height: 8),
      ],
    );
  }
}
