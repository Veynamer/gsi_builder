#!/bin/bash

set -e

# Set Crave to build using LineageOS 21 as base
repo init -u https://github.com/accupara/los21.git -b lineage-21.0 --git-lfs --depth=1
crave set --projectID 1

# Run inside foss.crave.io devspace, in the project folder
# Remove existing local_manifests
crave run --no-patch -- "rm -rf .repo/local_manifests && \
# Initialize repo with specified manifest
# repo init -u https://github.com/RisingTechOSS/android -b fourteen --git-lfs ;\
repo init -u https://github.com/LineageOS/android.git -b lineage-21.0 --git-lfs
# Clone local_manifests repository
# git clone https://github.com/Veynamer/treble_manifest.git .repo/local_manifests -b 14 ;\

# Removals
rm -rf system/libhidl prebuilts/clang/host/linux-x86 prebuilt/*/webview.apk platform/external/python/pyfakefs platform/external/python/bumble external/chromium-webview/prebuilt/x86_64 platform/external/opencensus-java RisingOS_gsi patches device/phh/treble && \

# Sync the repositories
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags && \ 

# Clone our GSI Repo
git clone https://github.com/Veynamer/lineage_build_unified lineage_build_unified -b lineage-21-light && \
git clone https://github.com/AndyCGYan/lineage_patches_unified lineage_patches_unified -b lineage-21-light; \

# Start building ROM
bash lineage_build_unified/buildbot_unified.sh treble 64VS 64GN; \

# Print out/build_date.txt
cat out/build_date.txt; \

# Print SHA256
sha256sum out/target/product/*/*.img"

# Clean up
# rm -rf tissot/*

# Pull generated zip files
# crave pull out/target/product/*/*.zip 

# Pull generated img files
crave pull out/target/product/*/*.img

# Upload zips to Telegram
# telegram-upload --to sdreleases tissot/*.zip

#Upload to Github Releases
#curl -sf https://raw.githubusercontent.com/Meghthedev/Releases/main/headless.sh | sh
