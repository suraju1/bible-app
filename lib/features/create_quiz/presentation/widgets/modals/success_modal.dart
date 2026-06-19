import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';
import 'package:go_router/go_router.dart';

class SuccessModal extends StatelessWidget {
  const SuccessModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Placeholder for the shield/rank image from Figma
            Container(
              height: 160,
              width: 130,
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(60),
                  bottomRight: Radius.circular(60),
                ),
                border: Border.all(color: Colors.blue.shade100, width: 2),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 26,
                    backgroundImage: NetworkImage('https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=150&q=80'),
                  ),
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text('Rank', style: TextStyle(fontSize: 10, color: Colors.grey)),
                          Icon(Icons.military_tech, color: Colors.brown, size: 20),
                        ],
                      ),
                      Column(
                        children: [
                          Text('Points', style: TextStyle(fontSize: 10, color: Colors.grey)),
                          Icon(Icons.monetization_on, color: Colors.amber, size: 20),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  CircleAvatar(
                    radius: 14,
                    
                    child: Text('1', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 12)),
                  ),
                  Text('Level', style: TextStyle(fontSize: 10, color: Colors.grey)),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text('Level', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              children: [
                const Text('1', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(width: 8),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: 0.6, // Example progress
                      backgroundColor: Colors.grey.shade300,
                      valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                      minHeight: 12,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                const Text('2', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Quiz Created\nSuccessfully!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, height: 1.2),
            ),
            const SizedBox(height: 12),
            const Text(
              'Your question has been sent for\nadmin review.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(25),
              ),
              child: ElevatedButton(
                onPressed: () {
                  // User said "Sign up" button exactly. Assuming it goes back to home or closes for now.
                  context.pop(); // pop modal
                  context.pop(); // pop screen to go back
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                ),
                child: const Text('Sign up', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
