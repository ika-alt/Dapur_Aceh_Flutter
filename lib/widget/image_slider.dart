import 'dart:async';
import 'package:flutter/material.dart';

class SlideItem {
  final String imagePath;
  final String title;
  final String subtitle;
  final List<Color> colors;

  const SlideItem({
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.colors,
  });
}

class ImageSlider extends StatefulWidget {
  const ImageSlider({super.key});

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  final PageController _controller = PageController();
  int _currentIndex = 0;
  Timer? _timer;

  final List<SlideItem> _slides = const [
    SlideItem(
      imagePath: 'assets/images/mie_aceh.jpg',
      title: 'Mie Aceh Goreng Spesial',
      subtitle: 'Mie pedas khas Aceh dengan daging sapi • 35 menit',
      colors: [Color(0xFFB34012), Color(0xFFE86A3A)],
    ),
    SlideItem(
      imagePath: 'assets/images/gulai_kambing.jpg',
      title: 'Gulai Kambing Aceh',
      subtitle: 'Kuah santan kaya rempah khas tanah rencong • 2 jam',
      colors: [Color(0xFF1A6B3C), Color(0xFF2EAA60)],
    ),
    SlideItem(
      imagePath: 'assets/images/eungkot_paya.jpg',
      title: 'Eungkot Paya (Ikan Asam Pedas)',
      subtitle: 'Ikan kuah asam pedas segar khas Aceh • 40 menit',
      colors: [Color(0xFF6B3A1A), Color(0xFFC8721A)],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      final next = (_currentIndex + 1) % _slides.length;
      _controller.animateToPage(
        next,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: SizedBox(
            height: 200,
            child: PageView.builder(
              controller: _controller,
              itemCount: _slides.length,
              onPageChanged: (i) => setState(() => _currentIndex = i),
              itemBuilder: (context, index) {
                final slide = _slides[index];
                return Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: slide.colors,
                    ),
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Foto asli sebagai background.
                      // Kalau file belum ada, gradient di atas tetap kelihatan (fallback).
                      Image.asset(
                        slide.imagePath,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const SizedBox.shrink();
                        },
                      ),
                      // Overlay gelap supaya judul & subtitle tetap terbaca di atas foto
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Colors.black.withOpacity(0.7),
                                Colors.transparent,
                              ],
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                slide.title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                slide.subtitle,
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.9),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_slides.length, (index) {
            final isActive = index == _currentIndex;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: isActive ? 22 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: isActive
                    ? const Color(0xFFC8471B)
                    : const Color(0xFFEDE8E0),
                borderRadius: BorderRadius.circular(4),
              ),
            );
          }),
        ),
      ],
    );
  }
}
