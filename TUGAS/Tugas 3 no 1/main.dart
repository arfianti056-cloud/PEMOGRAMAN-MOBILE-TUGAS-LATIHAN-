class StokHabisException implements Exception {
  final String pesan;

  StokHabisException(this.pesan);

  @override
  String toString() => 'StokHabisException: $pesan';
}

class ProdukTidakAda implements Exception {
  final String pesan;

  ProdukTidakAda(this.pesan);

  @override
  String toString() => 'ProdukTidakAda: $pesan';
}

abstract class Produk {
  String id;
  String nama;
  double harga;
  int stok;

  Produk({
    required this.id,
    required this.nama,
    required this.harga,
    required this.stok,
  });

  String deskripsi();
}

mixin BisaDiskon on Produk {
  double hitungHargaDiskon(double persen) {
    validasiDiskon(persen);

    double jumlahDiskon = harga * persen / 100;
    return harga - jumlahDiskon;
  }

  void validasiDiskon(double persen) {
    if (persen <= 0 || persen > 100) {
      throw ArgumentError('Diskon harus lebih dari 0% dan maksimal 100%.');
    }
  }
}

class ProdukDigital extends Produk with BisaDiskon {
  double ukuranMB;
  String formatFile;

  ProdukDigital({
    required super.id,
    required super.nama,
    required super.harga,
    required super.stok,
    required this.ukuranMB,
    required this.formatFile,
  });

  @override
  String deskripsi() {
    return 'Produk Digital | Format: $formatFile | '
        'Ukuran: ${ukuranMB.toStringAsFixed(1)} MB';
  }
}

class ProdukFisik extends Produk with BisaDiskon {
  double beratGram;
  String dimensi;

  ProdukFisik({
    required super.id,
    required super.nama,
    required super.harga,
    required super.stok,
    required this.beratGram,
    required this.dimensi,
  });

  @override
  String deskripsi() {
    return 'Produk Fisik | Berat: '
        '${beratGram.toStringAsFixed(0)} gram | '
        'Dimensi: $dimensi';
  }
}

class Keranjang {
  List<Produk> produk = [];

  void tambah(Produk item, {int jumlah = 1}) {
    if (jumlah <= 0) {
      throw ArgumentError('Jumlah produk harus lebih dari 0.');
    }

    if (item.stok < jumlah) {
      throw StokHabisException(
        'Stok ${item.nama} tidak mencukupi. '
        'Stok tersedia: ${item.stok}.',
      );
    }

    for (int i = 0; i < jumlah; i++) {
      produk.add(item);
    }

    print(
      '✓ ${item.nama} berhasil ditambahkan '
      'sebanyak $jumlah.',
    );
  }

  void hapus(Produk item) {
    if (!produk.contains(item)) {
      throw ProdukTidakAda('${item.nama} tidak terdapat di dalam keranjang.');
    }

    produk.remove(item);

    print('✓ ${item.nama} berhasil dihapus dari keranjang.');
  }

  double totalHarga() {
    double total = 0;

    for (Produk item in produk) {
      total += item.harga;
    }

    return total;
  }

  void tampilkanKeranjang() {
    print('\n========== ISI KERANJANG ==========');

    if (produk.isEmpty) {
      print('Keranjang masih kosong.');
      print('===================================');
      return;
    }

    Map<String, int> jumlahProduk = {};

    for (Produk item in produk) {
      jumlahProduk[item.nama] = (jumlahProduk[item.nama] ?? 0) + 1;
    }

    jumlahProduk.forEach((nama, jumlah) {
      Produk item = produk.firstWhere((produk) => produk.nama == nama);

      double subtotal = item.harga * jumlah;

      print(
        '- $nama x$jumlah '
        '| Subtotal: Rp${subtotal.toStringAsFixed(0)}',
      );
    });

    print('-----------------------------------');
    print('Total Harga: Rp${totalHarga().toStringAsFixed(0)}');
    print('===================================');
  }
}

class TokoService {
  List<Produk> daftarProduk;

  TokoService(this.daftarProduk);

  Future<Produk> cariProduk(String nama) async {
    await Future.delayed(const Duration(milliseconds: 500));

    for (Produk item in daftarProduk) {
      if (item.nama.toLowerCase() == nama.toLowerCase()) {
        return item;
      }
    }

    throw ProdukTidakAda('Produk "$nama" tidak ditemukan.');
  }

  Future<void> prosesCheckout(Keranjang keranjang) async {
    if (keranjang.produk.isEmpty) {
      throw ArgumentError('Checkout gagal karena keranjang kosong.');
    }

    await Future.delayed(const Duration(seconds: 1));

    Map<Produk, int> jumlahProduk = {};

    for (Produk item in keranjang.produk) {
      jumlahProduk[item] = (jumlahProduk[item] ?? 0) + 1;
    }

    for (var entry in jumlahProduk.entries) {
      Produk item = entry.key;
      int jumlah = entry.value;

      if (item.stok < jumlah) {
        throw StokHabisException(
          'Checkout gagal. Stok ${item.nama} '
          'tidak mencukupi.',
        );
      }
    }

    for (var entry in jumlahProduk.entries) {
      entry.key.stok -= entry.value;
    }

    double total = keranjang.totalHarga();

    print('\n✓ Checkout berhasil!');
    print('✓ Total pembayaran: Rp${total.toStringAsFixed(0)}');
    print('✓ Stok produk telah diperbarui.');

    keranjang.produk.clear();
  }
}

Future<void> main() async {
  print('================================================');
  print('       SISTEM MANAJEMEN TOKO ONLINE');
  print('================================================');

  ProdukDigital ebook = ProdukDigital(
    id: 'D001',
    nama: 'E-Book Flutter',
    harga: 75000,
    stok: 5,
    ukuranMB: 12.5,
    formatFile: 'PDF',
  );

  ProdukDigital template = ProdukDigital(
    id: 'D002',
    nama: 'Template UI Flutter',
    harga: 100000,
    stok: 3,
    ukuranMB: 25.0,
    formatFile: 'ZIP',
  );

  ProdukFisik mouse = ProdukFisik(
    id: 'F001',
    nama: 'Mouse Wireless',
    harga: 150000,
    stok: 4,
    beratGram: 250,
    dimensi: '10 x 6 x 4 cm',
  );

  ProdukFisik keyboard = ProdukFisik(
    id: 'F002',
    nama: 'Keyboard Mechanical',
    harga: 350000,
    stok: 2,
    beratGram: 800,
    dimensi: '35 x 12 x 4 cm',
  );

  ProdukFisik buku = ProdukFisik(
    id: 'F003',
    nama: 'Buku Pemrograman Dart',
    harga: 120000,
    stok: 0,
    beratGram: 500,
    dimensi: '23 x 15 x 3 cm',
  );

  TokoService toko = TokoService([ebook, template, mouse, keyboard, buku]);

  print('\n========== DAFTAR PRODUK ==========');

  for (Produk item in toko.daftarProduk) {
    print('\nID        : ${item.id}');
    print('Nama      : ${item.nama}');
    print('Harga     : Rp${item.harga.toStringAsFixed(0)}');
    print('Stok      : ${item.stok}');
    print('Deskripsi : ${item.deskripsi()}');
  }

  print('\n========== PERHITUNGAN DISKON ==========');

  try {
    double hargaDiskon = ebook.hitungHargaDiskon(10);

    print('Produk       : ${ebook.nama}');
    print('Harga Normal : Rp${ebook.harga.toStringAsFixed(0)}');
    print('Diskon       : 10%');
    print('Harga Akhir  : Rp${hargaDiskon.toStringAsFixed(0)}');
  } on ArgumentError catch (e) {
    print('✗ Gagal menghitung diskon: $e');
  } catch (e) {
    print('✗ Terjadi kesalahan: $e');
  }

  print('\n========== VALIDASI DISKON ==========');

  try {
    ebook.hitungHargaDiskon(120);
  } on ArgumentError catch (e) {
    print('✗ Diskon tidak valid: $e');
  } catch (e) {
    print('✗ Terjadi kesalahan: $e');
  }

  print('\n========== PENCARIAN PRODUK ==========');

  try {
    print('Mencari "Mouse Wireless"...');

    Produk hasil = await toko.cariProduk('Mouse Wireless');

    print('✓ Produk ditemukan!');
    print('Nama  : ${hasil.nama}');
    print('Harga : Rp${hasil.harga.toStringAsFixed(0)}');
  } on ProdukTidakAda catch (e) {
    print('✗ $e');
  } catch (e) {
    print('✗ Terjadi kesalahan: $e');
  }

  print('\n========== PRODUK TIDAK DITEMUKAN ==========');

  try {
    print('Mencari "Laptop Gaming"...');

    Produk hasil = await toko.cariProduk('Laptop Gaming');

    print('Produk ditemukan: ${hasil.nama}');
  } on ProdukTidakAda catch (e) {
    print('✗ $e');
  } catch (e) {
    print('✗ Terjadi kesalahan: $e');
  }

  Keranjang keranjang = Keranjang();

  print('\n========== MENAMBAHKAN PRODUK ==========');

  try {
    keranjang.tambah(ebook, jumlah: 1);
    keranjang.tambah(mouse, jumlah: 2);
    keranjang.tambah(keyboard, jumlah: 1);
  } on StokHabisException catch (e) {
    print('✗ $e');
  } on ArgumentError catch (e) {
    print('✗ $e');
  } catch (e) {
    print('✗ Terjadi kesalahan: $e');
  }

  keranjang.tampilkanKeranjang();

  print('\n========== PENGUJIAN STOK HABIS ==========');

  try {
    keranjang.tambah(buku, jumlah: 1);
  } on StokHabisException catch (e) {
    print('✗ $e');
  } on ArgumentError catch (e) {
    print('✗ $e');
  } catch (e) {
    print('✗ Terjadi kesalahan: $e');
  }

  print('\n========== PROSES CHECKOUT ==========');

  try {
    print('Memproses checkout...');

    await toko.prosesCheckout(keranjang);
  } on StokHabisException catch (e) {
    print('✗ $e');
  } on ArgumentError catch (e) {
    print('✗ $e');
  } catch (e) {
    print('✗ Terjadi kesalahan: $e');
  }

  print('\n========== STOK SETELAH CHECKOUT ==========');

  for (Produk item in toko.daftarProduk) {
    print('${item.nama}: ${item.stok}');
  }

  print('\n========== PENGUJIAN HAPUS PRODUK ==========');

  try {
    keranjang.hapus(mouse);
  } on ProdukTidakAda catch (e) {
    print('✗ $e');
  } catch (e) {
    print('✗ Terjadi kesalahan: $e');
  }

  print('\n================================================');
  print('              PROGRAM SELESAI');
  print('================================================');
}
