import 'package:flutter/material.dart';
import '../widget/image_slider.dart';
import 'login_screen.dart';
import 'register_screen.dart';
import 'detail_screen.dart';

class RecipeItem {
  final String imagePath;
  final String tag;
  final String title;
  final String duration;
  final double rating;
  final List<Color> thumbColors;

  const RecipeItem({
    required this.imagePath,
    required this.tag,
    required this.title,
    required this.duration,
    required this.rating,
    required this.thumbColors,
  });
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const Color primary = Color(0xFFC8471B);
  static const Color accent = Color(0xFFE8A020);
  static const Color bg = Color(0xFFFDFAF6);
  static const Color cardBg = Colors.white;
  static const Color textMuted = Color(0xFF6B6560);
  static const Color borderColor = Color(0xFFEDE8E0);

  int _selectedCategory = 0;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  final List<String> _categories = [
    'Semua',
    'Masakan Utama',
    'Mie & Sup',
    'Sambal & Lauk',
    'Kue Khas Aceh',
    'Sarapan',
  ];

  final List<RecipeItem> _recipes = const [
    RecipeItem(
      imagePath: 'assets/images/mie_aceh.jpg',
      tag: 'Mie & Sup',
      title: 'Mie Aceh Goreng',
      duration: '35 menit',
      rating: 4.9,
      thumbColors: [Color(0xFFFFF0E8), Color(0xFFFFD4B8)],
    ),
    RecipeItem(
      imagePath: 'assets/images/gulai_kambing.jpg',
      tag: 'Masakan Utama',
      title: 'Gulai Kambing Aceh',
      duration: '2 jam',
      rating: 4.8,
      thumbColors: [Color(0xFFE8F5E9), Color(0xFFB8E6C2)],
    ),
    RecipeItem(
      imagePath: 'assets/images/eungkot_paya.jpg',
      tag: 'Masakan Utama',
      title: 'Eungkot Paya (Asam Pedas)',
      duration: '40 menit',
      rating: 4.7,
      thumbColors: [Color(0xFFFFF8E1), Color(0xFFFFE0A0)],
    ),
    RecipeItem(
      imagePath: 'assets/images/sate_matang.jpg',
      tag: 'Sambal & Lauk',
      title: 'Sate Matang Bireuen',
      duration: '50 menit',
      rating: 4.9,
      thumbColors: [Color(0xFFF3E5F5), Color(0xFFE1B8F0)],
    ),
    RecipeItem(
      imagePath: 'assets/images/nasi_gurih.jpg',
      tag: 'Masakan Utama',
      title: 'Nasi Gurih Aceh',
      duration: '45 menit',
      rating: 4.6,
      thumbColors: [Color(0xFFE3F2FD), Color(0xFFB8D8F8)],
    ),
    RecipeItem(
      imagePath: 'assets/images/kue_timphan.jpg',
      tag: 'Kue Khas Aceh',
      title: 'Kue Timphan',
      duration: '1 jam',
      rating: 4.7,
      thumbColors: [Color(0xFFE0F2F1), Color(0xFFA8D8D0)],
    ),
  ];

  void _showToast(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xFF1C1C1C),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  List<RecipeItem> _getFilteredRecipes() {
    return _recipes.where((recipe) {
      final matchSearch =
          _searchQuery.isEmpty ||
          recipe.title.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchCategory =
          _selectedCategory == 0 ||
          recipe.tag == _categories[_selectedCategory];
      return matchSearch && matchCategory;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isNarrow = screenWidth < 480;

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: cardBg,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        titleSpacing: 16,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: borderColor),
        ),
        title: FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: RichText(
            text: const TextSpan(
              children: [
                TextSpan(
                  text: 'Dapur',
                  style: TextStyle(
                    color: primary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'serif',
                  ),
                ),
                TextSpan(
                  text: ' Aceh',
                  style: TextStyle(
                    color: accent,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'serif',
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: isNarrow
            ? [
                // ===== Versi HP: hemat tempat, pakai ikon =====
                IconButton(
                  tooltip: 'Cari resep',
                  icon: const Icon(Icons.search, color: textMuted),
                  onPressed: () => _showToast('Fitur pencarian segera hadir'),
                ),
                PopupMenuButton<String>(
                  tooltip: 'Akun',
                  icon: const Icon(Icons.person_outline, color: textMuted),
                  onSelected: (value) {
                    if (value == 'login') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const RegisterScreen(),
                        ),
                      );
                    }
                  },
                  itemBuilder: (context) => const [
                    PopupMenuItem(value: 'login', child: Text('Masuk')),
                    PopupMenuItem(value: 'register', child: Text('Daftar')),
                  ],
                ),
                const SizedBox(width: 4),
              ]
            : [
                // ===== Versi tablet/desktop: search bar + tombol teks =====
                Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 8,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: bg,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: borderColor),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.search, size: 16, color: textMuted),
                      const SizedBox(width: 6),
                      SizedBox(
                        width: 120,
                        child: TextField(
                          controller: _searchController,
                          onChanged: (value) {
                            setState(() => _searchQuery = value);
                          },
                          decoration: const InputDecoration(
                            hintText: 'Cari resep Aceh...',
                            hintStyle: TextStyle(
                              fontSize: 13,
                              color: textMuted,
                            ),
                            border: InputBorder.none,
                            isDense: true,
                          ),
                          style: const TextStyle(fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                  ),
                  child: const Text(
                    'Masuk',
                    style: TextStyle(
                      color: textMuted,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const RegisterScreen()),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),
                  ),
                  child: const Text(
                    'Daftar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
              ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Section
            _buildHero(context, isNarrow),
            // Slider Section
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 32, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Resep Pilihan Minggu Ini',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Kuliner khas Tanah Rencong, dikurasi tiap minggu',
                    style: TextStyle(fontSize: 13, color: textMuted),
                  ),
                  const SizedBox(height: 16),
                  const ImageSlider(),
                ],
              ),
            ),
            // Categories
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 28, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Jelajahi Kategori',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(_categories.length, (i) {
                        final isActive = i == _selectedCategory;
                        return GestureDetector(
                          onTap: () => setState(() => _selectedCategory = i),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            margin: const EdgeInsets.only(right: 10),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: isActive ? primary : cardBg,
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(
                                color: isActive ? primary : borderColor,
                                width: 1.5,
                              ),
                            ),
                            child: Text(
                              _categories[i],
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: isActive ? Colors.white : textMuted,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
            // Recipe Grid
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 28, 20, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Resep Populer',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Paling banyak dicoba oleh komunitas Dapur Aceh',
                    style: TextStyle(fontSize: 13, color: textMuted),
                  ),
                  const SizedBox(height: 16),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: isNarrow ? 2 : 3,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 14,
                      childAspectRatio: 0.62,
                    ),
                    itemCount: _getFilteredRecipes().length,
                    itemBuilder: (context, index) =>
                        _buildRecipeCard(_getFilteredRecipes()[index]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHero(BuildContext context, bool isNarrow) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: isNarrow ? 40 : 56,
        horizontal: isNarrow ? 20 : 24,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFFF3ED), Color(0xFFFFF8F0), Color(0xFFFFF5E4)],
        ),
        border: Border(bottom: BorderSide(color: borderColor)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
            decoration: BoxDecoration(
              color: primary,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              '🍴 Kuliner Khas Tanah Rencong',
              style: TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ),
          const SizedBox(height: 18),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: TextStyle(
                fontSize: isNarrow ? 28 : 36,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1C1C1C),
              ),
              children: const [
                TextSpan(text: 'Resep Aceh, '),
                TextSpan(
                  text: 'Rasa',
                  style: TextStyle(color: primary),
                ),
                TextSpan(text: ' Sepenuh Hati'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Temukan resep masakan khas Aceh, dari Mie Aceh hingga Kopi Sanger, mudah dibuat dan diwariskan turun-temurun.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isNarrow ? 13 : 15,
              color: textMuted,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 24),
          // Di layar sempit, tombol ditumpuk vertikal supaya tidak overflow
          isNarrow
              ? Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () =>
                            _showToast('Menjelajahi resep Aceh... 🍳'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Lihat Resep',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const RegisterScreen(),
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: primary,
                          side: const BorderSide(color: primary, width: 2),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Mulai Masak Gratis',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () =>
                          _showToast('Menjelajahi resep Aceh... 🍳'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 28,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Lihat Resep',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(width: 12),
                    OutlinedButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const RegisterScreen(),
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: primary,
                        side: const BorderSide(color: primary, width: 2),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 28,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Mulai Masak Gratis',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildRecipeCard(RecipeItem item) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetailScreen(
              imagePath: item.imagePath,
              tag: item.tag,
              title: item.title,
              duration: item.duration,
              rating: item.rating,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: borderColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail - foto asli, dengan gradient sebagai fallback
            // kalau file gambar belum ditemukan/belum ditaruh
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(14),
              ),
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: item.thumbColors,
                  ),
                ),
                child: Image.asset(
                  item.imagePath,
                  height: 100,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    // Kalau foto belum ada di assets, tampilkan ikon sebagai pengganti
                    return const Center(
                      child: Icon(
                        Icons.restaurant,
                        color: Colors.white,
                        size: 32,
                      ),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5E6DF),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        item.tag.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                          color: primary,
                          letterSpacing: 0.6,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      item.title,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        height: 1.25,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time,
                          size: 12,
                          color: textMuted,
                        ),
                        const SizedBox(width: 3),
                        Flexible(
                          child: Text(
                            item.duration,
                            style: const TextStyle(
                              fontSize: 11,
                              color: textMuted,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Icon(Icons.star_rounded, size: 12, color: accent),
                        const SizedBox(width: 2),
                        Text(
                          '${item.rating}',
                          style: const TextStyle(
                            fontSize: 11,
                            color: textMuted,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
