{ lib, stdenv, fetchFromGitHub, makeWrapper, bash, tmux, fzf, findutils, gnugrep, procps, coreutils }:

stdenv.mkDerivation rec {
  pname = "tmux-sessionizer";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "theprimeagen";
    repo = pname;
    rev = "7edf8211e36368c29ffc0d2c6d5d2d350b4d729b";
    sha256 = "sha256-4QGlq/cLbed7AZhQ3R1yH+44gmgp9gSzbiQft8X5NwU=";
  };

  nativeBuildInputs = [ makeWrapper ];
  buildInputs = [ bash ];

  installPhase = ''
    mkdir -p $out/bin
    cp tmux-sessionizer $out/bin/tmux-sessionizer
    chmod +x $out/bin/tmux-sessionizer

    wrapProgram $out/bin/tmux-sessionizer \
      --prefix PATH : ${lib.makeBinPath [ 
        tmux
        fzf
        findutils
        gnugrep
        procps
        coreutils
      ]}
  '';

  meta = with lib; {
    description = "Tmux session manager with fuzzy finding";
    license = licenses.mit;
    platforms = platforms.unix;
    mainProgram = pname;
  };
}
