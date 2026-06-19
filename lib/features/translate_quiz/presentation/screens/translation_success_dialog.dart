import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TranslationSuccessDialog extends StatelessWidget {
  const TranslationSuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Custom Badge Composed with Widgets
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                // Ribbon/Banner shape mock
                Container(
                  width: 200,
                  height: 140,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFE8F0FE), Color(0xFFD0E0FF)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(100),
                      bottomRight: Radius.circular(100),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                ),
                // Avatar
                const Positioned(
                  top: 10,
                  child: CircleAvatar(
                    radius: 24,
                    backgroundImage: NetworkImage('https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=100&q=80'),
                  ),
                ),
                // Rank & Points
                Positioned(
                  top: 70,
                  left: 20,
                  child: Column(
                    children: const [
                      Text('Rank', style: TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold)),
                      Icon(Icons.workspace_premium, color: Colors.brown, size: 16),
                    ],
                  ),
                ),
                Positioned(
                  top: 70,
                  right: 20,
                  child: Column(
                    children: const [
                      Text('Points', style: TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold)),
                      Icon(Icons.monetization_on, color: Colors.amber, size: 16),
                    ],
                  ),
                ),
                // Level Badge
                Positioned(
                  bottom: -15,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFFD0E0FF), width: 3),
                    ),
                    child: const Center(
                      child: Text(
                        '1',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF2C3E50)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 32),
            
            // Level Label
            const Text(
              'Level',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Color(0xFF2C3E50),
              ),
            ),
            const SizedBox(height: 8),

            // Progress Bar
            Row(
              children: [
                const Text('1', style: TextStyle(fontSize: 12, color: Colors.grey)),
                const SizedBox(width: 8),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: 0.7,
                      minHeight: 8,
                      backgroundColor: Colors.grey.shade200,
                      valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF4A72B2)),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                const Text('2', style: TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
            
            const SizedBox(height: 24),

            // Success Message
            const Text(
              'Quiz Translated\nSuccessfully!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2C3E50),
                height: 1.2,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Your Quiz Translated has been\nsent for admin review.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
                height: 1.4,
              ),
            ),

            const SizedBox(height: 24),

            // "Sign up" Button (as per Figma)
            SizedBox(
              width: double.infinity,
              height: 48,
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF8BB5F5), Color(0xFF4A72B2)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF4A72B2).withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () {
                    // Just dismiss the dialog and go back to list
                    context.pop();
                    context.pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                  ),
                  child: const Text(
                    'Sign up',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
