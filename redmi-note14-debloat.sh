#!/bin/bash

# ============================================
# Redmi Note 14 5G Debloater Script
# HyperOS / Android 14+
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
    echo "║       REDMI NOTE 14 5G DEBLOATER SCRIPT                  ║"
    echo "║              HyperOS / Android 14+                       ║"
    echo "║           Untuk Linux Mint / Ubuntu                      ║"
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

# Xiaomi/MIUI Bloatware (19 apps)
remove_xiaomi() {
    echo -e "\n${CYAN}>> [1/4] Menghapus Iklan & Analytics...${NC}"
    uninstall_package "com.miui.analytics" "MIUI Analytics"
    uninstall_package "com.miui.msa.global" "MSA Global (Iklan Sistem)"

    echo -e "\n${CYAN}>> [2/4] Menghapus Xiaomi/MIUI Bloatware...${NC}"
    uninstall_package "com.miui.player" "Mi Music"
    uninstall_package "com.miui.videoplayer" "Mi Video"
    uninstall_package "com.miui.bugreport" "Bug Report"
    uninstall_package "com.miui.yellowpage" "Yellow Pages"
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
    uninstall_package "com.duokan.phone.remotecontroller" "Mi Remote"

    echo -e "\n${CYAN}>> [3/4] Menghapus Apps Tidak Terpakai...${NC}"
    # com.miui.gallery TIDAK DIHAPUS - Gallery tetap dipertahankan
    uninstall_package "com.mi.healthglobal" "Mi Health"

    echo -e "\n${CYAN}>> [4/4] Selesai!${NC}"
}

# Restore Xiaomi/MIUI
restore_xiaomi() {
    echo -e "\n${CYAN}>> [1/4] Restore Iklan & Analytics...${NC}"
    restore_package "com.miui.analytics" "MIUI Analytics"
    restore_package "com.miui.msa.global" "MSA Global"

    echo -e "\n${CYAN}>> [2/4] Restore Xiaomi/MIUI Apps...${NC}"
    restore_package "com.miui.player" "Mi Music"
    restore_package "com.miui.videoplayer" "Mi Video"
    restore_package "com.miui.bugreport" "Bug Report"
    restore_package "com.miui.yellowpage" "Yellow Pages"
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
    restore_package "com.duokan.phone.remotecontroller" "Mi Remote"

    echo -e "\n${CYAN}>> [3/4] Restore Apps Lainnya...${NC}"
    restore_package "com.mi.healthglobal" "Mi Health"

    echo -e "\n${CYAN}>> [4/4] Selesai!${NC}"
}

# ============================================
# BLOATWARE TAMBAHAN
# ============================================

# Facebook Bloatware (3 apps)
remove_facebook() {
    echo -e "\n${CYAN}>> Menghapus Facebook Bloatware (3 apps)...${NC}"
    uninstall_package "com.facebook.appmanager" "Facebook App Manager"
    uninstall_package "com.facebook.services" "Facebook Services"
    uninstall_package "com.facebook.system" "Facebook System"
}

restore_facebook() {
    echo -e "\n${CYAN}>> Restore Facebook Bloatware...${NC}"
    restore_package "com.facebook.appmanager" "Facebook App Manager"
    restore_package "com.facebook.services" "Facebook Services"
    restore_package "com.facebook.system" "Facebook System"
}

# Microsoft Bloatware (1 app)
remove_microsoft() {
    echo -e "\n${CYAN}>> Menghapus Microsoft Bloatware (1 app)...${NC}"
    uninstall_package "com.microsoftsdk.crossdeviceservicebroker" "Microsoft Cross Device"
}

restore_microsoft() {
    echo -e "\n${CYAN}>> Restore Microsoft Bloatware...${NC}"
    restore_package "com.microsoftsdk.crossdeviceservicebroker" "Microsoft Cross Device"
}

# Amazon Bloatware (1 app)
remove_amazon() {
    echo -e "\n${CYAN}>> Menghapus Amazon Bloatware (1 app)...${NC}"
    uninstall_package "com.amazon.appmanager" "Amazon App Manager"
}

restore_amazon() {
    echo -e "\n${CYAN}>> Restore Amazon Bloatware...${NC}"
    restore_package "com.amazon.appmanager" "Amazon App Manager"
}

# Google Apps (11 apps) - kecuali Play Store, Play Services, GSF, Gmail
remove_google() {
    echo -e "\n${CYAN}>> Menghapus Google Apps (11 apps)...${NC}"
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
    uninstall_package "com.google.android.videos" "Google TV"
    echo -e "${GREEN}   Play Store, Play Services, Gmail tetap aman${NC}"
}

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
    restore_package "com.google.android.videos" "Google TV"
}

# Third-party Pre-installed Apps (6 apps)
remove_thirdparty() {
    echo -e "\n${CYAN}>> Menghapus Third-party Pre-installed (6 apps)...${NC}"
    uninstall_package "cn.wps.xiaomi.abroad.lite" "WPS Office Lite"
    uninstall_package "com.iqiyi.i18n" "iQIYI"
    uninstall_package "com.storymatrix.drama" "Story Matrix Drama"
    uninstall_package "com.grandgames.magicsort" "Magic Sort Game"
    uninstall_package "com.flickr.android" "Flickr"
    uninstall_package "in.startv.hotstar.dplus" "Disney+ Hotstar"
}

restore_thirdparty() {
    echo -e "\n${CYAN}>> Restore Third-party Pre-installed...${NC}"
    restore_package "cn.wps.xiaomi.abroad.lite" "WPS Office Lite"
    restore_package "com.iqiyi.i18n" "iQIYI"
    restore_package "com.storymatrix.drama" "Story Matrix Drama"
    restore_package "com.grandgames.magicsort" "Magic Sort Game"
    restore_package "com.flickr.android" "Flickr"
    restore_package "in.startv.hotstar.dplus" "Disney+ Hotstar"
}

# Theme Manager (OPSIONAL - dengan peringatan)
remove_theme() {
    echo ""
    echo -e "${RED}╔════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${RED}║                    PERINGATAN                              ║${NC}"
    echo -e "${RED}╠════════════════════════════════════════════════════════════╣${NC}"
    echo -e "${RED}║  Jika Theme Manager dihapus:                               ║${NC}"
    echo -e "${RED}║  - Settings -> Personalization TIDAK BISA DIKLIK           ║${NC}"
    echo -e "${RED}║  - Pilihan ringtone/notifikasi/alarm SANGAT TERBATAS       ║${NC}"
    echo -e "${RED}║  - Tidak bisa ganti font & icon pack                       ║${NC}"
    echo -e "${RED}║                                                            ║${NC}"
    echo -e "${RED}║  Alternatif tanpa Theme Manager:                           ║${NC}"
    echo -e "${RED}║  - Wallpaper: Google Photos -> Set as wallpaper            ║${NC}"
    echo -e "${RED}║  - Ringtone: Copy MP3 ke folder /Ringtones/                ║${NC}"
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
    echo -e "${GREEN}Menu Settings -> Personalization sudah bisa diakses lagi.${NC}"
}

# HAPUS SEMUA (tanpa Theme Manager) - 41 apps
remove_everything() {
    remove_xiaomi
    remove_facebook
    remove_microsoft
    remove_amazon
    remove_google
    remove_thirdparty
    echo -e "\n${GREEN}>> TOTAL 41 bloatware dihapus!${NC}"
    echo -e "${YELLOW}>> Theme Manager TIDAK dihapus (pilih menu [7] jika mau hapus)${NC}"
}

# RESTORE SEMUA (termasuk Theme Manager)
restore_everything() {
    restore_xiaomi
    restore_facebook
    restore_microsoft
    restore_amazon
    restore_google
    restore_thirdparty
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
    echo "  [1] Hapus Xiaomi/MIUI bloatware (19 apps)"
    echo "  [2] Hapus Facebook bloatware (3 apps)"
    echo "  [3] Hapus Microsoft bloatware (1 app)"
    echo "  [4] Hapus Amazon bloatware (1 app)"
    echo "  [5] Hapus Google apps (11 apps) - kecuali Play Store & Gmail"
    echo "  [6] Hapus Third-party pre-installed (6 apps) - WPS, iQIYI, dll"
    echo "  [7] Hapus Theme Manager (1 app) - BACA PERINGATAN"
    echo "  [8] Hapus SEMUA di atas KECUALI Theme Manager (41 apps)"
    echo ""
    echo -e "  ${CYAN}-- RESTORE --${NC}"
    echo "  [r] Restore Theme Manager"
    echo "  [a] Restore SEMUA aplikasi"
    echo ""
    echo "  [0] Keluar"
    echo ""
    echo -ne "${CYAN}Pilihan: ${NC}"
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
    echo -e "${CYAN}[1] Xiaomi/MIUI (19 apps):${NC}"
    echo "    Analytics, MSA, Mi Music, Mi Video, Mi Browser, GetApps,"
    echo "    Games, Mi Health, Mi Remote, dll (Gallery TIDAK dihapus)"
    echo ""
    echo -e "${CYAN}[2] Facebook (3 apps):${NC}"
    echo "    App Manager, Services, System"
    echo ""
    echo -e "${CYAN}[3] Microsoft (1 app):${NC}"
    echo "    Cross Device Service Broker"
    echo ""
    echo -e "${CYAN}[4] Amazon (1 app):${NC}"
    echo "    Amazon App Manager"
    echo ""
    echo -e "${CYAN}[5] Google (11 apps):${NC}"
    echo "    Chrome, Maps, Photos, YouTube, Meet, Docs,"
    echo "    Gemini AI, Wellbeing, YouTube Music, Google One, Google TV"
    echo ""
    echo -e "${CYAN}[6] Third-party Pre-installed (6 apps):${NC}"
    echo "    WPS Office, iQIYI, Story Matrix Drama,"
    echo "    Magic Sort Game, Flickr, Disney+ Hotstar"
    echo ""
    echo -e "${RED}[7] Theme Manager (1 app) - OPSIONAL:${NC}"
    echo "    Jika dihapus: Settings -> Personalization tidak bisa diklik"
    echo "    Pilihan ringtone/wallpaper sangat terbatas"
    echo ""
    echo -e "${GREEN}Yang TIDAK dihapus:${NC}"
    echo "    Play Store, Play Services, Gmail, MIUI Gallery"
    echo "    Mi Account, Find Device, Kamera, Screenshot"
    echo "    AI Vision, Scanner, Compass, FM Radio, Debug/Developer Tools"
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
                echo -e "${YELLOW}[!] Menghapus Xiaomi/MIUI bloatware (19 apps)...${NC}"
                remove_xiaomi
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
                remove_amazon
                show_summary
                ;;
            5)
                echo ""
                remove_google
                show_summary
                ;;
            6)
                echo ""
                remove_thirdparty
                show_summary
                ;;
            7)
                remove_theme
                show_summary
                ;;
            8)
                echo ""
                echo -e "${YELLOW}[!] Menghapus SEMUA bloatware (41 apps)...${NC}"
                remove_everything
                show_summary
                ;;
            r|R)
                echo ""
                restore_theme
                show_summary
                ;;
            a|A)
                echo ""
                echo -e "${YELLOW}[!] Restore semua aplikasi...${NC}"
                restore_everything
                show_summary
                ;;
            0)
                echo -e "\n${GREEN}Bye!${NC}\n"
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
