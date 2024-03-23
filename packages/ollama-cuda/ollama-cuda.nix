{
  stdenv,
  ollama,
  lib,
}:
stdenv.mkDerivation rec {
  pname = "ollama-cuda";
  version = "${ollama.version}";

  meta = ollama.meta.override {
    maintainers = ollama.meta.maintainers ++ ["nixith"];
  };
}
