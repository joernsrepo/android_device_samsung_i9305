#
# Copyright (C) 2013 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

LOCAL_PATH := device/samsung/i9305

# Overlay
DEVICE_PACKAGE_OVERLAYS += $(LOCAL_PATH)/overlay

# This device is xhdpi.  However the platform doesn't
# currently contain all of the bitmaps at xhdpi density so
# we do this little trick to fall back to the hdpi version
# if the xhdpi doesn't exist.
PRODUCT_AAPT_CONFIG := normal hdpi xhdpi
PRODUCT_AAPT_PREF_CONFIG := xhdpi

# Init files
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/fstab.smdk4x12:root/fstab.smdk4x12 \
    $(LOCAL_PATH)/rootdir/init.target.rc:root/init.target.rc \
    $(LOCAL_PATH)/rootdir/ueventd.smdk4x12.rc:root/ueventd.smdk4x12.rc

# Audio
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/tiny_hw.xml:system/etc/sound/m3

# Camera
PRODUCT_PACKAGES += \
    camera.smdk4x12

# Product specific Packages
PRODUCT_PACKAGES += \
    DeviceSettings

# NFC
PRODUCT_PACKAGES += \
    nfc.exynos4 \
    libnfc \
    libnfc_jni \
    Nfc \
    Tag

# RIL
PRODUCT_PACKAGES += \
    libsecril-client \
    libsecril-client-sap

PRODUCT_PROPERTY_OVERRIDES += \
    mobiledata.interfaces=pdp0,gprs,ppp0,rmnet0,rmnet1

# Sensors
PRODUCT_PACKAGES += \
    sensors.smdk4x12

PRODUCT_COPY_FILES += \
    frameworks/base/nfc-extras/com.android.nfc_extras.xml:system/etc/permissions/com.android.nfc_extras.xml \
    frameworks/native/data/etc/android.hardware.nfc.xml:system/etc/permissions/android.hardware.nfc.xml

# NFCEE access control
ifeq ($(TARGET_BUILD_VARIANT),user)
    NFCEE_ACCESS_PATH := $(LOCAL_PATH)/configs/nfcee_access.xml
else
    NFCEE_ACCESS_PATH := $(LOCAL_PATH)/configs/nfcee_access_debug.xml
endif

PRODUCT_COPY_FILES += \
    $(NFCEE_ACCESS_PATH):system/etc/nfcee_access.xml

PRODUCT_PACKAGES += \
    com.android.nfc_extras

# These are the hardware-specific features
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
    frameworks/native/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml

# Media config
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/media/media_codecs.xml:system/etc/media_codecs.xml \
    $(LOCAL_PATH)/media/media_codecs_performance.xml:system/etc/media_codecs_performance.xml \
    $(LOCAL_PATH)/media/media_profiles.xml:system/etc/media_profiles.xml

# Configure dalvik heap
$(call inherit-product, frameworks/native/build/phone-xhdpi-2048-dalvik-heap.mk)

# Include device blobs first
$(call inherit-product, vendor/samsung/i9305/i9305-vendor.mk)

# Include common makefile
$(call inherit-product, device/samsung/smdk4412-common/common.mk)
$(call inherit-product, device/samsung/smdk4412-qcom-common/common.mk)

# HAL
PRODUCT_PACKAGES += \
android.hardware.power@1.0-impl \
android.hardware.audio@2.0-impl \
android.hardware.audio.effect@2.0-impl \
ndroid.hardware.audio@2.0-service \
android.hardware.soundtrigger@2.0-impl \
android.hardware.broadcastradio@1.0-impl \
android.hardware.keymaster@3.0-impl \
android.hardware.keymaster@3.0-service \
android.hardware.bluetooth@1.0-impl \
android.hardware.bluetooth@1.0-service \
android.hardware.camera.provider@2.4-impl \
android.hardware.camera.provider@2.4-service \
camera.device@3.2-impl \
android.hardware.light@2.0-impl \
android.hardware.usb@1.0-service \
android.hardware.wifi@1.0 \
android.hardware.wifi@1.0-impl \
android.hardware.wifi@1.0-service \
android.hardware.vibrator@1.0-impl \
android.hardware.drm@1.0-impl \
wificond \
wifilogd \
wifiloader \
android.hardware.gnss@1.0-impl \
android.hardware.health@1.0-impl \
android.hardware.gatekeeper@1.0-impl \
android.hardware.renderscript@1.0-impl \
android.hardware.dumpstate@1.0-service \
android.hidl.allocator@1.0-impl

# Memtrack HIDL Interfaces
PRODUCT_PACKAGES += \
android.hardware.memtrack@1.0-impl

# Configstore
PRODUCT_PACKAGES += \
android.hardware.configstore@1.0-impl
