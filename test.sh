#!/bin/bash

set -e

# Set PC to build using LineageOS 21 as base

# Run inside devspace, in the project folder
repo init -u https://github.com/LineageOS/android.git -b lineage-21.0 --git-lfs

# Clone our GSI Repo
git clone https://github.com/Veynamer/lineage_build_unified lineage_build_unified -b lineage-21-light && \
git clone https://github.com/AndyCGYan/lineage_patches_unified lineage_patches_unified -b lineage-21-light; \

# Start building ROM
bash lineage_build_unified/buildbot_unified.sh treble 64VS 64GN; \

# Print SHA256
sha256sum out/target/product/*/*.img"

# Pull generated img files
pull out/target/product/*/*.img

#Upload to Github Releases
#curl -sf https://raw.githubusercontent.com/Meghthedev/Releases/main/headless.sh | sh
