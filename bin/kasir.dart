import 'dart:io';

/// Data satu produk di katalog (record bernama).
typedef Produk = ({String nama, String kategori, int harga});

/// Satu baris pesanan yang valid.
typedef ItemPesanan = ({String kode, Produk produk, int jumlah});

const int batasDiskon = 100000; // total minimal untuk mendapat diskon
const int persenDiskon = 10;

/// Mengubah 45000 menjadi "Rp45.000".
String rupiah(int n) {
  final s = n.toString();
  final buf = StringBuffer();
  for (var i = 0; i < s.length; i++) {
    if (i > 0 && (s.length - i) % 3 == 0) buf.write('.');
    buf.write(s[i]);
  }
  return 'Rp$buf';
}

void main() {
  final Map<String, Produk> katalog = {
    'P01': (nama: 'Kopi Sidikalang 250 g', kategori: 'Kopi', harga: 45000),
    'P02': (nama: 'Kopi Gayo 250 g', kategori: 'Kopi', harga: 55000),
    'P03': (nama: 'Teh Kayu Aro 100 g', kategori: 'Teh', harga: 25000),
    'P04': (nama: 'Gula Aren 500 g', kategori: 'Pemanis', harga: 30000),
    'P05': (nama: 'Bolu Meranti', kategori: 'Makanan', harga: 80000),
  };

  // TODO 1: katalog sebagai tabel rapi
  print('KATALOG TOKO OLEH-OLEH MEDAN');
  print('=' * 48);
  print('${'Kode'.padRight(6)}${'Nama'.padRight(26)}${'Harga'.padLeft(14)}');
  print('-' * 48);
  for (final e in katalog.entries) {
    print(
      '${e.key.padRight(6)}'
      '${e.value.nama.padRight(26)}'
      '${rupiah(e.value.harga).padLeft(14)}',
    );
  }
  print('=' * 48);

  stdout.write('Pesanan (contoh: P01x2, P03x1): ');
  final String input = stdin.readLineSync() ?? '';

  final List<ItemPesanan> diterima = [];
  final List<String> ditolak = [];

  // TODO 2: pecah input per item lalu per kode dan jumlah
  for (final mentah in input.split(',')) {
    final item = mentah.trim();
    if (item.isEmpty) continue; // lewati bagian kosong, mis. koma ganda

    final bagian = item.toLowerCase().split('x');
    if (bagian.length != 2) {
      ditolak.add('$item (format harus KODExJUMLAH)');
      continue;
    }

    final kode = bagian[0].trim().toUpperCase();
    final jumlah = int.tryParse(bagian[1].trim());
    if (jumlah == null || jumlah <= 0) {
      ditolak.add('$item (jumlah tidak valid)');
      continue;
    }

    // TODO 3: katalog[kode] bertipe Produk? (nullable), tangani null
    final produk = katalog[kode];
    if (produk == null) {
      ditolak.add('$item (kode $kode tidak ada)');
      continue;
    }
    // Setelah cek null di atas, produk otomatis dianggap Produk (bukan Produk?).
    diterima.add((kode: kode, produk: produk, jumlah: jumlah));
  }

  print('');
  if (diterima.isEmpty) {
    print('Tidak ada pesanan valid, struk tidak dicetak.');
    if (ditolak.isNotEmpty) {
      print('Item ditolak:');
      for (final d in ditolak) {
        print('  - $d');
      }
    }
    return;
  }

  // TODO 4: subtotal dengan map, total dengan fold, diskon 10%
  final List<int> subtotal = diterima
      .map((i) => i.produk.harga * i.jumlah)
      .toList();
  final int total = subtotal.fold<int>(0, (sum, n) => sum + n);
  final int diskon = total >= batasDiskon ? total * persenDiskon ~/ 100 : 0;
  final int bayar = total - diskon;
  final Set<String> kategori = diterima.map((i) => i.produk.kategori).toSet();

  // TODO 5: cetak struk, Set kategori, dan item ditolak
  print('STRUK BELANJA');
  print('=' * 48);
  for (var i = 0; i < diterima.length; i++) {
    final it = diterima[i];
    print(it.produk.nama);
    final rincian = '  ${rupiah(it.produk.harga)} x ${it.jumlah}';
    print('${rincian.padRight(30)}${rupiah(subtotal[i]).padLeft(18)}');
  }
  print('-' * 48);
  print('${'Total'.padRight(30)}${rupiah(total).padLeft(18)}');
  print(
    '${'Diskon ($persenDiskon%)'.padRight(30)}'
    '${('-${rupiah(diskon)}').padLeft(18)}',
  );
  print('${'Jumlah bayar'.padRight(30)}${rupiah(bayar).padLeft(18)}');
  print('=' * 48);
  print('Kategori dibeli : ${kategori.join(', ')}');

  if (ditolak.isNotEmpty) {
    print('Item ditolak    :');
    for (final d in ditolak) {
      print('  - $d');
    }
  }
}
