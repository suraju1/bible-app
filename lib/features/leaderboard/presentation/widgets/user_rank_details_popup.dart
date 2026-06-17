import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/leaderboard_user.dart';

class UserRankDetailsPopup extends StatelessWidget {
  final LeaderboardUser user;

  const UserRankDetailsPopup({Key? key, required this.user}) : super(key: key);

  static void show(BuildContext context, LeaderboardUser user) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.6), // Dimmed background
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent, // We provide our own background
        elevation: 0,
        child: UserRankDetailsPopup(user: user),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 340),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Content
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Top Scroll & Banner Space
                const SizedBox(height: 200), // Reserved for custom banner

                // Level Text
                const Text(
                  'Level',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 12),

                // Level Slider Area
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${user.level}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 140,
                      height: 12,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade400, width: 1.5),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: 0.7, // Hardcoded progress for now
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF5A84C3), Color(0xFF383688)],
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${user.level + 1}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Subtitle text
                const Text(
                  'Top 1 English Language Player\nin Daily High Score',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),

          // Close Button
          Positioned(
            top: 12,
            right: 12,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: const Icon(Icons.close, color: Colors.black54, size: 24),
            ),
          ),

          // Custom Banner Graphic Overlay
          Positioned(
            top: 10,
            left: 0,
            right: 0,
            child: _buildCustomBanner(),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomBanner() {
    return SizedBox(
      height: 220,
      child: Stack(
        alignment: Alignment.topCenter,
        clipBehavior: Clip.none,
        children: [
          // Banner Shape (Shield)
          Positioned(
            top: 15,
            child: Container(
              width: 160,
              height: 180,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFFB3C8E3), // Light blue top
                    Colors.white.withValues(alpha: 0.8), // White bottom
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipPath(
                clipper: BannerShieldClipper(),
                child: Container(
                  color: Colors.white.withValues(alpha: 0.5),
                ),
              ),
            ),
          ),

          // Scroll Rod Graphic
          Positioned(
            top: 0,
            child: Container(
              width: 220,
              height: 20,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF5A84C3), Color(0xFF383688)],
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Stack(
                children: [
                  // Left knob
                  Positioned(
                    left: -5,
                    top: -2,
                    bottom: -2,
                    child: Container(
                      width: 12,
                      decoration: const BoxDecoration(
                        color: Color(0xFF5A84C3),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  // Right knob
                  Positioned(
                    right: -5,
                    top: -2,
                    bottom: -2,
                    child: Container(
                      width: 12,
                      decoration: const BoxDecoration(
                        color: Color(0xFF5A84C3),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Banner Content
          Positioned(
            top: 10,
            child: Column(
              children: [
                // Crown
                const Icon(Icons.workspace_premium, color: Color(0xFFFFD700), size: 24),
                
                // Avatar
                Container(
                  margin: const EdgeInsets.only(top: 4, bottom: 8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 4),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 26,
                    backgroundImage: NetworkImage(user.avatarUrl),
                  ),
                ),

                // Rank and Points Row
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildBannerStat('Rank', Icons.shield, const Color(0xFFFFD700)),
                    const SizedBox(width: 16),
                    _buildBannerStat('Points', Icons.monetization_on, const Color(0xFFFFD700)),
                  ],
                ),
              ],
            ),
          ),

          // Level Circle Overlapping the banner bottom
          Positioned(
            bottom: 0,
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Level',
                    style: TextStyle(fontSize: 10, color: Colors.black54),
                  ),
                  Text(
                    '${user.level}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBannerStat(String label, IconData icon, Color iconColor) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black54),
        ),
        const SizedBox(height: 2),
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withValues(alpha: 0.6),
          ),
          child: Icon(icon, size: 20, color: iconColor),
        ),
      ],
    );
  }
}

class BannerShieldClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 40);
    path.lineTo(size.width / 2, size.height);
    path.lineTo(size.width, size.height - 40);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
