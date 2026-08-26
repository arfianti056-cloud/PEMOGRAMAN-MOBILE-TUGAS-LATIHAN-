import 'package:flutter/material.dart';

void main() {
  runApp(const KatalogBukuApp());
}

final List<Map<String, dynamic>> daftarBuku = [
  {
    'judul': 'Laskar Pelangi',
    'pengarang': 'Andrea Hirata',
    'tahunTerbit': 2005,
    'rating': 4.8,
    'tersedia': true,
    'genre': 'Novel',
  },
  {
    'judul': 'Bumi',
    'pengarang': 'Tere Liye',
    'tahunTerbit': 2014,
    'rating': 4.6,
    'tersedia': true,
    'genre': 'Fantasi',
  },
  {
    'judul': 'Negeri 5 Menara',
    'pengarang': 'Ahmad Fuadi',
    'tahunTerbit': 2009,
    'rating': 4.4,
    'tersedia': false,
    'genre': 'Novel',
  },
  {
    'judul': 'Pulang',
    'pengarang': 'Tere Liye',
    'tahunTerbit': 2015,
    'rating': 4.2,
    'tersedia': true,
    'genre': 'Drama',
  },
  {
    'judul': 'Filosofi Teras',
    'pengarang': 'Henry Manampiring',
    'tahunTerbit': 2018,
    'rating': 4.7,
    'tersedia': false,
    'genre': 'Pengembangan Diri',
  },
  {
    'judul': 'Atomic Habits',
    'pengarang': 'James Clear',
    'tahunTerbit': 2018,
    'rating': 4.9,
    'tersedia': true,
    'genre': 'Pengembangan Diri',
  },
];

String kategoriRating(double rating) {
  if (rating >= 4.5) {
    return 'Sangat Baik';
  } else if (rating >= 3.5) {
    return 'Baik';
  } else {
    return 'Cukup';
  }
}

String formatStatus(bool tersedia) {
  return tersedia ? 'Tersedia' : 'Dipinjam';
}

class KatalogBukuApp extends StatelessWidget {
  const KatalogBukuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Katalog Buku',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const HalamanUtama(),
    );
  }
}

class HalamanUtama extends StatefulWidget {
  const HalamanUtama({super.key});

  @override
  State<HalamanUtama> createState() => _HalamanUtamaState();
}

class _HalamanUtamaState extends State<HalamanUtama> {
  String kataPencarian = '';

  @override
  Widget build(BuildContext context) {
    final Set<String> genreUnik = daftarBuku
        .map((buku) => buku['genre'] as String)
        .toSet();

    final bukuHasilPencarian = daftarBuku.where((buku) {
      final String judul = buku['judul'];

      return judul.toLowerCase().contains(kataPencarian.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Katalog Buku Perpustakaan',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Cari Buku',
                hintText: 'Masukkan judul buku...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  kataPencarian = value;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Wrap(
                spacing: 8,
                children: genreUnik.map((genre) {
                  return Chip(label: Text(genre));
                }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: bukuHasilPencarian.length,
              itemBuilder: (context, index) {
                final buku = bukuHasilPencarian[index];

                final String judul = buku['judul'];
                final String pengarang = buku['pengarang'];
                final int tahunTerbit = buku['tahunTerbit'];
                final double rating = buku['rating'];
                final bool tersedia = buku['tersedia'];
                final String genre = buku['genre'];

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          judul,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text('Pengarang: $pengarang'),
                        Text('Tahun Terbit: $tahunTerbit'),
                        Text('Genre: $genre'),
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber),
                            const SizedBox(width: 5),
                            Text(
                              '$rating - '
                              '${kategoriRating(rating)}',
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: tersedia ? Colors.green : Colors.red,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            formatStatus(tersedia),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return HalamanDetail(buku: buku);
                                  },
                                ),
                              ).then((_) {
                                setState(() {});
                              });
                            },
                            child: const Text('Lihat Detail'),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class HalamanDetail extends StatefulWidget {
  final Map<String, dynamic> buku;

  const HalamanDetail({super.key, required this.buku});

  @override
  State<HalamanDetail> createState() => _HalamanDetailState();
}

class _HalamanDetailState extends State<HalamanDetail> {
  String? catatanPeminjam;

  @override
  Widget build(BuildContext context) {
    final buku = widget.buku;
    final bool tersedia = buku['tersedia'];

    return Scaffold(
      appBar: AppBar(title: const Text('Detail Buku')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              buku['judul'],
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text('Pengarang: ${buku['pengarang']}'),
            Text('Tahun Terbit: ${buku['tahunTerbit']}'),
            Text('Rating: ${buku['rating']}'),
            Text(
              'Kategori: '
              '${kategoriRating(buku['rating'])}',
            ),
            Text('Genre: ${buku['genre']}'),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text(
                  'Status: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  formatStatus(tersedia),
                  style: TextStyle(
                    color: tersedia ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(height: 30),
            const Text(
              'Catatan Peminjam:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(catatanPeminjam ?? '(Tidak ada catatan)'),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: tersedia
                    ? () {
                        setState(() {
                          buku['tersedia'] = false;
                          catatanPeminjam = 'Buku sedang dipinjam.';
                        });
                      }
                    : () {
                        setState(() {
                          buku['tersedia'] = true;
                          catatanPeminjam = null;
                        });
                      },
                child: Text(tersedia ? 'Pinjam Buku' : 'Kembalikan Buku'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
