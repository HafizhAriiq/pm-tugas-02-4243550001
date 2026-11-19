Tugas Rutin 2 — Aplikasi Console Kasir Sederhana
a. Identitas	
Nama:Hafizh Ariiq
NIM:4243550001
Program Studi:Ilmu Komputer, FMIPA, Universitas Negeri Medan
Mata Kuliah:Pemrograman Mobile (3KOM40215), Semester 5
Pertemuan:2 — Dasar Bahasa Dart
Dosen Pengampu:Adidtya Perdana, S.T., M.Kom
Deskripsi Singkat

Program console Dart untuk toko oleh-oleh di Medan. Program menampilkan katalog produk, menerima pesanan dalam satu baris (contoh: P01x2, P03x1), lalu mencetak struk belanja. Diskon 10% diberikan jika total belanja minimal Rp100.000. Kode produk yang tidak ada atau jumlah yang tidak valid tidak membuat program crash, melainkan dicatat sebagai item yang ditolak.

Cara menjalankan:
dart run bin/kasir.dart
b. Tangkapan Layar
Skenario 1 — Pesanan valid
Input: P01x2, P03x1

![Skenario pesanan valid](gambar\pesanan_valid.png)

Skenario 2 — Pesanan mengandung kode salah
Input: P01x2, P09x1, P02xabc

![Skenario pesanan invalid](gambar\pesanan_invalid.png)

c. Penjelasan (kata-kata sendiri, 100–200 kata)

var atau variabel dipakai kalau tipe data bisa ditebak dari nilai awalnya. Nilainya masih bisa diubah, tapi tipe datanya tetap.

final dipakai untuk nilai yang cukup diisi sekali saja, contohnya input pesanan.

const dipakai untuk nilai tetap yang sudah diketahui dari awal. Di program ini saya belum perlu memakai const.

Null safety membantu supaya program tidak error saat mendapat nilai kosong. int.tryParse() bisa menghasilkan null kalau jumlah yang dimasukkan bukan angka, jadi jumlah seperti itu bisa ditolak. stdin.readLineSync() ?? '' juga membuat input kosong tetap diproses sebagai teks kosong. di code saya sendiri ada di beberapa baris tapi yang ingin saya tunjukkan ada di baris ke 45 dimana kode nya bertuliskan ( final String input = stdin.readLineSync() ?? '';), saya mengunakan ini sebagai pencegahan inputan keyboard

d. Pernyataan Penggunaan AI
Saya menggunakan Claude (Anthropic) sebagai asisten untuk membantu menyusun kerangka kode bin/kasir.dart dan draf README ini. Saya sudah membaca, menjalankan, dan menguji program serta memahami cara kerjanya. Penjelasan pada bagian c saya tulis sendiri.