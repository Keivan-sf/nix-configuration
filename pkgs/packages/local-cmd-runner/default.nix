{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  fetchPnpmDeps,
  makeWrapper,
  nodejs_22,
  pnpm,
  pnpmConfigHook,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "local-cmd-runner";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "Keivan-sf";
    repo = "local-cmd-runner";
    rev = "9716c43a67dfa85bc54bbbe951b1fb7fac927cb6";
    hash = "sha256-7tdZIQOo1X/C8L/iV/mRgavDqZUYNxdyX+M7pcmMlok=";
  };

  pnpmDeps = fetchPnpmDeps {
    inherit (finalAttrs) pname version src;
    pnpm = pnpm;
    fetcherVersion = 3;
    hash = "sha256-/66jzYlF3RgQHOB/YbgEFgx0C/t7B5+xN60/8VC+3bY=";
  };

  nativeBuildInputs = [
    makeWrapper
    nodejs_22
    pnpm
    pnpmConfigHook
  ];

  buildPhase = ''
    runHook preBuild

    pnpm run build

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    install -Dm755 dist/local-cmd-runner.js "$out/lib/local-cmd-runner/local-cmd-runner.js"

    makeWrapper ${lib.getExe nodejs_22} "$out/bin/local-cmd-runner" \
      --add-flags "$out/lib/local-cmd-runner/local-cmd-runner.js"

    runHook postInstall
  '';

  meta = {
    description = "Local HTTP endpoint for running configured local commands";
    mainProgram = "local-cmd-runner";
  };
})
