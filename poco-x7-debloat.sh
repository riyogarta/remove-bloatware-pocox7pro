#!/bin/bash

# ============================================
# Poco X7 Pro 5G Debloater Script
# HyperOS 3 / Android 16
# Untuk Linux Mint / Ubuntu / Debian
# ============================================

# Warna untuk output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Counter
SUCCESS=0
FAILED=0

# Banner
show_banner() {
    clear
    echo -e "${CYAN}"
    echo "╔══════════════════════════════════════════════════════════╗"
    echo "║       POCO X7 PRO 5G DEBLOATER SCRIPT                    ║"
    echo "║           HyperOS 3 / Android 16                         ║"
    echo "║         Untuk Linux Mint / Ubuntu                        ║"
    echo "╚══════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

# Cek ADB terinstall
check_adb() {
    if ! command -v adb &> /dev/null; then
        echo -e "${RED}[ERROR] ADB belum terinstall!${NC}"
        echo -e "${YELLOW}Install dengan: sudo apt install adb${NC}"
        exit 1
    fi
    echo -e "${GREEN}[OK] ADB terinstall${NC}"
}

# Cek device terkoneksi
check_device() {
    echo -e "${BLUE}[INFO] Mengecek koneksi device...${NC}"
    
    DEVICE=$(adb devices | grep -w "device" | head -n1)
    
    if [ -z "$DEVICE" ]; then
        echo -e "${RED}[ERROR] Device tidak terdeteksi!${NC}"
        echo ""
        echo -e "${YELLOW}Pastikan:${NC}"
        echo "  1. USB Debugging sudah aktif di HP"
        echo "  2. HP terhubung via USB (mode File Transfer)"
        echo "  3. Sudah tap 'Allow' di prompt authorization HP"
        echo ""
        echo -e "${YELLOW}Coba jalankan: adb devices${NC}"
        exit 1
    fi
    
    echo -e "${GREEN}[OK] Device terdeteksi${NC}"
}

# Fungsi uninstall package
uninstall_package() {
    local package=$1
    local name=$2
    
    echo -ne "  Menghapus ${name}... "
    
    RESULT=$(adb shell pm uninstall -k --user 0 "$package" 2>&1)
    # Alternatif: adb shell cmd package uninstall -k --user 0 "$package"
    
    if [[ "$RESULT" == *"Success"* ]]; then
        echo -e "${GREEN}OK${NC}"
        ((SUCCESS++))
    else
        echo -e "${YELLOW}SKIP (tidak ada/sudah dihapus)${NC}"
        ((FAILED++))
    fi
}

# Fungsi restore package
restore_package() {
    local package=$1
    local name=$2
    
    echo -ne "  Restore ${name}... "
    
    RESULT=$(adb shell pm install-existing --user 0 "$package" 2>&1)
    # Alternatif: adb shell cmd package install-existing "$package"
    
    if [[ "$RESULT" == *"installed"* ]]; then
        echo -e "${GREEN}OK${NC}"
        ((SUCCESS++))
    else
        echo -e "${YELLOW}GAGAL (package tidak tersedia)${NC}"
        ((FAILED++))
    fi
}

# ============================================
# DAFTAR BLOATWARE YANG AKAN DIHAPUS
# ============================================

# Semua bloatware
remove_all() {
    echo -e "\n${CYAN}>> [1/4] Menghapus Iklan & Analytics...${NC}"
    uninstall_package "com.miui.analytics" "MIUI Analytics"
    uninstall_package "com.miui.msa.global" "MSA Global (Iklan Sistem)"

    echo -e "\n${CYAN}>> [2/4] Menghapus Xiaomi/MIUI Bloatware...${NC}"
    uninstall_package "com.miui.player" "Mi Music"
    uninstall_package "com.miui.videoplayer" "Mi Video"
    uninstall_package "com.miui.bugreport" "Bug Report"
    uninstall_package "com.miui.yellowpage" "Yellow Pages"
    uninstall_package "com.miui.touchassistant" "Touch Assistant"
    uninstall_package "com.miui.miservice" "Services & Feedback"
    uninstall_package "com.miui.phrase" "Phrase Service"
    uninstall_package "com.xiaomi.glgm" "Xiaomi Games"
    uninstall_package "com.xiaomi.mipicks" "GetApps Store"
    uninstall_package "com.xiaomi.payment" "Mi Payment"
    uninstall_package "com.xiaomi.discover" "Xiaomi Discover"
    uninstall_package "com.mi.globalbrowser" "Mi Browser"
    uninstall_package "com.mi.globalminusscreen" "App Vault"
    uninstall_package "com.miui.thirdappassistant" "Third Party Assistant"
    uninstall_package "com.xiaomi.barrage" "Barrage Notification"

    echo -e "\n${CYAN}>> [3/4] Menghapus Apps Tidak Terpakai...${NC}"
    # com.android.thememanager DIPINDAH ke menu terpisah - mempengaruhi Personalization
    uninstall_package "com.miui.gallery" "MIUI Gallery"
    uninstall_package "com.mi.healthglobal" "Mi Health"
    uninstall_package "com.google.android.videos" "Google TV"
    uninstall_package "com.miui.qr" "QR Scanner"
    uninstall_package "com.xiaomi.aicr" "AI OCR"

    echo -e "\n${CYAN}>> [4/4] Selesai!${NC}"
}

# Restore semua
restore_all() {
    echo -e "\n${CYAN}>> [1/4] Restore Iklan & Analytics...${NC}"
    restore_package "com.miui.analytics" "MIUI Analytics"
    restore_package "com.miui.msa.global" "MSA Global"

    echo -e "\n${CYAN}>> [2/4] Restore Xiaomi/MIUI Apps...${NC}"
    restore_package "com.miui.player" "Mi Music"
    restore_package "com.miui.videoplayer" "Mi Video"
    restore_package "com.miui.bugreport" "Bug Report"
    restore_package "com.miui.yellowpage" "Yellow Pages"
    restore_package "com.miui.touchassistant" "Touch Assistant"
    restore_package "com.miui.miservice" "Services & Feedback"
    restore_package "com.miui.phrase" "Phrase Service"
    restore_package "com.xiaomi.glgm" "Xiaomi Games"
    restore_package "com.xiaomi.mipicks" "GetApps Store"
    restore_package "com.xiaomi.payment" "Mi Payment"
    restore_package "com.xiaomi.discover" "Xiaomi Discover"
    restore_package "com.mi.globalbrowser" "Mi Browser"
    restore_package "com.mi.globalminusscreen" "App Vault"
    restore_package "com.miui.thirdappassistant" "Third Party Assistant"
    restore_package "com.xiaomi.barrage" "Barrage Notification"

    echo -e "\n${CYAN}>> [3/4] Restore Apps Lainnya...${NC}"
    # com.android.thememanager di menu terpisah
    restore_package "com.miui.gallery" "MIUI Gallery"
    restore_package "com.mi.healthglobal" "Mi Health"
    restore_package "com.google.android.videos" "Google TV"
    restore_package "com.miui.qr" "QR Scanner"
    restore_package "com.xiaomi.aicr" "AI OCR"

    echo -e "\n${CYAN}>> [4/4] Selesai!${NC}"
}

# ============================================
# BLOATWARE TAMBAHAN
# ============================================

# Facebook Bloatware
remove_facebook() {
    echo -e "\n${CYAN}>> Menghapus Facebook Bloatware (3 apps)...${NC}"
    uninstall_package "com.facebook.appmanager" "Facebook App Manager"
    uninstall_package "com.facebook.services" "Facebook Services"
    uninstall_package "com.facebook.system" "Facebook System"
}

# Microsoft Bloatware (bawaan pabrik, bukan Office 365)
remove_microsoft() {
    echo -e "\n${CYAN}>> Menghapus Microsoft Bloatware (3 apps)...${NC}"
    uninstall_package "com.microsoft.appmanager" "Microsoft App Manager"
    uninstall_package "com.microsoft.deviceintegrationservice" "Microsoft Device Integration"
    uninstall_package "com.microsoftsdk.crossdeviceservicebroker" "Microsoft Cross Device"
}

# Debug/Developer Tools
remove_debug() {
    echo -e "\n${CYAN}>> Menghapus Debug/Developer Tools (6 apps)...${NC}"
    uninstall_package "com.debug.loggerui" "Logger UI"
    uninstall_package "com.bsp.catchlog" "Catch Log"
    uninstall_package "com.mediatek.engineermode" "Engineer Mode"
    uninstall_package "com.mediatek.lbs.em2.ui" "Location Engineer Mode"
    uninstall_package "com.mediatek.ygps" "YGPS Test"
    uninstall_package "com.mediatek.mdmlsample" "MDM Sample"
}

# Google Apps (kecuali Play Store, Play Services, GSF, Hey Google, Gmail)
remove_google() {
    echo -e "\n${CYAN}>> Menghapus Google Apps (10 apps)...${NC}"
    uninstall_package "com.android.chrome" "Chrome"
    uninstall_package "com.google.android.apps.docs" "Google Docs"
    uninstall_package "com.google.android.apps.maps" "Google Maps"
    uninstall_package "com.google.android.apps.photos" "Google Photos"
    uninstall_package "com.google.android.apps.tachyon" "Google Meet"
    uninstall_package "com.google.android.apps.wellbeing" "Digital Wellbeing"
    uninstall_package "com.google.android.apps.youtube.music" "YouTube Music"
    uninstall_package "com.google.android.apps.bard" "Gemini AI"
    uninstall_package "com.google.android.youtube" "YouTube"
    uninstall_package "com.google.android.apps.subscriptions.red" "Google One"
    echo -e "${GREEN}   ✓ Play Store, Play Services, Hey Google, Gmail tetap aman${NC}"
}

# Restore Facebook
restore_facebook() {
    echo -e "\n${CYAN}>> Restore Facebook Bloatware...${NC}"
    restore_package "com.facebook.appmanager" "Facebook App Manager"
    restore_package "com.facebook.services" "Facebook Services"
    restore_package "com.facebook.system" "Facebook System"
}

# Restore Microsoft
restore_microsoft() {
    echo -e "\n${CYAN}>> Restore Microsoft Bloatware...${NC}"
    restore_package "com.microsoft.appmanager" "Microsoft App Manager"
    restore_package "com.microsoft.deviceintegrationservice" "Microsoft Device Integration"
    restore_package "com.microsoftsdk.crossdeviceservicebroker" "Microsoft Cross Device"
}

# Restore Debug
restore_debug() {
    echo -e "\n${CYAN}>> Restore Debug/Developer Tools...${NC}"
    restore_package "com.debug.loggerui" "Logger UI"
    restore_package "com.bsp.catchlog" "Catch Log"
    restore_package "com.mediatek.engineermode" "Engineer Mode"
    restore_package "com.mediatek.lbs.em2.ui" "Location Engineer Mode"
    restore_package "com.mediatek.ygps" "YGPS Test"
    restore_package "com.mediatek.mdmlsample" "MDM Sample"
}

# Restore Google
restore_google() {
    echo -e "\n${CYAN}>> Restore Google Apps...${NC}"
    restore_package "com.android.chrome" "Chrome"
    restore_package "com.google.android.apps.docs" "Google Docs"
    restore_package "com.google.android.apps.maps" "Google Maps"
    restore_package "com.google.android.apps.photos" "Google Photos"
    restore_package "com.google.android.apps.tachyon" "Google Meet"
    restore_package "com.google.android.apps.wellbeing" "Digital Wellbeing"
    restore_package "com.google.android.apps.youtube.music" "YouTube Music"
    restore_package "com.google.android.apps.bard" "Gemini AI"
    restore_package "com.google.android.youtube" "YouTube"
    restore_package "com.google.android.apps.subscriptions.red" "Google One"
}

# Theme Manager (OPSIONAL - dengan peringatan)
remove_theme() {
    echo ""
    echo -e "${RED}╔════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${RED}║                    ⚠️  PERINGATAN ⚠️                        ║${NC}"
    echo -e "${RED}╠════════════════════════════════════════════════════════════╣${NC}"
    echo -e "${RED}║  Jika Theme Manager dihapus:                               ║${NC}"
    echo -e "${RED}║  • Settings → Personalization TIDAK BISA DIKLIK            ║${NC}"
    echo -e "${RED}║  • Pilihan ringtone/notifikasi/alarm SANGAT TERBATAS       ║${NC}"
    echo -e "${RED}║  • Tidak bisa ganti font & icon pack                       ║${NC}"
    echo -e "${RED}║                                                            ║${NC}"
    echo -e "${RED}║  Alternatif tanpa Theme Manager:                           ║${NC}"
    echo -e "${RED}║  • Wallpaper: Google Photos → Set as wallpaper             ║${NC}"
    echo -e "${RED}║  • Ringtone: Copy MP3 ke folder /Ringtones/                 ║${NC}"
    echo -e "${RED}╚════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -ne "${YELLOW}Yakin hapus Theme Manager? (y/n): ${NC}"
    read -r confirm
    if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
        echo -e "\n${CYAN}>> Menghapus Theme Manager...${NC}"
        uninstall_package "com.android.thememanager" "Theme Manager"
    else
        echo -e "${GREEN}Dibatalkan.${NC}"
    fi
}

restore_theme() {
    echo -e "\n${CYAN}>> Restore Theme Manager...${NC}"
    restore_package "com.android.thememanager" "Theme Manager"
    echo -e "${GREEN}Menu Settings → Personalization sudah bisa diakses lagi.${NC}"
}

# HAPUS SEMUA (Xiaomi + Facebook + Microsoft + Debug + Google) - TANPA Theme Manager
remove_everything() {
    remove_all
    remove_facebook
    remove_microsoft
    remove_debug
    remove_google
    echo -e "\n${GREEN}>> TOTAL 44 bloatware dihapus!${NC}"
    echo -e "${YELLOW}>> Theme Manager TIDAK dihapus (pilih menu [6] jika mau hapus)${NC}"
}

# RESTORE SEMUA (termasuk Theme Manager)
restore_everything() {
    restore_all
    restore_facebook
    restore_microsoft
    restore_debug
    restore_google
    restore_package "com.android.thememanager" "Theme Manager"
    echo -e "\n${GREEN}>> Semua aplikasi di-restore!${NC}"
}

# ============================================
# MENU
# ============================================

show_menu() {
    echo ""
    echo -e "${YELLOW}Pilih opsi:${NC}"
    echo ""
    echo -e "  ${CYAN}-- HAPUS --${NC}"
    echo "  [1] Hapus Xiaomi/MIUI bloatware (22 apps)"
    echo "  [2] Hapus Facebook bloatware (3 apps)"
    echo "  [3] Hapus Microsoft bloatware (3 apps) - fitur Link to Windows tidak berfungsi"
    echo "  [4] Hapus Debug/Developer tools (6 apps) - dibutuhkan teknisi jika HP rusak"
    echo "  [5] Hapus Google apps (10 apps) - kecuali Play Store & Gmail"
    echo "  [6] Hapus Theme Manager (1 app) - ⚠️ BACA PERINGATAN"
    echo "  [7] Hapus SEMUA di atas KECUALI Theme Manager (44 apps)"
    echo ""
    echo -e "  ${CYAN}-- RESTORE --${NC}"
    echo "  [8] Restore Theme Manager"
    echo "  [9] Restore SEMUA aplikasi"
    echo ""
    echo "  [0] Keluar"
    echo ""
    echo -ne "${CYAN}Pilihan [0-9]: ${NC}"
}

show_summary() {
    echo ""
    echo -e "${CYAN}════════════════════════════════════════${NC}"
    echo -e "${GREEN}  Berhasil: $SUCCESS${NC}"
    echo -e "${YELLOW}  Dilewati: $FAILED${NC}"
    echo -e "${CYAN}════════════════════════════════════════${NC}"
}

show_list() {
    echo ""
    echo -e "${YELLOW}=== DAFTAR BLOATWARE ===${NC}"
    echo ""
    echo -e "${CYAN}[1] Xiaomi/MIUI (22 apps):${NC}"
    echo "    Iklan, Mi Music, Mi Video, Mi Browser, GetApps, Games,"
    echo "    Gallery, Mi Health, QR Scanner, dll"
    echo ""
    echo -e "${CYAN}[2] Facebook (3 apps):${NC}"
    echo "    App Manager, Services, System"
    echo ""
    echo -e "${CYAN}[3] Microsoft (3 apps):${NC}"
    echo "    App Manager, Device Integration, Cross Device"
    echo "    (Bawaan pabrik, bukan Office 365)"
    echo "    ⚠️  Fitur Link to Windows / Phone Link tidak berfungsi"
    echo ""
    echo -e "${CYAN}[4] Debug/Developer (6 apps):${NC}"
    echo "    Logger UI, Catch Log, Engineer Mode, YGPS, dll"
    echo "    ⚠️  Dibutuhkan teknisi jika HP rusak/service"
    echo ""
    echo -e "${CYAN}[5] Google (10 apps):${NC}"
    echo "    Chrome, Maps, Photos, YouTube, Meet, Docs,"
    echo "    Gemini AI, Digital Wellbeing, YouTube Music, Google One"
    echo ""
    echo -e "${RED}[6] Theme Manager (1 app) - OPSIONAL:${NC}"
    echo "    ⚠️  Jika dihapus: Settings → Personalization tidak bisa diklik"
    echo "    ⚠️  Pilihan ringtone/wallpaper sangat terbatas"
    echo "    ⚠️  Tidak bisa ganti font & icon pack"
    echo ""
    echo -e "${GREEN}Yang TIDAK dihapus:${NC}"
    echo "    Play Store, Play Services, Hey Google, Gmail"
    echo "    Mi Account, Find Device, Kamera, Screenshot"
    echo "    AI Vision, AI Subtitles, Translate"
    echo ""
}

# ============================================
# MAIN
# ============================================

main() {
    show_banner
    check_adb
    check_device
    show_list
    
    while true; do
        SUCCESS=0
        FAILED=0
        
        show_menu
        read -r choice
        
        case $choice in
            1)
                echo ""
                echo -e "${YELLOW}[!] Menghapus Xiaomi/MIUI bloatware (22 apps)...${NC}"
                remove_all
                show_summary
                ;;
            2)
                echo ""
                remove_facebook
                show_summary
                ;;
            3)
                echo ""
                remove_microsoft
                show_summary
                ;;
            4)
                echo ""
                remove_debug
                show_summary
                ;;
            5)
                echo ""
                remove_google
                show_summary
                ;;
            6)
                remove_theme
                show_summary
                ;;
            7)
                echo ""
                echo -e "${YELLOW}[!] Menghapus SEMUA bloatware (44 apps)...${NC}"
                remove_everything
                show_summary
                ;;
            8)
                echo ""
                restore_theme
                show_summary
                ;;
            9)
                echo ""
                echo -e "${YELLOW}[!] Restore semua aplikasi...${NC}"
                restore_everything
                show_summary
                ;;
            0)
                echo -e "\n${GREEN}Bye! 👋${NC}\n"
                exit 0
                ;;
            *)
                echo -e "${RED}Pilihan tidak valid!${NC}"
                ;;
        esac
        
        echo ""
        echo -ne "${YELLOW}Tekan Enter untuk lanjut...${NC}"
        read -r
        show_banner
        show_list
    done
}

# Jalankan
main
