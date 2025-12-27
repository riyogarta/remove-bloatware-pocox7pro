# POCO X7 Pro Debloater

[![Platform](https://img.shields.io/badge/Platform-Linux-orange)](https://github.com/riyogarta/remove-bloatware-pocox7pro)
[![Device](https://img.shields.io/badge/Device-POCO%20X7%20Pro-blue)](https://github.com/riyogarta/remove-bloatware-pocox7pro)
[![HyperOS](https://img.shields.io/badge/HyperOS-3-green)](https://github.com/riyogarta/remove-bloatware-pocox7pro)
[![Android](https://img.shields.io/badge/Android-16-brightgreen)](https://github.com/riyogarta/remove-bloatware-pocox7pro)
[![License](https://img.shields.io/badge/License-MIT-yellow)](LICENSE)

Script untuk menghapus bloatware dari **POCO X7 Pro 5G** yang menjalankan **HyperOS 3 / Android 16**. Tanpa root, aman, dan bisa di-restore kapan saja.

## Fitur

- Hapus hingga **45 bloatware** sekaligus
- **Tanpa root** - menggunakan ADB
- **Aman** - tidak menghapus file sistem, hanya "menyembunyikan" app
- **Reversible** - bisa restore kapan saja
- **Menu interaktif** - pilih kategori yang mau dihapus
- **Warna terminal** - output yang mudah dibaca

## Bloatware yang Dapat Dihapus

| Kategori | Jumlah | Contoh Apps |
|----------|--------|-------------|
| Xiaomi/MIUI | 22 | Mi Browser, GetApps, Mi Video, Mi Music, Analytics, MSA (iklan) |
| Facebook | 3 | App Manager, Services, System |
| Microsoft | 3 | App Manager, Device Integration, Cross Device |
| Debug/Developer | 6 | Engineer Mode, Logger UI, YGPS |
| Google Apps | 10 | Chrome, YouTube, Maps, Photos, Meet, Gemini AI |
| Theme Manager | 1 | Theme Manager (opsional, ada peringatan) |

### Yang TIDAK Dihapus (Tetap Aman)

- Play Store & Play Services
- Gmail & Hey Google
- Mi Account & Find Device
- Kamera, Screenshot, Screen Recorder
- AI Vision, AI Subtitles, Translate
- Security Center

## Persyaratan

- Linux (Ubuntu/Debian/Linux Mint) atau WSL
- ADB terinstall
- Kabel USB
- POCO X7 Pro dengan USB Debugging aktif

## Instalasi

### 1. Install ADB

```bash
sudo apt install adb
```

### 2. Clone Repository

```bash
git clone https://github.com/riyogarta/remove-bloatware-pocox7pro.git
cd remove-bloatware-pocox7pro
chmod +x poco-x7-debloat.sh
```

### 3. Aktifkan USB Debugging di HP

1. Buka **Settings** → **About phone**
2. Tap **HyperOS version** 7 kali sampai muncul "You are now a developer"
3. Kembali ke **Settings** → **Additional settings** → **Developer options**
4. Aktifkan **USB Debugging**

### 4. Hubungkan HP

1. Hubungkan HP ke komputer via USB
2. Pilih mode **File Transfer**
3. Tap **Allow** saat muncul popup USB Debugging authorization

### 5. Verifikasi Koneksi

```bash
adb devices
```

Pastikan output menunjukkan `device` (bukan `unauthorized`):

```
List of devices attached
XXXXXXXX    device
```

## Penggunaan

```bash
./poco-x7-debloat.sh
```

### Menu Opsi

```
-- HAPUS --
[1] Hapus Xiaomi/MIUI bloatware (22 apps)
[2] Hapus Facebook bloatware (3 apps)
[3] Hapus Microsoft bloatware (3 apps)
[4] Hapus Debug/Developer tools (6 apps)
[5] Hapus Google apps (10 apps)
[6] Hapus Theme Manager (1 app) - ada peringatan
[7] Hapus SEMUA kecuali Theme Manager (44 apps)

-- RESTORE --
[8] Restore Theme Manager
[9] Restore SEMUA aplikasi

[0] Keluar
```

## FAQ

**Q: Apakah aman? HP bisa brick?**
A: Aman. Metode ini hanya "menyembunyikan" app dari user, bukan menghapus permanen. File tetap ada di sistem. HP tidak bisa brick.

**Q: Bisa dikembalikan?**
A: Bisa! Jalankan script lagi dan pilih opsi Restore. Atau lakukan factory reset.

**Q: Butuh root?**
A: Tidak perlu root.

**Q: Google Account masih bisa dipakai?**
A: Ya! Play Store, Play Services, Gmail, Hey Google tidak dihapus. Login & sync tetap normal.

**Q: Mau service HP, gimana?**
A: Restore opsi Debug/Developer tools sebelum bawa ke service center.

**Q: Theme Manager dihapus, apa efeknya?**
A: Menu Settings → Personalization tidak bisa diklik. Pilihan ringtone/font terbatas. Bisa di-restore kapan saja.

## Peringatan

> **Microsoft Bloatware:** Jika dihapus, fitur **Link to Windows / Phone Link** tidak berfungsi.

> **Debug/Developer Tools:** Dibutuhkan teknisi jika HP rusak. Restore sebelum bawa ke service center.

> **Theme Manager:** Jika dihapus, Settings → Personalization tidak bisa diakses.

## Tested On

- **Device:** POCO X7 Pro 5G
- **OS:** HyperOS 3
- **Android:** 16
- **ADB Host:** Linux Mint

## Disclaimer

Script ini disediakan "as is" tanpa jaminan apapun. Gunakan dengan risiko sendiri. Penulis tidak bertanggung jawab atas kerusakan yang mungkin terjadi.

## License

MIT License - Silakan gunakan, modifikasi, dan distribusikan.

## Contributing

Pull request welcome! Jika ada package bloatware yang terlewat atau ada bug, silakan buat issue atau PR.

---

**Dibuat untuk komunitas POCO X7 Pro Indonesia**
