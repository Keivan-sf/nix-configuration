{ pkgs ? import <nixpkgs> { } }:

pkgs.stdenv.mkDerivation rec {
  pname = "hiddify";
  version = "2.5.7";

  src = pkgs.fetchurl {
    url =
      "https://github.com/hiddify/hiddify-next/releases/download/v2.5.7/Hiddify-Debian-x64.deb";
    sha256 = "sha256-owknd1lCptl/o21mO2ruwk/e6vwAcWx20iAhXmtwWa4=";
  };

  nativeBuildInputs = [ pkgs.dpkg pkgs.patchelf pkgs.makeWrapper ];

  unpackPhase = "true";

  installPhase = ''
    mkdir -p $out
    dpkg -x $src ./tmp

    mkdir -p $out/bin
    cp ./tmp/usr/share/hiddify/hiddify $out/bin/

    mkdir -p $out/bin/data
    cp -r ./tmp/usr/share/hiddify/data/* $out/bin/data/

    mkdir -p $out/bin/lib
    cp -r ./tmp/usr/share/hiddify/lib/* $out/bin/lib/


    wrapProgram $out/bin/hiddify \
    --set LD_LIBRARY_PATH $out/lib:${
      pkgs.lib.makeLibraryPath buildInputs
    }:${pkgs.libayatana-appindicator}/lib

  '';

  buildInputs = with pkgs; [
    gdk-pixbuf
    glib
    gtk3
    harfbuzz
    at-spi2-atk
    cairo
    libkrb5
    pango
    dynamic-colors
    libayatana-appindicator
    libayatana-indicator
    ayatana-ido
    libdbusmenu
    libepoxy
    fontconfig
  ];
}
