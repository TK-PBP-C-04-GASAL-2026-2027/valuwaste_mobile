# ValuWaste

## Daftar Isi

1. [Anggota Kelompok](#anggota-kelompok)
2. [Deskripsi Proyek](#deskripsi-proyek)
3. [Value Proposition Questions](#value-proposition-questions)
4. [Perbandingan dengan Kompetitor](#perbandingan-dengan-kompetitor)
5. [Jenis & Peran Pengguna Aplikasi](#jenis--peran-pengguna-aplikasi)
6. [Modul yang Diimplementasikan](#modul-yang-diimplementasikan)
7. [Daftar Endpoint API](#daftar-endpoint-api)
8. [Sumber Data](#sumber-data)
9. [Cara Menjalankan](#cara-menjalankan)
10. [Struktur Folder](#struktur-folder)
11. [Tautan](#tautan)
12. [Deklarasi Penggunaan AI](#deklarasi-penggunaan-ai)

## Anggota Kelompok

Kelompok 4 - Kelas PBP C

| No | Nama | NPM |
|---|---|---|
| 1 | Enrico Oscar Harits Caloh | 2506539990 |
| 2 | Pearlita Anindya Prameswari | 2506547670 |
| 3 | Muhammad Faza Aqila | 2506613142 |
| 4 | Jeudi Augusto Asadullah | 2506656822 |
| 5 | Rania Aqila | 2506623282 |

## Deskripsi Proyek

ValuWaste adalah platform marketplace limbah bernilai ekonomis yang menghubungkan masyarakat dan pelaku usaha yang memiliki limbah dengan pembeli bisnis yang membutuhkan material tersebut.

ValuWaste ditujukan untuk mengatasi kesulitan penjual dalam menemukan pembeli, terutama bagi penjual yang memiliki limbah dalam jumlah kecil, serta kesulitan bisnis dalam memperoleh limbah dalam jumlah besar dari satu sumber. Melalui ValuWaste, pembeli dapat mencari limbah berdasarkan kategori dan memenuhi kebutuhannya dengan menggabungkan pasokan dari beberapa penjual. Sistem ini dapat memberikan peluang yang lebih merata bagi penjual baru untuk ditemukan oleh pembeli sehingga penjual yang mendominasi pasar tidak hanya penjual yang sudah populer.

Selain itu, ValuWaste juga bertujuan mendorong masyarakat untuk mendaur ulang dengan mengubah limbah yang mereka miliki menjadi sumber nilai ekonomi.

## Value Proposition Questions

**1. What does our product do?**
ValuWaste menghubungkan masyarakat serta pelaku usaha yang ingin membuat limbah yang mereka miliki menjadi sesuatu yang bernilai ekonomis dengan para pembeli bisnis yang membutuhkan.

**2. How does our product work?**
Masyarakat, yang berperan sebagai penjual, akan mengunggah jenis, jumlah, serta kondisi dari limbah yang ingin dijual. Pembeli bisnis kemudian memilih kategori limbah dan menentukan jumlah yang dibutuhkan. Apabila ketersediaan limbah yang dibutuhkan tidak memadai pada satu penjual, pembeli bisnis dapat menggabungkan ketersediaan dari beberapa penjual hingga kebutuhannya terpenuhi.

**3. What are the emotional drivers of purchasing?**
- Penjual dan pembeli di sini dapat merasa berkontribusi terhadap lingkungan dengan mendaur ulang limbah.
- Penjual (masyarakat) dapat merasa bahwa limbah yang awalnya tidak memiliki nilai, sekarang dapat memiliki nilai ekonomis.

**4. Risks of switching to our product?**
- Pengguna (khususnya pembeli bisnis) mungkin belum dapat percaya kualitas dan kondisi limbah yang dijual
- Penjual (masyarakat) mungkin khawatir limbahnya tidak laku terjual dengan harga yang tidak sesuai
- Pembeli bisnis mungkin khawatir adanya kualitas yang inkonsisten apabila limbah yang dibeli berasal dari beberapa penjual
- Pengguna yang sebelumnya menggunakan sistem bank sampah mungkin sudah nyaman dengan cara lama

**5. What are the rational drivers of purchasing?**
- Penjual (masyarakat) dapat menghasilkan uang dari menjual limbah
- Penjual yang memiliki limbah dalam kuantitas kecil tetap dapat menjual limbahnya
- Pembeli bisnis dapat memperoleh jumlah limbah yang lebih besar dengan menggabungkan supply dari beberapa seller
- Pembeli bisnis dapat mencari limbah berdasarkan kategori dan jumlah yang dibutuhkan
- Transaksi jual-beli dan pencarian seller dapat terjadi secara terpusat dan praktis pada satu platform.

**6. What do people currently do instead?**
- **Penjual (masyarakat):** Menyimpan limbah dan memberikan ke pengepul, menjual ke bank sampah, mencari lewat media sosial, atau bahkan membuang limbah secara langsung.
- **Pembeli bisnis:** Membeli lewat pengepul secara langsung atau bekerja sama dengan bank sampah atau perusahaan pengelola limbah

## Perbandingan dengan Kompetitor

ValuWaste memiliki konsep serupa dengan platform pengelolaan limbah lainnya, seperti Rekosistem, Waste4Change, dan Reresik Marketplace. Rekosistem berfokus pada platform pendauran ulang dan pengelolaan limbah berkelanjutan. Waste4Change berfokus pada solusi pengelolaan sampah secara menyeluruh. Reresik Marketplace berfokus pada aktivitas jual-beli limbah yang dihubungkan langsung dengan pengepul besar.

Perbedaan utama ValuWaste ada pada mekanisme penggabungan pasokan dari penjual yang berbeda. Kami ingin menekankan narasi bahwa penjual, dalam konteks ini masyarakat, yang memiliki limbah sedikit juga dapat menjual kepada pembeli bisnis, layaknya pengepul, tanpa melalui perantara lain. Dengan adanya hal ini, apabila pembeli bisnis membutuhkan limbah dalam jumlah yang besar, kebutuhan tidak harus dipenuhi oleh satu penjual. Selain itu, ValuWaste memiliki sistem pencarian berbasis kategori sehingga kesempatan visibilitas masing-masing penjual menjadi lebih merata. Hal ini memungkinkan penjual baru untuk tetap memiliki peluang menjangkau pembeli.

## Jenis & Peran Pengguna Aplikasi

### 1. Penyedia Limbah
- **Target user:** Masyarakat umum, bank sampah, serta pelaku UMKM yang menghasilkan limbah (contoh: sektor F&B, tekstil, percetakan, dll)
- **Motivasi user:** Menjual limbah yang masih memiliki nilai ekonomis meskipun dalam jumlah/kuantitas terbatas, mendapatkan sumber penghasilan sampingan, memperoleh akses pasar yang setara tanpa terhalang oleh dominasi seller skala besar
- **Peran user:** Mengelola profil penjual, mengunggah dan mengedit listing limbah, menerima notifikasi alokasi pesanan dari pembeli, memberikan limbah ke jasa pengirim, dan memantau pendapatan

### 2. Pembeli Limbah
- **Target user:** Perusahaan daur ulang, pabrik manufaktur pemanfaat bahan baku daur ulang
- **Motivasi user:** Memotong waktu pencarian supplier dan memenuhi kebutuhan pasokan bahan baku limbah
- **Peran user:** Melengkapi profile pembeli, mencari limbah yang diinginkan di katalog berbasis kategori material, menginput kebutuhan total volume limbah, membeli (check-out) limbah, melakukan konfirmasi penyelesaian proses pembayaran, melacak status pengiriman, dan melakukan konfirmasi penerimaan barang.

### 3. Admin
- **Target user:** tim pengelola aplikasi
- **Peran user:** Memastikan integritas data transaksi, verifikasi validitas akun bisnis/penjual, mengelola data kategori limbah, serta menangani penyelesaian kendala.

## Modul yang Diimplementasikan

| Modul | Penanggung jawab | Branch | Folder Flutter | API Django |
|---|---|---|---|---|
| 1. Autentikasi, RBAC & User Profile | Jeudi Augusto Asadullah | `modul_1_jeudi` | `lib/features/auth/` | Data demo lokal |
| 2. Waste Inventory & Listing | Pearlita Anindya Prameswari | `modul_2_pearl` | `lib/features/listings/` | menyusul |
| 3. Discovery & Category-First Search | Rania Aqila | `modul_3_nia` | `lib/features/discovery/` | menyusul |
| 4. Waste Request & Supply Aggregation | Muhammad Faza Aqila | `modul_4_faza` | `lib/features/aggregation/` | `/api/v1/aggregation/` |
| 5. Transaction, Tracking & Dashboards | Enrico Oscar Harits Caloh | `modul_5_rico` | `lib/features/transactions/` | `/api/v1/transactions/` |

Kode bersama (tema, navigasi, koneksi API) ada di `lib/core/`.

### Modul 1 pada Checkpoint 1

Jeudi Augusto Asadullah (2506656822) mengerjakan alur masuk, tampilan profil, menu sesuai peran, dan keluar di Flutter. Untuk mencoba, buka **Profile**, masukkan username `seller`, `buyer`, atau `admin` dengan password `demo123`. Sesi demo tersimpan di memori sampai pengguna keluar atau aplikasi dimulai ulang. Integrasi autentikasi dengan layanan tim akan ditentukan setelah diskusi.

## Daftar Endpoint API

Semua endpoint adalah Django REST Framework di server web ValuWaste.

- **Base URL:** `http://enrico-oscar-valuwaste.pws.cs.ui.ac.id` (pakai `http`, bukan `https`)
- **Login:** session Django lewat `CookieRequest` dari `pbp_django_auth`. Satu `CookieRequest` dibuat di `lib/app.dart` dan dipakai semua modul.
- **Header wajib:** `X-ValuWaste-Client: mobile` (sudah dipasang otomatis di `lib/core/network/api_client.dart`). Header ini membuat POST/PATCH/DELETE dari aplikasi tidak ditolak cek CSRF.
- **Format error:** `{"detail": "..."}` atau `{"<field>": ["..."]}` (format bawaan DRF).

### Modul 2 · Waste Inventory & Listing Management (`/api/inventory/`)

Seller aktif dapat mengelola listing sampah miliknya sendiri. Admin dapat mengelola kategori sampah. Endpoint menggunakan Django REST Framework (DRF).

| Method | Endpoint | Fungsi |
|---|---|---|
| GET | `listings/[?search=<teks>&category=<id>&status=<status>]` | Daftar listing milik seller, dengan pencarian dan filter |
| POST | `listings/` | Tambah listing sampah baru |
| GET | `listings/<id>/` | Detail listing milik seller |
| PUT | `listings/<id>/` | Ubah seluruh data listing |
| PATCH | `listings/<id>/` | Ubah sebagian data listing |
| DELETE | `listings/<id>/` | Hapus listing |
| GET | `categories/` | Daftar kategori sampah |
| POST | `categories/` | Tambah kategori baru (admin) |
| GET | `categories/<id>/` | Detail kategori sampah |
| PUT | `categories/<id>/` | Ubah seluruh data kategori (admin) |
| PATCH | `categories/<id>/` | Ubah sebagian data kategori (admin) |
| DELETE | `categories/<id>/` | Hapus kategori (admin) |

**Ketentuan:**
- Seller hanya dapat melihat dan mengelola listing miliknya sendiri.
- Listing memiliki informasi kategori, judul, deskripsi, gambar, jumlah (kg), harga per kg, lokasi pengambilan, dan status.
- Status listing yang dapat diatur langsung oleh seller: `draft`, `available`, dan `deactivated`.
- Jumlah stok tidak boleh negatif dan harga per kg harus lebih dari 0.
- Kategori yang masih digunakan oleh listing tidak dapat dihapus.
- Endpoint kategori hanya dapat diubah oleh admin, sedangkan GET kategori dapat diakses oleh pengguna aktif yang sudah login.

### Modul 3 · Waste Discovery & Category-First Search (`/market/api/`)

Semua pengguna (termasuk publik/belum login) dapat menjelajahi pasar material berdasarkan kategori maupun mencari listing sampah aktif dengan filter dan pengurutan[cite: 14, 17].

| Method | Endpoint | Fungsi |
|---|---|---|
| GET | `markets/` | Daftar pasar per kategori material beserta ringkasan total stok, jumlah seller aktif, dan harga terendah per kg[cite: 1, 14] |
| GET | `search/[?q=<teks>&category=<id>&location=<lokasi>&sort=<urutan>]` | Pencarian dan filter daftar listing sampah aktif beserta info kategori dan seller[cite: 14, 17] |

**Ketentuan:**
- Endpoint dapat diakses secara publik (`GET`) tanpa wajib login untuk melihat katalog kategori dan hasil pencarian listing[cite: 17].
- Respons `search/` mengembalikan objek berformat `{"count": <int>, "results": [...]}` dengan detail setiap listing (`id`, `title`, `category`, `quantity_kg`, `price_per_kg`, `location`, `description`, `image_url`, dan `seller`)[cite: 17].
- Daftar kategori dan listing dapat difilter berdasarkan kata kunci pencarian maupun lokasi, serta diurutkan berdasarkan harga[cite: 1].

### Modul 4 · Waste Request & Supply Aggregation (`/api/v1/aggregation/`)

Hanya untuk Company Buyer yang aktif. Angka kg dan rupiah dikirim sebagai string, misalnya `"30.00"`.

| Method | Endpoint | Fungsi |
|---|---|---|
| GET | `categories/` | Daftar kategori untuk form kebutuhan |
| GET | `preview/?category=<id>&quantity=<kg>[&max_price=<rp>][&strategy=CHEAPEST]` | Hitung pasokan yang tersedia tanpa menyimpan |
| GET | `requests/[?q=<teks>&status=OPEN]` | Daftar kebutuhan milik buyer |
| POST | `requests/` | Buat kebutuhan dan susun bundle pertama |
| GET | `requests/<id>/` | Detail kebutuhan, bundle, saran seller, dan masalah item |
| PATCH | `requests/<id>/` | Ubah judul, target, harga maksimal, atau catatan |
| DELETE | `requests/<id>/` | Batalkan kebutuhan (status jadi `CANCELLED`) |
| POST | `requests/<id>/bundle/` | Susun ulang bundle (`CHEAPEST` atau `FEWEST_SELLERS`) |
| POST | `requests/<id>/bundle/items/` | Tambah seller ke bundle |
| DELETE | `requests/<id>/bundle/items/` | Kosongkan bundle |
| PATCH | `requests/<id>/bundle/items/<item_id>/` | Ubah jumlah kg satu seller |
| DELETE | `requests/<id>/bundle/items/<item_id>/` | Hapus satu seller dari bundle |
| POST | `requests/<id>/bundle/confirm/` | Tandai bundle siap checkout (checkout di Modul 5) |

### Modul 5 · Transaction, Tracking & Dashboards (`/api/v1/transactions/`)

Butuh login (buyer, seller, atau admin). Buyer melihat pesanannya, seller melihat pesanan yang berisi listing-nya, admin melihat semua.

| Method | Endpoint | Fungsi |
|---|---|---|
| GET | `orders/[?q=<teks>&status=<STATUS>]` | Daftar pesanan |
| GET | `orders/<code>/` | Detail pesanan dan riwayat pelacakan |

### Modul 1, 2, 3

Diisi oleh pemilik modul masing-masing (method, endpoint, fungsi), dengan format tabel yang sama seperti Modul 4.

## Sumber Data

Aplikasi mobile tidak menyimpan data sendiri. Semua data diambil dari API Django di atas:

- **Data awal:** 50 listing limbah, 8 kategori, 8 seller, dan 1 buyer dari seed Modul 3 (`python manage.py seed_market`). Di PWS, data ini dimasukkan otomatis oleh migrasi.
- **Data wilayah:** Konoha Land API, diambil server Django saat user mengisi alamat.
- **Ongkos kirim:** RajaOngkir API, dihitung server Django saat checkout.

## Cara Menjalankan

Butuh Flutter 3.47.9 (versi yang sama dengan CI).

```bash
git clone https://github.com/TK-PBP-C-04-GASAL-2026-2027/valuwaste_mobile.git
cd valuwaste_mobile
flutter pub get
flutter run
```

Jalankan di emulator Android atau HP Android. Versi web (Chrome) tidak bisa memanggil API PWS karena server tidak mengizinkan CORS.

Secara default aplikasi memakai server PWS. Untuk server Django lokal:

```bash
flutter run --dart-define=API_BASE_URL=http://10.0.2.2:8000
```

`10.0.2.2` adalah alamat laptop dari dalam emulator Android. Untuk HP asli, pakai IP laptop di jaringan Wi-Fi yang sama.

Sebelum push:

```bash
flutter analyze
flutter test
```

## Struktur Folder

```
lib/
  main.dart
  app.dart                 Provider CookieRequest, tema, dan navigasi
  core/
    config/                alamat server (ApiConfig)
    network/               CookieRequest + header mobile, helper getJson
    theme/                 warna dan tema aplikasi, font DM Sans
    navigation/            top bar dan menu navigasi antarmodul (AppShell)
    widgets/               tampilan loading, kosong, error, dan halaman sementara
  features/
    auth/                  Modul 1
    listings/              Modul 2
    discovery/             Modul 3
    aggregation/           Modul 4
    transactions/          Modul 5
assets/fonts/              DM Sans (SIL Open Font License, lihat OFL.txt)
```

## Tautan

- **Aplikasi web dan API (PWS):** http://enrico-oscar-valuwaste.pws.cs.ui.ac.id/
- **Desain UI/UX web (Figma):** https://www.figma.com/design/MNTMRkR9XEjzxLZCYFUa9c/ValuWaste?node-id=0-1
- **APK:** menyusul

## Deklarasi Penggunaan AI

| Anggota | Alat AI | Dipakai untuk | Yang diperiksa atau diputuskan sendiri |
|---|---|---|---|
| Muhammad Faza Aqila | | | |
| Enrico Oscar Harits Caloh | | | |
| Pearlita Anindya Prameswari | | | |
| Jeudi Augusto Asadullah | OpenAI Codex | Prototipe sesi lokal, halaman Profile, dan pengujian Flutter | Menunggu tinjauan Jeudi |
| Rania Aqila | | | |
