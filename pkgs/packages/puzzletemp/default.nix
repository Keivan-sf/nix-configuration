{ lib, stdenvNoCC, makeWrapper, nodejs_22 }:

stdenvNoCC.mkDerivation {
  pname = "puzzletemp";
  version = "1.0.0";

  src = ./.;

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    runHook preInstall

    install -Dm644 index.ts "$out/share/puzzletemp/index.ts"
    install -Dm644 template.cpp "$out/share/puzzletemp/template.cpp"
    install -Dm644 lib/get_input.ts "$out/share/puzzletemp/lib/get_input.ts"

    makeWrapper ${lib.getExe nodejs_22} "$out/bin/puzzletemp" \
      --add-flags "$out/share/puzzletemp/index.ts"

    runHook postInstall
  '';

  meta = {
    description = "Create competitive programming puzzle templates";
    mainProgram = "puzzletemp";
  };
}
