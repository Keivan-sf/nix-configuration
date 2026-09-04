{ pkgs, pkgs25 ? pkgs, ... }:

pkgs.stdenvNoCC.mkDerivation {
  pname = "godot-nvim";
  version = "0.1.0";

  src = ./run-nvim.sh;
  dontUnpack = true;

  installPhase = ''
    runHook preInstall

    install -Dm755 "$src" "$out/bin/godot-nvim"

#    substituteInPlace "$out/bin/godot-nvim" \
#      --replace-fail 'term_exec="kitty"' 'term_exec="${pkgs.kitty}/bin/kitty"' \
#      --replace-fail 'nvim_exec="nvim"' 'nvim_exec="${pkgs25.neovim}/bin/nvim"'

    install -d "$out/share/applications"
    cat > "$out/share/applications/godot-nvim.desktop" <<'EOF'
[Desktop Entry]
Version=1.0
Type=Application
Name=godot-nvim
Exec=godot-nvim
Terminal=false
Categories=Development;Utility;
EOF

    runHook postInstall
  '';

  meta.mainProgram = "godot-nvim";
}
