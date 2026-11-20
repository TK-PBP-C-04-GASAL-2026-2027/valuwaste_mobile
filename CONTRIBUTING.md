# Cara Berkontribusi

`main` dilindungi: semua perubahan masuk lewat Pull Request (PR) dan butuh minimal 1 approve dari anggota lain.

## Branch per modul

Setiap anggota memakai satu branch untuk modulnya sendiri, dari awal sampai akhir proyek:

| Modul | Pemilik | Branch | Folder |
|---|---|---|---|
| 1. Autentikasi & User Profile | Jeudi | `modul_1_jeudi` | `lib/features/auth/` |
| 2. Waste Inventory & Listing | Pearlita | `modul_2_pearl` | `lib/features/listings/` |
| 3. Discovery & Search | Rania | `modul_3_nia` | `lib/features/discovery/` |
| 4. Waste Request & Aggregation | Faza | `modul_4_faza` | `lib/features/aggregation/` |
| 5. Transaction & Dashboard | Rico | `modul_5_rico` | `lib/features/transactions/` |
| Kode bersama | dibahas di grup | `core` | `lib/core/` |

Ubah folder modulmu sendiri. Kalau perlu mengubah `lib/core/` atau folder modul lain, bahas dulu di grup.

## Pertama kali

```
git switch main
git pull origin main
git switch -c modul_4_faza
git push -u origin modul_4_faza
```

## Setiap mulai kerja

Ambil perubahan terbaru dari `main` ke branch-mu dulu supaya tidak tertinggal:

```
git switch modul_4_faza
git pull origin main
```

## Commit dan PR

```
git add .
git commit -m "feat(aggregation): tambah halaman daftar kebutuhan"
git push origin modul_4_faza
```

1. Buka GitHub, klik **Compare & pull request** dari branch-mu ke `main`. Tulis ringkasan perubahan dan cara mengetesnya.
2. Tunggu CI (Flutter CI) hijau dan minimal 1 anggota approve. Copilot otomatis ikut mereview.
3. Merge dengan **Create a merge commit**.
4. Lanjut kerja di branch yang sama. Sebelum mulai lagi, jalankan `git pull origin main` seperti di atas.

## Format commit

`<jenis>(<modul>): <ringkasan>`

| Jenis | Dipakai untuk |
|---|---|
| `feat` | fitur baru |
| `fix` | perbaikan bug |
| `refactor` | merapikan kode tanpa mengubah perilaku |
| `docs` | dokumentasi |
| `chore` | konfigurasi, dependensi, CI |

Contoh: `feat(listings): tambah form listing`, `fix(auth): tampilkan pesan saat login gagal`.

## Kalau terjadi konflik

Konflik biasanya muncul saat `git pull origin main`. Buka file yang ditandai konflik di VS Code, pilih bagian yang benar (Accept Current / Incoming / Both), simpan, lalu:

```
git add .
git commit -m "chore: selesaikan konflik dengan main"
git push origin modul_4_faza
```

## Sebelum push

```
flutter analyze
flutter test
```
