import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_assets.dart';
import '../providers/auth_provider.dart';
import 'package:flutter_animate/flutter_animate.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      ref.read(loginControllerProvider.notifier).login(
            _emailController.text,
            _phoneController.text,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginControllerProvider);

    ref.listen(loginControllerProvider, (previous, next) {
      if (next is AsyncData && previous is AsyncLoading) {
        context.go('/home');
      } else if (next is AsyncError) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(next.error.toString())));
      }
    });

    return Scaffold(
      
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
            child: Column(
              children: [
                Image.asset(AppAssets.logo, height: 150, fit: BoxFit.contain),
                const SizedBox(height: 40),
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [Color(0xFF5A84C3), Color(0xFF383688)], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.blue.withValues(alpha: 0.3), width: 2),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text('Login', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 24),
                        const Text('Email', style: TextStyle(color: Colors.white, fontSize: 14)),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          style: const TextStyle(color: Colors.black87),
                          decoration: InputDecoration(
                            hintText: 'olivia@untitledui.com',
                            hintStyle: TextStyle(color: Colors.grey.shade500),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
                          ),
                          validator: (value) => value == null || value.isEmpty ? 'Required' : null,
                        ),
                        const SizedBox(height: 16),
                        const Text('Phone number', style: TextStyle(color: Colors.white, fontSize: 14)),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          style: const TextStyle(color: Colors.black87),
                          decoration: InputDecoration(
                            hintText: '+1 (555) 000-0000',
                            hintStyle: TextStyle(color: Colors.grey.shade500),
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text('US', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
                                  const SizedBox(width: 4),
                                  const Icon(Icons.keyboard_arrow_down, size: 16, color: Colors.black54),
                                  const SizedBox(width: 8),
                                  Container(height: 20, width: 1, color: Colors.grey.shade400),
                                  const SizedBox(width: 8),
                                ],
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
                          ),
                          validator: (value) => value == null || value.isEmpty ? 'Required' : null,
                        ),
                        const SizedBox(height: 24),
                        const Center(child: Text('Or', style: TextStyle(color: Colors.white))),
                        const SizedBox(height: 24),
                        ElevatedButton.icon(
                          onPressed: loginState.isLoading ? null : () => ref.read(loginControllerProvider.notifier).loginWithGoogle(),
                          icon: Image.network('https://developers.google.com/identity/images/g-logo.png', height: 24),
                          label: const Text('Continue with Google', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
                          style: ElevatedButton.styleFrom(
                            
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          ),
                        ),
                        const SizedBox(height: 30),
                        loginState.isLoading
                            ? const Center(child: CircularProgressIndicator(color: Colors.white))
                            : Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  gradient: const LinearGradient(
                                    colors: [Color(0xFFFFD700), Color(0xFFFFA500)], // Gold to Orange gradient
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFFFFA500).withValues(alpha: 0.3),
                                      spreadRadius: 1,
                                      blurRadius: 8,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: ElevatedButton(
                                  onPressed: _submit,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    padding: const EdgeInsets.symmetric(vertical: 14),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                  ),
                                  child: const Text(
                                    'Login',
                                    style: TextStyle(
                                      color: Color(0xFF1E1E50), // Dark purplish blue for readability
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have an account? ", style: TextStyle(color: Colors.white70)),
                            GestureDetector(
                              onTap: () => context.push('/sign-up'),
                              child: const Text('Sign Up', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, decoration: TextDecoration.underline)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ].animate(interval: 50.ms).fade(duration: 400.ms, curve: Curves.easeOutCubic).slideY(begin: 0.05, end: 0.0, curve: Curves.easeOutCubic),
            ),
          ),
        ),
      ),
    );
  }
}
