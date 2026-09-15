#!/usr/bin/env node

const fs = require("node:fs");
const os = require("node:os");
const path = require("node:path");
const codeforcesInputParser = require("./lib/get_input.ts");

const args = process.argv.slice(2);

function printUsage() {
  console.error("Usage: puzzletemp --name <puzzle-name> [--cf-source <html-file>]");
}

function getOption(argv: string[], option: string) {
  for (let i = 0; i < argv.length; i++) {
    const arg = argv[i];

    if (arg === option) {
      return argv[i + 1];
    }

    const optionWithEquals = `${option}=`;
    if (arg.startsWith(optionWithEquals)) {
      return arg.slice(optionWithEquals.length);
    }
  }

  return undefined;
}

function readCodeforcesSource(sourcePath: string) {
  return fs.readFileSync(path.resolve(process.cwd(), sourcePath), "utf8");
}

function writeCodeforcesInputs(puzzleDir: string, codeforcesSource: string) {
  const inputs = codeforcesInputParser.get_codeforces_inputs(codeforcesSource);

  inputs.forEach((input: string, index: number) => {
    fs.writeFileSync(path.join(puzzleDir, `input${index + 1}.txt`), input, {
      mode: 0o644,
    });
  });
}

const file_name = getOption(args, "--name");
const codeforcesSource =
  getOption(args, "--cf-srouce") ||
  getOption(args, "--cf-sourse") ||
  getOption(args, "--cf-source");

if (!file_name) {
  printUsage();
  process.exit(1);
}

if (
  file_name.includes("/") ||
  file_name.includes("\\") ||
  file_name === "." ||
  file_name === ".."
) {
  console.error("Puzzle name must be a single directory name.");
  process.exit(1);
}

const puzzlesRoot =
  process.env.PUZZLES_DIR || path.join(os.homedir(), "puzzles");
const puzzleDir = path.join(puzzlesRoot, file_name);
const templatePath = path.join(__dirname, "template.cpp");
const mainPath = path.join(puzzleDir, "main.cpp");
const runPath = path.join(puzzleDir, "run");

const runScript = `#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd -- "$(dirname -- "$0")" && pwd)"
cd "$script_dir"

g++ -std=c++17 -O2 -Wall -Wextra main.cpp -o solution
./solution "$@"
`;

fs.mkdirSync(puzzleDir, { recursive: true });
fs.copyFileSync(templatePath, mainPath);
fs.chmodSync(mainPath, 0o644);
fs.writeFileSync(runPath, runScript, { mode: 0o755 });
fs.chmodSync(runPath, 0o755);

if (codeforcesSource) {
  writeCodeforcesInputs(puzzleDir, readCodeforcesSource(codeforcesSource));
}

console.log(puzzleDir);
