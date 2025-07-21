{ pkgs }:

pkgs.stdenvNoCC.mkDerivation rec {
  pname = "zira-code";
  version = "1.0.0";
  src = ./.;
  installPhase = ''
        mkdir -p $out/share/fonts/truetype/
    	cp -r $src/*.ttf $out/share/fonts/truetype
  '';
}
