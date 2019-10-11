# macOS

1. Setup devkitpro & libnx
    - https://github.com/devkitPro/pacman/releases/download/devkitpro-pacman-1.0.1/devkitpro-pacman-installer.pkg
    - `sudo dkp-pacman -S switch-dev`
2. Setup Swift Cross-Toolchain (amd64): https://github.com/CSCIX65G/SwiftCrossCompilers
    - https://github.com/CSCIX65G/SwiftCrossCompilers/releases/download/5.1/Swift-arm64-5.1.0.pkg.zip
    - "swift build --destination /Library/Developer/Destinations/amd64-5.1.0-RELEASE.json"
