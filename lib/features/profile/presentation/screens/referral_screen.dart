import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../domain/models/referral_model.dart';
import '../providers/referral_provider.dart';
import '../widgets/referral_card_widget.dart';

class ReferralScreen extends ConsumerWidget {
  const ReferralScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dataAsync = ref.watch(referralDataProvider);
    final filter = ref.watch(referralFilterProvider);

    return Scaffold(
      body: Stack(
        children: [
          // Gradient Background Header
          Container(
            height: MediaQuery.of(context).size.height * 0.45,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/Gradient.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          SafeArea(
            bottom: false,
            child: Column(
              children: [
                // Top Bar
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (context.canPop()) {
                            context.pop();
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                      const Expanded(
                        child: Center(
                          child: Text(
                            'Refer & Get Points',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 32), // Balance the back button
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Illustration & Total
                dataAsync.when(
                  skipLoadingOnReload: true,
                  loading: () => const SizedBox(height: 150),
                  error: (_, __) => const SizedBox(height: 150),
                  data: (data) => Column(
                    children: [
                      // Placeholder for the "hands holding phones" graphic
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.phone_android,
                            color: Colors.white70,
                            size: 40,
                          ),
                          const SizedBox(width: 20),
                          Column(
                            children: [
                              Text(
                                data.totalReferrals.toString().padLeft(2, '0'),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 48,
                                  fontWeight: FontWeight.bold,
                                  height: 1.0,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Total Referral',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 20),
                          const Icon(
                            Icons.phone_iphone,
                            color: Colors.white70,
                            size: 40,
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // Referral Link Box
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40.0),
                        child: Container(
                          padding: const EdgeInsets.only(
                            left: 20,
                            right: 6,
                            top: 6,
                            bottom: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  data.referralLink,
                                  style: TextStyle(
                                    color: Theme.of(
                                      context,
                                    ).textTheme.bodyLarge?.color,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Clipboard.setData(
                                    ClipboardData(text: data.referralLink),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Referral link copied!'),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF2E5B9F),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.copy,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // Main Content Container
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Stats Card
                            if (dataAsync.hasValue)
                              _buildStatsCard(dataAsync.value!),

                            const SizedBox(height: 32),

                            Text(
                              'Referral Status',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(
                                  context,
                                ).textTheme.bodyLarge?.color,
                              ),
                            ),
                            const SizedBox(height: 12),

                            // Tabs
                            Row(
                              children: [
                                _buildTab(
                                  context,
                                  ref,
                                  'All',
                                  'all',
                                  filter == 'all',
                                ),
                                const SizedBox(width: 8),
                                _buildTab(
                                  context,
                                  ref,
                                  'Pending',
                                  'pending',
                                  filter == 'pending',
                                ),
                                const SizedBox(width: 8),
                                _buildTab(
                                  context,
                                  ref,
                                  'Completed',
                                  'completed',
                                  filter == 'completed',
                                ),
                              ],
                            ),

                            const SizedBox(height: 24),

                            // List Items
                            dataAsync.when(
                              skipLoadingOnReload: false,
                              loading: () => const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(32.0),
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                              error: (err, stack) =>
                                  Center(child: Text('Error: $err')),
                              data: (data) {
                                if (data.history.isEmpty) {
                                  return const Center(
                                    child: Padding(
                                      padding: EdgeInsets.all(32.0),
                                      child: Text('No referrals found.'),
                                    ),
                                  );
                                }
                                return Column(
                                  children: data.history
                                      .map(
                                        (item) =>
                                            ReferralCardWidget(item: item),
                                      )
                                      .toList(),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCard(ReferralDataModel data) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF8BA3FF)), // Light blue border
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStatColumn('Total Refer', data.totalReferrals),
          Container(height: 40, width: 1, color: const Color(0xFF8BA3FF)),
          _buildStatColumn('Pending', data.pendingReferrals),
          Container(height: 40, width: 1, color: const Color(0xFF8BA3FF)),
          _buildStatColumn('Completed', data.completedReferrals),
        ],
      ),
    );
  }

  Widget _buildStatColumn(String label, int value) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            color: Color(0xFF4A76A8),
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value.toString().padLeft(2, '0'),
          style: TextStyle(
            color: Color(0xFF1E3A8A), // Dark blue
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildTab(
    BuildContext context,
    WidgetRef ref,
    String label,
    String value,
    bool isSelected,
  ) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          ref.read(referralFilterProvider.notifier).state = value;
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? null : Colors.white,
            gradient: isSelected
                ? const LinearGradient(
                    colors: [
                      Color(0xFF8BA3FF),
                      Color(0xFF4A6BBA),
                    ], // Similar to the tab gradient
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  )
                : null,
            borderRadius: BorderRadius.circular(20),
            border: isSelected
                ? null
                : Border.all(color: const Color(0xFF8BA3FF).withOpacity(0.5)),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : const Color(0xFF8BA3FF),
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
