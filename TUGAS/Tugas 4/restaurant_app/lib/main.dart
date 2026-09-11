// ==================== IMPORT ====================

import 'package:flutter/material.dart';

// ==================== VOID MAIN ====================

void main() {
  runApp(const RestaurantApp());
}

// ==================== DATA MENU POPULER ====================

final List<Map<String, String>> menuPopuler = [
  {
    'nama': 'Grilled Sirloin Steak',
    'harga': '145.000',
    'gambar': 'https://images.unsplash.com/photo-1546833999-b9f581a1996d?auto=format&fit=crop&w=500&q=80',
  },
  {
    'nama': 'Truffle Carbonara',
    'harga': '98.000',
    'gambar': 'https://images.unsplash.com/photo-1473093295043-cdd812d0e601?auto=format&fit=crop&w=500&q=80',
  },
  {
    'nama': 'Grilled Salmon',
    'harga': '128.000',
    'gambar': 'https://images.unsplash.com/photo-1467003909585-2f8a72700288?auto=format&fit=crop&w=500&q=80',
  },
];

// ==================== WIDGET UTAMA ====================

class RestaurantApp extends StatelessWidget {
  const RestaurantApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Detail Restoran',

      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: const Color(0xfff5f5f5),
      ),

      home: const RestaurantDetailPage(),
    );
  }
}

// ==================== HALAMAN DETAIL RESTORAN ====================

class RestaurantDetailPage extends StatefulWidget {
  const RestaurantDetailPage({super.key});

  @override
  State<RestaurantDetailPage> createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  final Set<String> menuFavorite = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ==================== APP BAR ====================

      appBar: AppBar(
        title: const Text(
          'La Brasserie Bistro',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),

        centerTitle: true,

        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Membagikan restoran...')),
              );
            },

            icon: const Icon(Icons.share),
          ),
        ],
      ),

      // ==================== BODY ====================
      body: ListView(
        children: [
          // ==================== GAMBAR RESTORAN ====================

          Stack(
            children: [
              SizedBox(
                height: 230,
                width: double.infinity,

                child: Image.network(
                  'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?auto=format&fit=crop&w=1000&q=80',

                  fit: BoxFit.cover,

                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Icon(Icons.image_not_supported, size: 50),
                    );
                  },
                ),
              ),

              // ==================== BADGE KATEGORI ====================
              Positioned(
                top: 15,
                left: 15,

                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),

                  decoration: BoxDecoration(
                    color: Colors.white,

                    borderRadius: BorderRadius.circular(20),
                  ),

                  child: const Text(
                    'Western • Bistro',

                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),

          // ==================== INFORMASI UTAMA RESTORAN ====================
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),

            padding: const EdgeInsets.all(16),

            decoration: const BoxDecoration(
              color: Colors.white,

              borderRadius: BorderRadius.vertical(bottom: Radius.circular(18)),
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ==================== NAMA RESTORAN ====================

                const Text(
                  'La Brasserie Bistro',

                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 5),

                // ==================== RATING ====================
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.orange, size: 18),

                    const SizedBox(width: 4),

                    const Text(
                      '4.8',

                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),

                    const SizedBox(width: 6),

                    const Text(
                      '1.250 reviews',

                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // ==================== KATEGORI RESTORAN ====================
                Row(
                  children: [
                    const Icon(Icons.restaurant, size: 16, color: Colors.teal),

                    const SizedBox(width: 5),

                    const Text(
                      'Western • Bistro',

                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),

                const SizedBox(height: 6),

                // ==================== ALAMAT RESTORAN ====================
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 16, color: Colors.grey),

                    const SizedBox(width: 5),

                    const Expanded(
                      child: Text(
                        'Jl. Hasanudin No. 25, Ternate',

                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 15),

                // ==================== STATISTIK RESTORAN ====================
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),

                  decoration: BoxDecoration(
                    color: const Color(0xfff7f7f7),

                    borderRadius: BorderRadius.circular(12),
                  ),

                  child: Row(
                    children: [
                      _statistic(Icons.location_on, '2.5 km', 'Jarak'),

                      _statistic(
                        Icons.access_time,
                        '10.00 - 22.00',
                        'Waktu Buka',
                      ),

                      _statistic(
                        Icons.payments,
                        'Rp 100.000',
                        'Harga Rata-rata',
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 15),

                // ==================== TENTANG RESTORAN ====================
                const Text(
                  'Tentang Restoran',

                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 6),

                const Text(
                  'La Brasserie Bistro menawarkan berbagai '
                  'makanan Western dengan bahan pilihan dan '
                  'suasana restoran yang nyaman untuk keluarga. '
                  'Restoran ini cocok untuk makan bersama keluarga '
                  'maupun teman.',

                  maxLines: 3,

                  overflow: TextOverflow.ellipsis,

                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 5),

                // ==================== LIHAT SELENGKAPNYA ====================
                TextButton(
                  onPressed: () {},

                  child: const Text(
                    'Lihat Selengkapnya',

                    style: TextStyle(fontSize: 12),
                  ),
                ),

                const SizedBox(height: 8),

                // ==================== MENU POPULER ====================
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    const Text(
                      'Menu Populer',

                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    TextButton(
                      onPressed: () {},

                      child: const Text(
                        'Lihat Semua',

                        style: TextStyle(fontSize: 11),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 5),

                // ==================== 3 CARD MENU ====================
                Row(
                  children: menuPopuler.map((menu) {
                    return Expanded(
                      child: _menuCard(
                        menu,
                        menuFavorite.contains(menu['nama']),
                        () {
                          setState(() {
                            if (menuFavorite.contains(menu['nama'])) {
                              menuFavorite.remove(menu['nama']);
                            } else {
                              menuFavorite.add(menu['nama']!);
                            }
                          });
                        },
                      ),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 75),
              ],
            ),
          ),
        ],
      ),

      // ==================== FLOATING ACTION BUTTON ====================
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _reservasi(context);
        },

        backgroundColor: Colors.teal,

        icon: const Icon(Icons.calendar_month, color: Colors.white),

        label: const Text(
          'Reservasi Sekarang',

          style: TextStyle(color: Colors.white),
        ),
      ),

      // ==================== POSISI FLOATING ACTION BUTTON ====================
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  // ==================== FUNGSI STATISTIK ====================

  static Widget _statistic(IconData icon, String value, String label) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: Colors.teal, size: 20),

          const SizedBox(height: 4),

          Text(
            value,

            textAlign: TextAlign.center,

            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 2),

          Text(
            label,

            textAlign: TextAlign.center,

            style: const TextStyle(color: Colors.grey, fontSize: 9),
          ),
        ],
      ),
    );
  }

  // ==================== FUNGSI CARD MENU ====================

  static Widget _menuCard(
    Map<String, String> menu,
    bool isFavorite,
    VoidCallback onFavoritePressed,
  ) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 3),

      elevation: 2,

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),

      clipBehavior: Clip.antiAlias,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          // ==================== GAMBAR MENU + FAVORITE ====================

          Stack(
            children: [
              SizedBox(
                height: 75,
                width: double.infinity,

                child: Image.network(
                  menu['gambar']!,

                  fit: BoxFit.cover,

                  errorBuilder: (context, error, stackTrace) {
                    return const Center(child: Icon(Icons.image_not_supported));
                  },
                ),
              ),

              // ==================== ICON FAVORITE ====================
              Positioned(
                top: 3,
                right: 3,

                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),

                  child: IconButton(
                    onPressed: onFavoritePressed,

                    padding: EdgeInsets.zero,

                    constraints: const BoxConstraints(
                      minWidth: 28,
                      minHeight: 28,
                    ),

                    iconSize: 17,

                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,

                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // ==================== INFORMASI MENU ====================
          Padding(
            padding: const EdgeInsets.all(7),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                // ==================== NAMA MENU ====================

                Text(
                  menu['nama']!,

                  maxLines: 2,

                  overflow: TextOverflow.ellipsis,

                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 4),

                // ==================== HARGA MENU ====================
                Text(
                  'Rp ${menu['harga']}',

                  style: const TextStyle(
                    color: Colors.teal,
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==================== FUNGSI RESERVASI ====================

  static void _reservasi(BuildContext context) {
    showDialog(
      context: context,

      builder: (context) {
        return AlertDialog(
          // ==================== JUDUL DIALOG ====================

          title: const Text('Reservasi Restoran'),

          // ==================== ISI DIALOG ====================
          content: const Text(
            'Apakah Anda ingin melakukan reservasi '
            'di La Brasserie Bistro?',
          ),

          // ==================== TOMBOL DIALOG ====================
          actions: [
            // ==================== TOMBOL BATAL ====================

            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },

              child: const Text('Batal'),
            ),

            // ==================== TOMBOL RESERVASI ====================
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Reservasi berhasil dibuat!')),
                );
              },

              child: const Text('Reservasi'),
            ),
          ],
        );
      },
    );
  }
}
