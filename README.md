# Xiaomi Debloater Scripts

[![Platform](https://img.shields.io/badge/Platform-Linux-orange)](https://github.com/riyogarta/remove-bloatware-pocox7pro)
[![License](https://img.shields.io/badge/License-MIT-yellow)](LICENSE)

Script untuk menghapus bloatware dari HP Xiaomi menggunakan ADB. Tanpa root, aman, dan bisa di-restore kapan saja.

## Supported Devices

| Device | OS | Script | Total Bloatware |
|--------|-----|--------|-----------------|
| POCO X7 Pro 5G | HyperOS 3 / Android 16 | `poco-x7-debloat.sh` | 43 apps |
| Redmi Note 14 5G | HyperOS / Android 14+ | `redmi-note14-debloat.sh` | 41 apps |

## Fitur

- **Tanpa root** - menggunakan ADB
- **Aman** - uninstall untuk user saat ini, master instalasi tetap ada di sistem
- **Reversible** - bisa restore kapan saja
- **Menu interaktif** - pilih kategori yang mau dihapus
- **Warna terminal** - output yang mudah dibaca

## Bloatware yang Dapat Dihapus

| Kategori | POCO X7 Pro | Redmi Note 14 | Contoh Apps |
|----------|-------------|---------------|-------------|
| Xiaomi/MIUI | 21 | 19 | Mi Browser, GetApps, Mi Video, Mi Music, Analytics, MSA (iklan) |
| Facebook | 3 | 3 | App Manager, Services, System |
| Microsoft | 3 | 1 | App Manager, Device Integration, Cross Device |
| Amazon | - | 1 | App Manager |
| Debug/Developer | 6 | - | Engineer Mode, Logger UI, YGPS (untuk service center) |
| Google Apps | 10 | 11 | Chrome, YouTube, Maps, Photos, Meet, Gemini AI |
| Third-party | - | 6 | WPS Office, iQIYI, Disney+, Flickr |
| Theme Manager | 1 | 1 | Theme Manager (opsional, ada peringatan) |

### Yang TIDAK Dihapus (Tetap Aman)

- Play Store & Play Services
- Gmail & Hey Google
- Mi Account & Find Device
- MIUI Gallery
- Kamera, Screenshot, Screen Recorder
- AI Vision, Scanner, Compass
- Security Center
- Debug/Developer Tools (Redmi Note 14) - untuk keperluan service center

## Persyaratan

- Linux (Ubuntu/Debian/Linux Mint) atau WSL
- ADB terinstall
- Kabel USB
- HP Xiaomi dengan USB Debugging aktif

## Instalasi

### 1. Install ADB

```bash
sudo apt install adb
```

### 2. Clone Repository

```bash
git clone https://github.com/riyogarta/remove-bloatware-pocox7pro.git
cd remove-bloatware-pocox7pro
chmod +x *.sh
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

### POCO X7 Pro 5G

```bash
./poco-x7-debloat.sh
```

### Redmi Note 14 5G

```bash
./redmi-note14-debloat.sh
```

### Contoh Menu

```
-- HAPUS --
[1] Hapus Xiaomi/MIUI bloatware
[2] Hapus Facebook bloatware
[3] Hapus Microsoft bloatware
[4] Hapus Debug/Developer tools
[5] Hapus Google apps
...
[9] Hapus SEMUA kecuali Theme Manager

-- RESTORE --
[r] Restore Theme Manager
[a] Restore SEMUA aplikasi

[0] Keluar
```

## FAQ

**Q: Apakah aman? HP bisa brick?**
A: Aman. Metode ini uninstall app untuk user saat ini saja (`pm uninstall --user 0`), bukan menghapus permanen dari sistem. Master instalasi tetap ada, jadi bisa di-restore kapan saja. Tanpa root, ADB tidak bisa menghapus permanen file sistem. HP tidak bisa brick.

**Q: Bisa dikembalikan?**
A: Bisa! Jalankan script lagi dan pilih opsi Restore. Atau lakukan factory reset.

**Q: Butuh root?**
A: Tidak perlu root.

**Q: Google Account masih bisa dipakai?**
A: Ya! Play Store, Play Services, Gmail tidak dihapus. Login & sync tetap normal.

**Q: Mau service HP, gimana?**
A: Restore opsi Debug/Developer tools sebelum bawa ke service center.

**Q: Theme Manager dihapus, apa efeknya?**
A: Menu Settings → Personalization tidak bisa diklik. Pilihan ringtone/font terbatas. Bisa di-restore kapan saja.

## Peringatan

> **Microsoft Bloatware:** Jika dihapus, fitur **Link to Windows / Phone Link** tidak berfungsi.

> **Debug/Developer Tools:** Dibutuhkan teknisi jika HP rusak. Restore sebelum bawa ke service center.

> **Theme Manager:** Jika dihapus, Settings → Personalization tidak bisa diakses.

## Tested On

| Device | OS | Android | ADB Host |
|--------|-----|---------|----------|
| POCO X7 Pro 5G | HyperOS 3 | 16 | Linux Mint |
| Redmi Note 14 5G | HyperOS | 14+ | Linux Mint |

## Disclaimer

Script ini disediakan "as is" tanpa jaminan apapun. Gunakan dengan risiko sendiri. Penulis tidak bertanggung jawab atas kerusakan yang mungkin terjadi.

## License

MIT License - Silakan gunakan, modifikasi, dan distribusikan.

## Contributing

Pull request welcome! Jika ada package bloatware yang terlewat, device baru, atau bug, silakan buat issue atau PR.

---

**Dibuat untuk komunitas Xiaomi Indonesia**
