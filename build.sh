#!/bin/bash

set -e

# Initialize repo with specified manifest
 repo init -u https://github.com/DerpFest-AOSP/manifest.git -b 13 --depth=1

# Run inside foss.crave.io devspace, in the project folder
# Remove existing local_manifests
crave run --no-patch -- "rm -rf .repo/local_manifests && \
# Initialize repo with specified manifest
repo init -u https://github.com/DerpFest-AOSP/manifest.git -b 13 --depth=1 ;\

# Clone local_manifests repository
manifest.xml .repo/local_manifests/aosp.xml ;\

# Sync the repositories
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags && \ 

bash patches/apply-patches.sh . && \

# Set up build environment
cd device/phh/treble
cp ../../../derp.mk . \
bash generate.sh derp && \
cd ../../..

source build/envsetup.sh && \
mkdir -p ./GSI

# Build TrebleApp
cd treble_app
bash build.sh release
cp TrebleApp.apk ../vendor/hardware_overlay/TrebleApp/app.apk

# Lunch configuration
lunch treble_arm64_bgN-userdebug ;\

croot ;\
make installclean -j$(nproc --all)
make systemimage -j$(nproc --all) ; \
echo "Date and time:" ; \

# Print out/build_date.txt
cat out/build_date.txt; \

# Print SHA256
sha256sum out/target/product/*/*.img"

# Clean up
# rm -rf tissot/*



# Pull generated zip files
# crave pull out/target/product/*/*.zip 

# Pull generated img files
# crave pull out/target/product/*/*.img

# Upload zips to Telegram
# telegram-upload --to sdreleases tissot/*.zip

#Upload to Github Releases
#curl -sf https://raw.githubusercontent.com/Meghthedev/Releases/main/headless.sh | sh
