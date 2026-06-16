import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../core/theme/app_colors.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _onboardingData = [
    {
      'tag': 'Aktivitas',
      'titleNormal': 'GPS AKTIF.\nDATA AKURAT.\n',
      'titleHighlight': 'SEJAK LANGKAH PERTAMA.',
      'description': 'Pantau aktivitas lari, bersepeda, dan gym secara langsung tanpa terputus sama sekali.',
      'image': 'assets/images/catat.png',
    },
    {
      'tag': 'Nutrisi',
      'titleNormal': 'CATAT MAKAN.\n',
      'titleHighlight': 'SELESAI DALAM 45 DETIK.',
      'description': 'Scan barcode atau cari makanan lokal favoritmu. Kalori terhitung otomatis.',
      'image': 'assets/images/progress.png',
    },
    {
      'tag': 'Progress',
      'titleNormal': 'DATA KAMU.\n',
      'titleHighlight': 'INSIGHT YANG BERBICARA.',
      'description': 'Grafik mingguan dan ringkasan otomatis bahasa Indonesia. Tahu persis di mana kamu berdiri.',
      'image': 'assets/images/datavisual.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // 1. Area PageView Konten (Card Tengah)
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _onboardingData.length,
                itemBuilder: (context, index) {
                  final item = _onboardingData[index];
                  return Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Container(
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Bagian Ilustrasi Gambar
                          Expanded(
                            child: Center(
                              child: Image.asset(
                                item['image']!,
                                fit: BoxFit.contain,
                                // Jika file gambar belum siap, gunakan placeholder sementara:
                                errorBuilder: (context, error, stackTrace) {
                                  return const FaIcon(
                                    FontAwesomeIcons.image,
                                    size: 100,
                                    color: AppColors.textSecondary,
                                  );
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Tag Badge (Aktivitas / Nutrisi / Progress)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              item['tag']!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Judul dengan Dua Warna (RichText)
                          RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                                height: 1.3,
                                fontFamily: 'Poppins',
                              ),
                              children: [
                                TextSpan(
                                  text: item['titleNormal'],
                                  style: const TextStyle(color: AppColors.textPrimary),
                                ),
                                TextSpan(
                                  text: item['titleHighlight'],
                                  style: const TextStyle(color: AppColors.primary),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Deskripsi
                          Text(
                            item['description']!,
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 14,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // 2. Kontrol Navigasi Bawah (Skip, Indikator, Next)
            Padding(
              padding: const EdgeInsets.only(left: 32, right: 32, bottom: 40, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Tombol SKIP
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    child: const Text(
                      'SKIP',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),

                  // Indikator Halaman (3 Garis Horizontal)
                  Row(
                    children: List.generate(
                      _onboardingData.length,
                          (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        height: 6,
                        width: _currentPage == index ? 40 : 24, // Memanjang jika aktif
                        decoration: BoxDecoration(
                          color: _currentPage == index
                              ? AppColors.primary
                              : const Color(0xFFF5E6CA).withOpacity(0.4),
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                  ),

                  // Tombol Lingkaran Oranye (Next / Finish)
                  GestureDetector(
                    onTap: () {
                      if (_currentPage < _onboardingData.length - 1) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        // Jika sudah di halaman terakhir, arahkan ke Login
                        Navigator.pushReplacementNamed(context, '/login');
                      }
                    },
                    child: Container(
                      width: 56,
                      height: 56,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: FaIcon(
                          FontAwesomeIcons.chevronRight,
                          color: Colors.white,
                          size: 18,
                        ),
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