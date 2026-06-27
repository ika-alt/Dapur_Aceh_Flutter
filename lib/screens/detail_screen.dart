import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final String imagePath;
  final String tag;
  final String title;
  final String duration;
  final double rating;

  const DetailScreen({
    super.key,
    required this.imagePath,
    required this.tag,
    required this.title,
    required this.duration,
    required this.rating,
  });

  static const Color primary = Color(0xFFC8471B);
  static const Color accent = Color(0xFFE8A020);
  static const Color bg = Color(0xFFFDFAF6);
  static const Color textMuted = Color(0xFF6B6560);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Detail Resep',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ===== Foto Resep =====
            Container(
              width: double.infinity,
              height: isSmallScreen ? 250 : 350,
              decoration: BoxDecoration(color: Colors.grey[200]),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Icon(Icons.restaurant, size: 80, color: textMuted),
                  );
                },
              ),
            ),

            // ===== Info Resep =====
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tag kategori
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: accent.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      tag,
                      style: const TextStyle(
                        color: accent,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Judul Resep
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1C1C1C),
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Durasi dan Rating
                  Row(
                    children: [
                      Icon(Icons.access_time, size: 16, color: textMuted),
                      const SizedBox(width: 6),
                      Text(
                        duration,
                        style: const TextStyle(fontSize: 13, color: textMuted),
                      ),
                      const SizedBox(width: 20),
                      Icon(Icons.star_rounded, size: 16, color: accent),
                      const SizedBox(width: 4),
                      Text(
                        rating.toString(),
                        style: const TextStyle(
                          fontSize: 13,
                          color: textMuted,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Divider
                  Divider(color: Colors.grey[300], thickness: 1, height: 32),

                  // Bahan-bahan
                  const Text(
                    'Bahan-bahan',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1C1C1C),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ..._getIngredients(title).map((ingredient) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 6),
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              color: accent,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              ingredient,
                              style: const TextStyle(
                                fontSize: 13,
                                color: Color(0xFF1C1C1C),
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  const SizedBox(height: 24),

                  // Divider
                  Divider(color: Colors.grey[300], thickness: 1, height: 32),

                  // Cara Membuat
                  const Text(
                    'Cara Membuat',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1C1C1C),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ..._getSteps(title).asMap().entries.map((entry) {
                    int idx = entry.key + 1;
                    String step = entry.value;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              color: accent,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                '$idx',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              step,
                              style: const TextStyle(
                                fontSize: 13,
                                color: Color(0xFF1C1C1C),
                                height: 1.6,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  const SizedBox(height: 32),

                  // Tombol Simpan
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('$title disimpan ke favorit!'),
                            backgroundColor: primary,
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        '❤️ Simpan ke Favorit',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Data bahan-bahan untuk setiap resep
  List<String> _getIngredients(String recipeName) {
    final ingredients = {
      'Mie Aceh Goreng': [
        '300g mie telur',
        '200g daging sapi cincang',
        '2 buah bawang merah, iris tipis',
        '3 siung bawang putih, cincang halus',
        '2 buah cabai merah, iris',
        '1 sendok makan cabai giling',
        '1 buah telur',
        '100ml santan',
        '2 sendok makan minyak goreng',
        'Garam, gula, merica secukupnya',
      ],
      'Gulai Kambing Aceh': [
        '800g daging kambing, potong dadu',
        '400ml santan kental',
        '4 buah bawang merah, iris',
        '6 siung bawang putih, cincah halus',
        '4 cm kunyit, parut',
        '3 cm jahe, parut',
        '4 buah cengkeh',
        '2 batang kayu manis',
        '1 sendok teh kulit lada',
        '3 sendok makan minyak',
        'Garam dan gula secukupnya',
      ],
      'Eungkot Paya (Asam Pedas)': [
        '600g ikan (lele, gabus, atau patin)',
        '5 buah cabai merah, belah',
        '5 buah cabai rawit',
        '8 siung bawang merah, iris',
        '4 siung bawang putih, cincah',
        '1 cm jahe, iris',
        '5 lembar daun kunyit',
        '3 sendok makan asam jawa atau jeruk asam',
        '2 sendok makan minyak',
        'Garam dan gula secukupnya',
      ],
      'Sate Matang Bireuen': [
        '600g daging (sapi atau ayam), potong dadu',
        '8 cm kunyit',
        '4 cm jahe',
        '6 siung bawang putih',
        '3 buah cabai merah',
        '200ml santan',
        '2 sendok makan kecap manis',
        '2 sendok makan minyak',
        'Kayu tusuk',
        'Garam, gula, merica secukupnya',
      ],
      'Nasi Gurih Aceh': [
        '300g beras',
        '400ml santan',
        '2 buah bawang merah, iris',
        '4 siung bawang putih, cincah',
        '3 buah cabai rawit',
        '2 cm jahe, iris',
        '2 lembar daun salam',
        '2 batang serai',
        '2 sendok makan minyak',
        'Garam dan gula secukupnya',
      ],
      'Kopi Sanger Khas Aceh': [
        '50ml kopi hitam kental (dari kopi bubuk)',
        '300ml air panas',
        '3 sendok makan gula pasir',
        '100ml susu kental manis',
        'Es batu (opsional)',
      ],
      'Kue Timphan': [
        '200g beras ketan putih, rendam',
        '100g gula merah, parut',
        '100ml santan',
        '2 lembar daun pandan',
        '100g kelapa parut',
        'Pinch garam',
      ],
      'Sop Sumsum Aceh': [
        '500g sumsum sapi',
        '1 liter air kaldu sapi',
        '4 siung bawang putih, cincah',
        '3 buah bawang merah, iris',
        '100g wortel, potong kotak',
        '100g kentang, potong kotak',
        '50g buncis',
        '2 batang serai',
        '2 lembar daun salam',
        'Garam, merica, gula secukupnya',
      ],
    };
    return ingredients[recipeName] ?? ['Informasi bahan belum tersedia'];
  }

  // Data langkah-langkah untuk setiap resep
  List<String> _getSteps(String recipeName) {
    final steps = {
      'Mie Aceh Goreng': [
        'Rebus mie hingga setengah matang, tiriskan dan sisihkan.',
        'Panaskan minyak, goreng bawang merah dan putih hingga harum.',
        'Masukkan daging cincang, masak hingga kecoklatan.',
        'Tambahkan cabai merah, cabai giling, dan bawang merah, tumis hingga layu.',
        'Masukkan mie, aduk rata dengan bumbu.',
        'Tuangkan santan, aduk rata, masak hingga menyerap.',
        'Buat lubang di tengah mie, pecahkan telur ke dalamnya.',
        'Aduk rata hingga telur matang, sajikan panas-panas.',
      ],
      'Gulai Kambing Aceh': [
        'Potong daging kambing menjadi dadu-dadu berukuran sedang.',
        'Haluskan bawang merah, bawang putih, kunyit, dan jahe bersama.',
        'Panaskan minyak, tumis bumbu halus hingga harum.',
        'Masukkan daging kambing, aduk hingga berubah warna.',
        'Tuangkan santan, tambahkan cengkeh, kayu manis, dan kulit lada.',
        'Biarkan mendidih, kemudian kecilkan api dan masak sekitar 90 menit hingga daging empuk.',
        'Rasa santan sedikit berkurang dan daging terendam kuah yang gurih.',
        'Sajikan panas dengan nasi putih atau roti.',
      ],
      'Eungkot Paya (Asam Pedas)': [
        'Bersihkan ikan, potong menjadi bagian yang diinginkan, cuci bersih.',
        'Haluskan cabai merah, cabai rawit, bawang merah, bawang putih, dan jahe.',
        'Panaskan minyak, tumis bumbu halus hingga harum.',
        'Masukkan potongan ikan, aduk perlahan agar tidak hancur.',
        'Tuangkan air secukupnya, masukkan daun kunyit dan asam jawa.',
        'Biarkan mendidih, kemudian kecilkan api dan masak hingga ikan matang (±15 menit).',
        'Kuah harus terasa asam pedas yang seimbang.',
        'Sajikan panas dengan nasi putih.',
      ],
      'Sate Matang Bireuen': [
        'Potong daging menjadi dadu ukuran sedang, tusuk dengan kayu tusuk.',
        'Haluskan kunyit, jahe, bawang putih, dan cabai merah.',
        'Campur bumbu halus dengan santan, kecap manis, minyak, garam, gula, dan merica.',
        'Rendam daging sate dalam bumbu setidaknya 2 jam atau semalam.',
        'Panggang sate di atas bara api atau wajan dengan api sedang.',
        'Balik-balik sate hingga matang merata dan berwarna kecoklatan.',
        'Oleskan sisa bumbu saat memanggang untuk rasa yang lebih gurih.',
        'Sajikan dengan kecap manis, sambal, dan irisan bawang merah.',
      ],
      'Nasi Gurih Aceh': [
        'Cuci beras hingga bersih, tiriskan.',
        'Panaskan minyak, tumis bawang merah, bawang putih, cabai rawit, dan jahe.',
        'Masukkan beras, aduk hingga setiap butir beras terbalut bumbu.',
        'Tuangkan santan, tambahkan daun salam dan serai, aduk rata.',
        'Tambahkan air secukupnya (1:1 dengan beras atau sesuai kebiasaan memasak nasi).',
        'Biarkan mendidih, kemudian kecilkan api sampai nasi matang dengan api kecil.',
        'Jangan diaduk terlalu banyak, diamkan hingga airnya menyerap.',
        'Sajikan hangat dengan lauk samping favorit.',
      ],
      'Kopi Sanger Khas Aceh': [
        'Sediakan cangkir atau gelas yang besar.',
        'Tuangkan kopi hitam kental ke dalam gelas.',
        'Tambahkan air panas secukupnya, aduk rata.',
        'Masukkan gula pasir, aduk hingga larut.',
        'Tuangkan susu kental manis perlahan-lahan sambil diaduk.',
        'Jika suka minuman dingin, tambahkan es batu.',
        'Sajikan dengan gurih dan nikmatnya kopi tradisional Aceh.',
      ],
      'Kue Timphan': [
        'Cuci beras ketan, tiriskan dengan baik.',
        'Rebus beras ketan dengan santan dan daun pandan hingga empuk dan air terserap.',
        'Siapkan cetakan (kukusan atau cetakan tradisional).',
        'Tata gula merah, kelapa parut bergantian di bagian bawah cetakan.',
        'Tuangkan beras ketan ke dalam cetakan hingga penuh, padatkan sedikit.',
        'Kukus dalam air mendidih selama 20-30 menit.',
        'Angkat dan biarkan dingin, keluarkan dari cetakan.',
        'Sajikan dalam potongan segar atau bungkus daun.',
      ],
      'Sop Sumsum Aceh': [
        'Bersihkan sumsum sapi, cuci dengan air hangat hingga bersih.',
        'Potong sumsum menjadi potongan kecil-kecil.',
        'Didihkan air kaldu sapi dalam panci besar.',
        'Masukkan potongan sumsum, biarkan mendidih hingga mengapung.',
        'Ambil busa yang timbul, lalu masukkan bawang putih yang sudah digoyang dan bawang merah yang diiris.',
        'Tambahkan wortel dan kentang yang sudah dipotong, masak hingga lunak.',
        'Masukkan buncis dan bungkus serai beserta daun salam.',
        'Bumbui dengan garam, merica, dan gula, masak hingga semua bahan empuk dan bumbu terserap.',
        'Sajikan panas dengan roti atau nasi.',
      ],
    };
    return steps[recipeName] ?? ['Langkah memasak belum tersedia'];
  }
}
