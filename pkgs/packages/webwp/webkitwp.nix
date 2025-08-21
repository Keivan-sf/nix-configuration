{ pkgs ? import <nixpkgs> { } }:

pkgs.stdenv.mkDerivation {
  pname = "webwp";
  version = "0.1.0";

  src = pkgs.fetchFromGitHub {
    owner = "keivan-sf";
    repo = "webkit-wallpaper";
    rev = "4991f3a844737ed8a57c6c71ca4f825a7de760cd";
    sha256 =
      "sha256-ynGzRecfRk9MiHXFBsnV8Xrr0OtWGNgUQfMnAQOLCJk="; # <-- fill with nix-prefetch result
  };

  nativeBuildInputs = with pkgs; [
    pkg-config
    gobject-introspection
    pkgs.makeWrapper
  ];

  buildInputs = with pkgs; [
    at-spi2-atk
    atkmm
    cairo
    gdk-pixbuf
    glib
    gtk3
    harfbuzz
    librsvg
    libsoup_3
    pango
    # webkitgtk_4_1
    webkitgtk_4_0
    openssl
    xorg.libX11
    xorg.libXext
  ];

  buildPhase = ''
    runHook preBuild

    cc ./webkit_rp2.c -o webwp \
      $(pkg-config --cflags --libs gtk+-3.0 pangocairo x11 xext webkit2gtk-4.0)

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall


    mkdir -p $out/bin
    cp webwp $out/bin/

    wrapProgram $out/bin/webwp \
      --set WEBKIT_DISABLE_DMABUF_RENDERER 1

    runHook postInstall
  '';
}
