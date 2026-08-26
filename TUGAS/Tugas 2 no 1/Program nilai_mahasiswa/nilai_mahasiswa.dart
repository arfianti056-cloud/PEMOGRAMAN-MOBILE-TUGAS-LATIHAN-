double hitungRataRata(List<int> nilai) {
  if (nilai.isEmpty) {
    return 0.0;
  }
  int total = 0;

  for (int n in nilai) {
    total += n;
  }
  return total / nilai.length;
}

String tentukanGrade(double rataRata) {
  if (rataRata >= 80) {
    return 'A';
  } else if (rataRata >= 70) {
    return 'B';
  } else if (rataRata >= 60) {
    return 'C';
  } else if (rataRata >= 50) {
    return 'D';
  } else {
    return 'E';
  }
}

bool cekKelulusan({required double rataRata, required int absensi}) {
  return rataRata >= 60 && absensi <= 3;
}

void main() {
  final Map<String, Map<String, Object>> mahasiswa = {
    'mahasiswa1': {
      'nama': 'Budi Santoso',
      'nilai': [85, 90, 78, 92, 88],
      'abesensi': 1,
    },
    'mahasiswa2': {
      'nama': 'Siti Rahayu',
      'nilai': [55, 60, 58, 52, 45],
      'absensi': 2,
    },
    'mahasiswa3': {
      'nama': 'Andi Pratama',
      'nilai': [75, 75, 75, 75, 75],
      'absensi': 1,
    },
    'mahasiswa4': {
      'nama': "Dewi Lestari",
      'nilai': [70, 70, 70, 70, 70],
      'absensi': 2,
    },
    'mahasiswa5': {
      'nama': 'Rizky Maulana',
      'nilai': [80, 80, 81, 80, 81],
      'absensi': 3,
    },
  };

  int nilaiTertinggi = 0;
  int nilaiTerendah = 100;

  double totalRataRata = 0.0;

  print('=====LAPORAN NILAI MAHASISWA=====');

  for (final data in mahasiswa.values) {
    final String nama = data['nama'] as String;
    final List<int> nilai = List<int>.from(data['nilai'] as List);
    final int absensi = data['absensi'] as int;

    final double rataRata = hitungRataRata(nilai);

    final String grade = tentukanGrade(rataRata);
    final bool lulus = cekKelulusan(rataRata: rataRata, absensi: absensi);
    totalRataRata += rataRata;

    for (final n in nilai) {
      if (n > nilaiTertinggi) {
        nilaiTertinggi = n;
      }
      if (n < nilaiTerendah) {
        nilaiTerendah = n;
      }
    }
    print('nama : $nama');
    print('nilai: $nilai');
    print('Rata-rata: ${rataRata.toStringAsFixed(1)}');
    print('Grade: $grade');

    print('Status: ${lulus ? 'lulus' : 'Tidak lulus'}');
    print('');
    final double rataRataKelas = totalRataRata / mahasiswa.length;

    print('====STATISTIK KELAS');
    print('Nilai Tertinggi: $nilaiTertinggi');
    print('Nilai Terendah: $nilaiTerendah');
    print(
      'Rata -Rata:'
      '$rataRataKelas.toStringAsFixed(1)',
    );
  }
}
