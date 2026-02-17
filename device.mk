#
# CircleOS — Xiaomi Redmi Note 12 4G (sky) Device Configuration
#
# MINIMUM SUPPORTED DEVICE — chosen for:
#   - Wide global availability (affordable reference hardware)
#   - Qualcomm Snapdragon 685 (SM6225, 6nm) — well-documented Linux support
#   - Active LineageOS community (proven driver availability)
#   - 6GB RAM — sufficient for CircleOS privacy services
#
# SoC: Qualcomm Snapdragon 685 (SM6225)
# RAM: 4GB/6GB LPDDR4X
# Display: 6.67" 1080×2400 AMOLED 120Hz
# Camera: 50MP main, 8MP ultrawide, 2MP macro
#

$(call inherit-product, device/circle/common/common.mk)

PRODUCT_NAME         := circle_redmi_note12
PRODUCT_DEVICE       := sky
PRODUCT_MODEL        := Circle Phone (Redmi Note 12)
PRODUCT_BRAND        := Circle
PRODUCT_MANUFACTURER := Xiaomi

# Device overlays
DEVICE_PACKAGE_OVERLAYS += device/circle/redmi_note12/overlay

# Snapdragon 685 kernel
TARGET_KERNEL_SOURCE  := kernel/xiaomi/sm6225
TARGET_KERNEL_CONFIG  := vendor/sky_defconfig

# Board
BOARD_VENDOR              := xiaomi
TARGET_BOARD_PLATFORM     := sm6225
TARGET_BOOTLOADER_BOARD_NAME := sky

# Verified boot
BOARD_AVB_ENABLE    := true
BOARD_AVB_ALGORITHM := SHA256_RSA4096
BOARD_AVB_KEY_PATH  := external/avb/test/data/testkey_rsa4096.pem

# Memory tuning for 6GB device
PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.low_ram=false \
    dalvik.vm.heapsize=512m \
    dalvik.vm.heapgrowthlimit=256m

# SoC properties
PRODUCT_PROPERTY_OVERRIDES += \
    ro.soc.manufacturer=Qualcomm \
    ro.soc.model=SM6225 \
    ro.circle.device.tier=midrange \
    ro.circle.device.codename=sky \
    ro.circle.device.min_supported=true

# Audio
AUDIO_FEATURE_ENABLED_MULTI_VOICE_SESSIONS := true
USE_XML_AUDIO_POLICY_CONF := 1

# NFC (optional on some variants — guarded at runtime)
PRODUCT_PACKAGES += \
    NfcNci \
    Tag

# Thermal HAL
PRODUCT_PACKAGES += \
    android.hardware.thermal@2.0-service

# Power HAL
PRODUCT_PACKAGES += \
    android.hardware.power-service

# WiFi (Qualcomm WLAN stack)
BOARD_WLAN_DEVICE             := qcwcn
BOARD_WPA_SUPPLICANT_DRIVER   := NL80211
WPA_SUPPLICANT_VERSION        := VER_0_8_X
BOARD_HOSTAPD_DRIVER          := NL80211

# Circle privacy service tuning for mid-range SoC
# Privacy daemons run at background priority to not impact foreground
PRODUCT_PROPERTY_OVERRIDES += \
    ro.circle.kernel.kaslr=true \
    ro.circle.kernel.seccomp=true \
    ro.circle.kernel.lockdown=false \
    ro.circle.perf.privacy_daemon_priority=background
