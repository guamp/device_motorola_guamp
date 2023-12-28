#!/bin/bash
#
# Copyright (C) 2016 The CyanogenMod Project
# Copyright (C) 2017-2020 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

set -e

export DEVICE=guamp
export DEVICE_COMMON=sm6225-common
export VENDOR=motorola

# Load extract_utils and do some sanity checks
MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "${MY_DIR}" ]]; then MY_DIR="${PWD}"; fi

ANDROID_ROOT="${MY_DIR}/../../.."

HELPER="${ANDROID_ROOT}/tools/extract-utils/extract_utils.sh"
if [ ! -f "${HELPER}" ]; then
    echo "Unable to find helper script at ${HELPER}"
    exit 1
fi
source "${HELPER}"

# Initialize the helper
setup_vendor "${DEVICE}" "${VENDOR}" "${ANDROID_ROOT}" false

# Warning headers and guards
write_headers

# The standard device blobs
write_makefiles "${MY_DIR}/proprietary-files.txt" true
write_makefiles "${MY_DIR}/proprietary-files-guamp.txt" true

write_rro_package "CarrierConfigOverlay" "com.android.carrierconfig" product
write_single_product_packages "CarrierConfigOverlay"

# Finish
write_footers
