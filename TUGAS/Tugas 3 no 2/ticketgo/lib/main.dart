import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

// =======================
// OOP: ABSTRACT CLASS
// =======================

abstract class Tiket {
  String nama;
  double harga;

  Tiket(this.nama, this.harga);

  String deskripsi();
}

// =======================
// MIXIN DISKON
// =======================

mixin BisaDiskon on Tiket {
  double hitungHargaDiskon(double persen) {
    return harga - (harga * persen / 100);
  }
}

// =======================
// SUBCLASS 1
// =======================

class TiketEkonomi extends Tiket {
  TiketEkonomi(String nama, double harga) : super(nama, harga);

  @override
  String deskripsi() {
    return 'Kelas Ekonomi - Fasilitas standar';
  }
}

// =======================
// SUBCLASS 2 + MIXIN
// =======================

class TiketVIP extends Tiket with BisaDiskon {
  TiketVIP(String nama, double harga) : super(nama, harga);

  @override
  String deskripsi() {
    return 'Kelas VIP - Fasilitas lengkap';
  }
}

// =======================
// CUSTOM EXCEPTION
// =======================

class TiketHabisException implements Exception {
  String pesan;

  TiketHabisException(this.pesan);

  @override
  String toString() => pesan;
}

// =======================
// FUTURE DAFTAR TIKET
// =======================

Future<List<Tiket>> ambilDaftarTiket() async {
  await Future.delayed(const Duration(seconds: 2));

  // Simulasi error mengambil data
  if (Random().nextInt(5) == 0) {
    throw Exception('Gagal mengambil data tiket.');
  }

  return [
    TiketEkonomi('Ekonomi Regular', 50000),
    TiketEkonomi('Ekonomi Weekend', 75000),
    TiketVIP('VIP Weekend', 150000),
  ];
}

// =======================
// FUTURE PEMESANAN
// =======================

Future<String> pesanTiket(Tiket tiket) async {
  await Future.delayed(const Duration(seconds: 2));

  // Kemungkinan tiket habis 25%
  if (Random().nextInt(4) == 0) {
    throw TiketHabisException('${tiket.nama} sedang habis. Silakan coba lagi.');
  }

  return 'Pemesanan berhasil dilakukan.';
}

// =======================
// RIWAYAT PEMESANAN
// =======================

List<Map<String, dynamic>> riwayatPesanan = [];

// =======================
// MAIN
// =======================

void main() {
  runApp(const TicketGo());
}

// =======================
// APLIKASI
// =======================

class TicketGo extends StatelessWidget {
  const TicketGo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TicketGo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

// =======================
// HOME PAGE
// =======================

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Tiket>> daftarTiket;

  @override
  void initState() {
    super.initState();
    daftarTiket = ambilDaftarTiket();
  }

  void cobaLagi() {
    setState(() {
      daftarTiket = ambilDaftarTiket();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'TicketGo',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const RiwayatPage()),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Tiket>>(
        future: daftarTiket,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 15),
                  Text('Memuat daftar tiket...'),
                ],
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error, size: 70, color: Colors.red),
                    const SizedBox(height: 15),
                    const Text(
                      'Gagal memuat daftar tiket',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      snapshot.error.toString(),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: cobaLagi,
                      child: const Text('Coba Lagi'),
                    ),
                  ],
                ),
              ),
            );
          }

          final tiket = snapshot.data ?? [];

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const PromoCountdown(),
              const SizedBox(height: 20),

              const Text(
                'Daftar Tiket',
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              ...tiket.map((item) => TicketCard(tiket: item)),
            ],
          );
        },
      ),
    );
  }
}

// =======================
// TICKET CARD
// =======================

class TicketCard extends StatelessWidget {
  final Tiket tiket;

  const TicketCard({super.key, required this.tiket});

  @override
  Widget build(BuildContext context) {
    final bool vip = tiket is TiketVIP;

    double hargaAkhir = tiket.harga;

    if (vip) {
      hargaAkhir = (tiket as TiketVIP).hitungHargaDiskon(10);
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                color: vip ? Colors.orange.shade100 : Colors.green.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.event_seat,
                size: 35,
                color: vip ? Colors.orange : Colors.green,
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tiket.nama,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(tiket.deskripsi(), style: const TextStyle(fontSize: 12)),

                  const SizedBox(height: 7),

                  if (vip) ...[
                    Text(
                      'Rp${tiket.harga.toStringAsFixed(0)}',
                      style: const TextStyle(
                        color: Colors.red,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    Text(
                      'Diskon 10%  •  Rp${hargaAkhir.toStringAsFixed(0)}',
                      style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ] else
                    Text(
                      'Rp${tiket.harga.toStringAsFixed(0)}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                ],
              ),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => BookingPage(tiket: tiket)),
                );
              },
              child: const Text('Pesan'),
            ),
          ],
        ),
      ),
    );
  }
}

// =======================
// BOOKING PAGE
// =======================

class BookingPage extends StatefulWidget {
  final Tiket tiket;

  const BookingPage({super.key, required this.tiket});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final namaController = TextEditingController();
  final nomorController = TextEditingController();

  bool sedangMemesan = false;

  double get hargaAkhir {
    if (widget.tiket is TiketVIP) {
      return (widget.tiket as TiketVIP).hitungHargaDiskon(10);
    }

    return widget.tiket.harga;
  }

  @override
  void dispose() {
    namaController.dispose();
    nomorController.dispose();
    super.dispose();
  }

  Future<void> prosesPesanan() async {
    if (namaController.text.trim().isEmpty ||
        nomorController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nama dan nomor HP harus diisi.')),
      );
      return;
    }

    setState(() {
      sedangMemesan = true;
    });

    try {
      await pesanTiket(widget.tiket);

      riwayatPesanan.add({
        'nama': namaController.text.trim(),
        'nomor': nomorController.text.trim(),
        'tiket': widget.tiket.nama,
        'harga': hargaAkhir,
      });

      if (!mounted) return;

      await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Pemesanan Berhasil'),
          content: Text(
            'Terima kasih, ${namaController.text}!\n\n'
            'Tiket: ${widget.tiket.nama}\n'
            'Nomor HP: ${nomorController.text}\n'
            'Harga: Rp${hargaAkhir.toStringAsFixed(0)}',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );

      if (mounted) {
        Navigator.pop(context);
      }
    } on TiketHabisException catch (e) {
      if (!mounted) return;

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Tiket Habis'),
          content: Text(e.toString()),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      if (!mounted) return;

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Terjadi Kesalahan'),
          content: Text(e.toString()),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          sedangMemesan = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool vip = widget.tiket is TiketVIP;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pemesanan Tiket'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Informasi tiket
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.tiket.nama,
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(widget.tiket.deskripsi()),

                  const Divider(height: 25),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Harga Normal'),
                      Text('Rp${widget.tiket.harga.toStringAsFixed(0)}'),
                    ],
                  ),

                  if (vip) ...[
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Diskon 10%',
                          style: TextStyle(color: Colors.green),
                        ),
                        Text(
                          '- Rp15.000',
                          style: TextStyle(color: Colors.green),
                        ),
                      ],
                    ),
                  ],

                  const Divider(height: 25),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Harga Setelah Diskon',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Rp${hargaAkhir.toStringAsFixed(0)}',
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            'Data Pemesan',
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 12),

          TextField(
            controller: namaController,
            decoration: const InputDecoration(
              labelText: 'Nama Pemesan',
              hintText: 'Masukkan nama lengkap',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.person),
            ),
          ),

          const SizedBox(height: 12),

          TextField(
            controller: nomorController,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              labelText: 'Nomor HP',
              hintText: 'Masukkan nomor HP',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.phone),
            ),
          ),

          const SizedBox(height: 20),

          SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: sedangMemesan ? null : prosesPesanan,
              child: sedangMemesan
                  ? const CircularProgressIndicator()
                  : const Text(
                      'Konfirmasi Pesanan',
                      style: TextStyle(fontSize: 16),
                    ),
            ),
          ),

          const SizedBox(height: 10),

          OutlinedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const RiwayatPage()),
              );
            },
            child: const Text('Lihat Riwayat'),
          ),
        ],
      ),
    );
  }
}

// =======================
// RIWAYAT PAGE
// =======================

class RiwayatPage extends StatefulWidget {
  const RiwayatPage({super.key});

  @override
  State<RiwayatPage> createState() => _RiwayatPageState();
}

class _RiwayatPageState extends State<RiwayatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Pemesanan'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: riwayatPesanan.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.receipt_long, size: 70, color: Colors.grey),
                  SizedBox(height: 15),
                  Text('Belum ada riwayat pemesanan.'),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: riwayatPesanan.length,
              itemBuilder: (context, index) {
                final pesanan = riwayatPesanan[index];

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: const Icon(Icons.receipt_long),
                    ),
                    title: Text(
                      pesanan['tiket'],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'Nama: ${pesanan['nama']}\n'
                      'HP: ${pesanan['nomor']}\n'
                      'Harga: Rp${(pesanan['harga'] as double).toStringAsFixed(0)}',
                    ),
                  ),
                );
              },
            ),
    );
  }
}

// =======================
// BONUS STREAMBUILDER
// =======================

class PromoCountdown extends StatefulWidget {
  const PromoCountdown({super.key});

  @override
  State<PromoCountdown> createState() => _PromoCountdownState();
}

class _PromoCountdownState extends State<PromoCountdown> {
  late Stream<int> countdown;

  @override
  void initState() {
    super.initState();

    countdown = Stream.periodic(
      const Duration(seconds: 1),
      (detik) => 60 - detik,
    ).take(61);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: countdown,
      initialData: 60,
      builder: (context, snapshot) {
        final waktu = snapshot.data ?? 0;

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.blue.shade200),
          ),
          child: Row(
            children: [
              const Icon(Icons.alarm, size: 40, color: Colors.blue),

              const SizedBox(width: 15),

              const Expanded(
                child: Text(
                  'Waktu tersisa untuk\nmemesan tiket promo',
                  style: TextStyle(fontSize: 15),
                ),
              ),

              Text(
                '$waktu detik',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
