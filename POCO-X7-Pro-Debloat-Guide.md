# Hapus Bloatware POCO X7 Pro 5G (HyperOS 3 / Android 16)

Cara menghapus 45 bloatware tanpa root, aman, dan bisa di-restore kapan saja.

---

## Apa yang Dihapus?

### [1] Xiaomi/MIUI Bloatware (23 apps)
**Iklan & Analytics:**
- MIUI Analytics, MSA (iklan sistem)

**Apps:**
- Mi Music, Mi Video, Mi Browser
- GetApps Store, Xiaomi Games, Mi Payment
- Yellow Pages, Bug Report, Touch Assistant
- Services & Feedback, Phrase Service
- App Vault, Xiaomi Discover
- Third Party Assistant, Barrage Notification

**Apps Tidak Terpakai:**
- Theme Manager, MIUI Gallery, Mi Health
- Google TV, QR Scanner, AI OCR

### [2] Facebook Bloatware (3 apps)
- Facebook App Manager
- Facebook Services
- Facebook System

### [3] Microsoft Bloatware (3 apps)
- Microsoft App Manager
- Microsoft Device Integration
- Microsoft Cross Device

> ⚠️ **Catatan:** Ini bawaan pabrik, bukan Office 365. Jika dihapus, fitur **Link to Windows / Phone Link** tidak berfungsi.

### [4] Debug/Developer Tools (6 apps)
- Logger UI, Catch Log
- Engineer Mode, Location Engineer Mode
- YGPS Test, MDM Sample

> ⚠️ **Catatan:** Dibutuhkan teknisi jika HP rusak/service. Restore dulu sebelum bawa ke service center.

### [5] Google Apps (10 apps)
- Chrome, Google Maps, Google Photos
- YouTube, YouTube Music
- Google Meet, Google Docs
- Gemini AI, Digital Wellbeing, Google One

---

## Yang TIDAK Dihapus (Aman)

✅ Play Store & Play Services
✅ Gmail & Hey Google
✅ Mi Account & Find Device
✅ Screenshot & Screen Recorder
✅ AI Subtitles & Translate Conversation
✅ Kamera & AI Vision
✅ Security Center

---

## Cara Pakai (Linux Mint/Ubuntu)

### 1. Install ADB
```bash
sudo apt install adb
```

### 2. Aktifkan USB Debugging di HP
- Settings → About phone → tap "HyperOS version" 7x
- Settings → Additional settings → Developer options → USB Debugging ON

### 3. Hubungkan HP via USB
- Pilih mode "File Transfer"
- Tap "Allow" saat muncul popup USB Debugging

### 4. Cek Koneksi
```bash
adb devices
```
Pastikan muncul `device` (bukan `unauthorized`)

### 5. Jalankan Script
```bash
chmod +x poco-x7-debloat.sh
./poco-x7-debloat.sh
```

### 6. Pilih Opsi

```
-- HAPUS --
[1] Hapus Xiaomi/MIUI bloatware (23 apps)
[2] Hapus Facebook bloatware (3 apps)
[3] Hapus Microsoft bloatware (3 apps) - fitur Link to Windows tidak berfungsi
[4] Hapus Debug/Developer tools (6 apps) - dibutuhkan teknisi jika HP rusak
[5] Hapus Google apps (10 apps) - kecuali Play Store & Gmail
[6] Hapus SEMUA di atas (45 apps)

-- RESTORE --
[7] Restore SEMUA aplikasi

[0] Keluar
```

---

## FAQ

**Q: Aman? HP bisa brick?**
A: Tidak bisa brick. Metode ini hanya "menyembunyikan" app, bukan hapus permanen. File tetap ada di sistem.

**Q: Bisa dikembalikan?**
A: Bisa! Jalankan script lagi, pilih [7] untuk restore. Atau factory reset.

**Q: Butuh root?**
A: Tidak perlu root.

**Q: Akun Google masih bisa dipakai?**
A: Ya! Play Store, Play Services, Gmail, Hey Google tidak dihapus. Login & sync tetap normal.

**Q: Office 365 terpengaruh?**
A: Tidak. Microsoft bloatware yang dihapus adalah bawaan pabrik, bukan Office 365.

**Q: Mau service HP, gimana?**
A: Restore dulu opsi [4] Debug/Developer tools sebelum bawa ke teknisi.

---

## Download

- **Script:** poco-x7-debloat.sh
- **Panduan:** POCO-X7-Pro-Debloat-Guide.md

---

## Tested On

- POCO X7 Pro 5G
- HyperOS 3
- Android 16
- Linux Mint (ADB)

---

#POCOX7Pro #Debloat #HyperOS3 #Android16 #NoBloatware
