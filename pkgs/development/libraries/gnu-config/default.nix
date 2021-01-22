{ lib, stdenv, fetchurl }:

let
  rev = "e78c96e5288993aaea3ec44e5c6ee755c668da79";

  # Don't use fetchgit as this is needed during Aarch64 bootstrapping
  configGuess = fetchurl {
    url = "https://git.savannah.gnu.org/cgit/config.git/plain/config.guess?id=${rev}";
    sha256 = "sha256-TSLpYIDGSp1flqCBi2Sgg9IWDV5bcO+Hn2Menv3R6KU=";
  };
  configSub = fetchurl {
    url = "https://git.savannah.gnu.org/cgit/config.git/plain/config.sub?id=${rev}";
    sha256 = "sha256-DkCGDN/DE3phQ1GO/Ua5ZPPtp0Ya93PnW3yfSK8EV9s=";
  };
in stdenv.mkDerivation {
  pname = "gnu-config";
  version = "2020-05-04";

  buildCommand = ''
    mkdir -p $out
    cp ${configGuess} $out/config.guess
    cp ${configSub} $out/config.sub
  '';

  meta = with lib; {
    description = "Attempt to guess a canonical system name";
    homepage = "https://savannah.gnu.org/projects/config";
    license = licenses.gpl3;
    # In addition to GPLv3:
    #   As a special exception to the GNU General Public License, if you
    #   distribute this file as part of a program that contains a
    #   configuration script generated by Autoconf, you may include it under
    #   the same distribution terms that you use for the rest of that
    #   program.
    maintainers = [ maintainers.dezgeg ];
    platforms = platforms.all;
  };
}
