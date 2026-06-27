import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'home_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  static const Color primary = Color(0xFFC8471B);
  static const Color accent = Color(0xFFE8A020);
  static const Color bg = Color(0xFFFDFAF6);
  static const Color textMuted = Color(0xFF6B6560);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Column(
          children: [
            // ===== Logo =====
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 8),
              child: RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'Dapur',
                      style: TextStyle(
                        color: primary,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'serif',
                      ),
                    ),
                    TextSpan(
                      text: ' Aceh',
                      style: TextStyle(
                        color: accent,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'serif',
                      ),
                    ),
                  ],
                ),
              ),
            ),

            //gambar//
            Expanded(
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                ),
                clipBehavior: Clip.antiAlias,
                child: Image.asset(
                  'assets/images/onboarding.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // ===== Bagian bawah: judul, deskripsi, tombol =====
            Padding(
              padding: const EdgeInsets.fromLTRB(28, 28, 28, 20),
              child: Column(
                children: [
                  const Text(
                    'Masakan Khas Tanah Rencong',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1C1C1C),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Mulai perjalanan masakmu bersama Dapur Aceh, masak, dan nikmati hidangan khas Aceh.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      color: textMuted,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Tombol Mulai
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const HomeScreen()),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Mulai',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Link ke Login
                  GestureDetector(
                    onTap: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                    ),
                    child: RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: 'Sudah punya akun? ',
                            style: TextStyle(fontSize: 13, color: textMuted),
                          ),
                          TextSpan(
                            text: 'Masuk',
                            style: TextStyle(
                              fontSize: 13,
                              color: primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
