{
  lib,
  stdenv,
  fetchurl,
  unzip,
  makeWrapper,
  jre,
}:
stdenv.mkDerivation rec {
  pname = "pmd";
  version = "7.0.0-rc4";

  src = fetchurl {
    url = "https://github.com/pmd/pmd/releases/download/pmd_releases/${version}/pmd-dist-${version}-bin.zip";
    hash = "sha256-gcFcueh18MeI5CRuXwBBsd8bM5g7n2VVDuToxLKFVws=";
  };

  nativeBuildInputs = [unzip makeWrapper];

  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    runHook preInstall
    sed -i conf/* -e 's/defaultLogLevel=info/defaultLogLevel=error/'
    install -Dm755 bin/pmd $out/libexec/pmd
    install -Dm644 lib/*.jar -t $out/lib/pmd
    install -Dm644 conf/* -t $out/conf/

    wrapProgram $out/libexec/pmd \
        --prefix PATH : ${jre}/bin \
        --set LIB_DIR $out/lib/pmd

    for app in cpd designer cpd-gui ast-dump; do
        makeWrapper $out/libexec/pmd $out/bin/$app --argv0 $app --add-flags $app
    done
    # make PMD the check subcommand
    makeWrapper $out/libexec/pmd $out/bin/'pmd' --argv0 'check' --add-flags 'check'

    runHook postInstall
  '';

  meta = with lib; {
    description = "An extensible cross-language static code analyzer";
    homepage = "https://pmd.github.io/";
    changelog = "https://pmd.github.io/pmd-${version}/pmd_release_notes.html";
    platforms = platforms.unix;
    license = with licenses; [bsdOriginal asl20];
  };
}
