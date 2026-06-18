{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    # Build system
    python3
    perl
    pkg-config
    gnumake
    autoconf
    yasm
    nasm
    nodejs

    # Compiler
    clang
    llvmPackages.llvm
    llvmPackages.libclang
    rustc
    cargo
    rust-cbindgen

    # Libraries
    gtk3
    glib
    dbus
    pango
    cairo
    atk
    gdk-pixbuf
    xorg.libX11
    xorg.libXcomposite
    xorg.libXdamage
    xorg.libXext
    xorg.libXfixes
    xorg.libXrandr
    xorg.libXrender
    xorg.libXt
    xorg.libxcb
    xorg.libICE
    xorg.libSM
    libGL
    alsa-lib
    pulseaudio
    dbus-glib
    libnotify
    fontconfig
    freetype
    pipewire
    libxkbcommon

    # Linker
    lld

    # Other
    zip
    unzip
    which
    m4
    file
    wrapGAppsHook3
  ];

  shellHook = ''
    export MOZBUILD_STATE_PATH="$HOME/.mozbuild"
    export CC=clang
    export CXX=clang++
    export LIBCLANG_PATH="${pkgs.llvmPackages.libclang.lib}/lib"
    export BINDGEN_CFLAGS="-isystem ${pkgs.llvmPackages.libclang.lib}/lib/clang/${pkgs.llvmPackages.libclang.version}/include"
    export LD_LIBRARY_PATH="${pkgs.lib.makeLibraryPath [
      pkgs.stdenv.cc.cc.lib
      pkgs.gtk3
      pkgs.glib
      pkgs.pango
      pkgs.cairo
      pkgs.atk
      pkgs.gdk-pixbuf
      pkgs.dbus
      pkgs.dbus-glib
      pkgs.libGL
      pkgs.xorg.libX11
      pkgs.xorg.libXcomposite
      pkgs.xorg.libXdamage
      pkgs.xorg.libXext
      pkgs.xorg.libXfixes
      pkgs.xorg.libXrandr
      pkgs.xorg.libXrender
      pkgs.xorg.libXt
      pkgs.xorg.libxcb
      pkgs.alsa-lib
      pkgs.pulseaudio
      pkgs.pipewire
      pkgs.libxkbcommon
      pkgs.fontconfig
      pkgs.freetype
    ]}:$LD_LIBRARY_PATH"
    # Unset AS so Firefox configure uses clang (GNU as 2.44 chokes on -Wa, flags)
    unset AS
    echo "Arjuna build environment ready. Run: cd sources/firefox && ./mach build"
  '';
}
