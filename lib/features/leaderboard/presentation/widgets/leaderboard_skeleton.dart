import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'leaderboard_list_item_skeleton.dart';

class LeaderboardSkeleton extends StatelessWidget {
  const LeaderboardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Skeleton Podium
        Positioned(
          top: 54,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildPodiumColumnSkeleton(190, 28, 0), // 2nd
                const SizedBox(width: 8),
                _buildPodiumColumnSkeleton(240, 32, 1), // 1st
                const SizedBox(width: 8),
                _buildPodiumColumnSkeleton(160, 28, 2), // 3rd
              ],
            ),
          ),
        ),

        // Skeleton List Container
        Positioned.fill(
          top: 254,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
            ),
            child: Column(
              children: [
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    children: [
                      Expanded(child: _buildSkeletonChip(double.infinity, height: 48, borderRadius: 24)),
                      const SizedBox(width: 16),
                      Expanded(child: _buildSkeletonChip(double.infinity, height: 48, borderRadius: 24)),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Skeleton Filter Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildSkeletonChip(100),
                      _buildSkeletonChip(90),
                      _buildSkeletonChip(90),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                // Skeleton List View
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.only(bottom: 100),
                    itemCount: 8,
                    itemBuilder: (context, index) {
                      return const LeaderboardListItemSkeleton();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPodiumColumnSkeleton(double height, double avatarRadius, int position) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Crown placeholder
        Shimmer.fromColors(
          baseColor: Colors.white.withValues(alpha: 0.4),
          highlightColor: Colors.white.withValues(alpha: 0.6),
          child: Container(
            width: avatarRadius,
            height: avatarRadius,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 4),
        
        // Pillar
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            Shimmer.fromColors(
              baseColor: Colors.white.withValues(alpha: 0.15),
              highlightColor: Colors.white.withValues(alpha: 0.3),
              child: Container(
                width: 76, // Match new narrower pillar width
                height: height,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(45)),
                ),
              ),
            ),
            // Avatar
            Positioned(
              top: position == 1 ? -32 : -24,
              child: Shimmer.fromColors(
                baseColor: const Color(0xFF7EA0E6), // Soft blue base
                highlightColor: Colors.white,
                child: Container(
                  width: avatarRadius * 2,
                  height: avatarRadius * 2,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSkeletonChip(double width, {double height = 36, double borderRadius = 20}) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFFEAEAEA),
      highlightColor: Colors.white,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}
